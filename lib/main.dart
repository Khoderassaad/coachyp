import 'package:coachyp/Pages/HomePage.dart';
// import 'package:coachyp/Pages/firebasenotf.dart'; // Remove if not used elsewhere
import 'package:coachyp/Stripe_Payment/Stripe_keys.dart';
import 'package:coachyp/features/auth/presentation/pages/login.dart';
import 'package:coachyp/features/auth/presentation/pages/User_sign_up.dart';
import 'package:coachyp/features/auth/presentation/pages/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Import local notifications
import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase/firebase_options.dart'; // Ensure this path is correct

// --- FCM Background Handler ---
// Must be a top-level function (outside of any class)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, make sure you call initializeApp
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Often needed if accessing other Firebase services
  // NOTE: Firebase.initializeApp() might already be called by the flutterfire plugin's native side.
  // Only uncomment the above if you get errors accessing Firebase services here.

  print("Handling a background message: ${message.messageId}");
  print('Message data: ${message.data}');
  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
  // Add any background processing logic here (e.g., saving data)
  // Avoid UI logic here.
  // If you want to SHOW a notification for DATA messages received in background,
  // you might need to use flutter_local_notifications here as well.
}

// --- Flutter Local Notifications Setup (Optional but Recommended for Foreground) ---
/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

bool _isFlutterLocalNotificationsInitialized = false;

Future<void> _setupFlutterLocalNotifications() async {
  if (_isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  _isFlutterLocalNotificationsInitialized = true;
}

/// Shows a local notification using flutter_local_notifications
void _showLocalNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  // If `onMessage` is triggered with a notification, construct our own
  // local notification to show to users using the created channel.
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background', // ensure you have this drawable resource
          // other properties...
        ),
        // iOS details can be added here if needed
        // iOS: const DarwinNotificationDetails(),
      ),
      // You can add payload data to handle taps on the local notification
      // payload: jsonEncode(message.data), // Example: Pass message data
    );
  }
}


// --- Main Entry Point ---
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set the background messaging handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Setup local notifications (for foreground display) if not on web
  if (!kIsWeb) {
    await _setupFlutterLocalNotifications();
  }

  // Set Stripe only for mobile platforms (not web)
  if (!kIsWeb) {
    Stripe.publishableKey = ApiKeys.publishableKey; // Make sure ApiKeys is imported correctly
    await Stripe.instance.applySettings();
  }

  runApp(const COACHY());
}

// --- App Widget ---
class COACHY extends StatefulWidget {
  const COACHY({super.key});

  @override
  State<COACHY> createState() => _COACHYState();
}

class _COACHYState extends State<COACHY> {
  @override
  void initState() {
    super.initState();
    _setupFCM(); // Call the setup function for FCM
    _listenAuthChanges(); // Keep your auth listener
  }

  void _listenAuthChanges() {
     FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        // Optionally, re-fetch/re-register token if needed after sign-in
        // getFCMToken();
      }
    });
  }

  // --- FCM Setup Logic ---
  Future<void> _setupFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // 1. Request Permissions (iOS and Android 13+)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false, // Set to true for provisional permissions on iOS (silent)
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
      // Handle the case where permission is denied (e.g., show a message)
    }

    // 2. Get FCM Token
    await getFCMToken();

    // 3. Listen to Foreground Messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        // Use flutter_local_notifications to SHOW the notification
        if (!kIsWeb) {
          _showLocalNotification(message);
        }
      }
    });

    // 4. Handle Notification Tapped (App in Background/Terminated -> Opened)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked! App was opened from background/terminated.');
      print('Message data: ${message.data}');
      // TODO: Navigate to a specific screen based on message data
      // Example:
      // if (message.data['screen'] == 'profile') {
      //   Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProfileScreen()));
      // }
    });

    // 5. Handle Initial Message (App Terminated -> Opened)
    // Check if the app was launched from a terminated state by tapping the notification
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
       print('App opened from terminated state via notification!');
       print('Initial Message data: ${initialMessage.data}');
       // TODO: Handle navigation or data processing after the first frame
       // WidgetsBinding.instance.addPostFrameCallback((_) {
       //    // Navigate based on initialMessage.data
       // });
    }
  }

  // --- Get/Refresh FCM Token ---
  Future<void> getFCMToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    // You can specify VAPID key for web push notifications
    // String? token = await messaging.getToken(vapidKey: "YOUR_WEB_VAPID_KEY"); // Add your VAPID key if using web
    String? token = await messaging.getToken();

    print("FCM Token: $token");
    // ** VERY IMPORTANT **
    // Send this token to your backend server and associate it with the logged-in user!
    // This is how you will target specific devices for notifications.
    // Example: sendTokenToServer(token);

    // Listen for token refresh
    messaging.onTokenRefresh.listen((newToken) {
      print("FCM Token Refreshed: $newToken");
      // ** VERY IMPORTANT **
      // Send the newToken to your backend server as well!
      // Example: sendTokenToServer(newToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        // Consider if you need the delay AND the auth check.
        // Maybe just check auth state directly? Or use a dedicated splash screen widget.
        future: Future.delayed(const Duration(seconds: 2)), // Splash duration
        builder: (context, snapshot) {
          // Show splash screen while waiting for the delay OR initial auth check
          if (snapshot.connectionState != ConnectionState.done) {
             // Consider showing a proper Splash Screen Widget here instead of Welcome
            return const Welcome();
          }

          // Check auth state *after* splash duration or potential initial check
          final user = FirebaseAuth.instance.currentUser;

          // Decide initial route based on auth state
          // IMPORTANT: Ensure HomePage and Login are correctly set up to handle potential
          // navigation triggered by FCM messages if needed immediately on launch.
          if (user != null && user.emailVerified) { // Or just user != null depending on your logic
            return HomePage();
          } else {
            return Login();
          }
        },
      ),
      // Define routes for navigation
      routes: {
        // Ensure these keys match any Navigator.pushNamed calls
        "sign_up": (context) => const ClientSignUp(),
        "HomePage": (context) => const HomePage(),
        "Login": (context) => const Login(),
        // Add other routes as needed
      },
      // Optional: Define a navigator key if you need to navigate from outside
      // the widget tree (e.g., sometimes needed from notification handlers,
      // though direct navigation from background handler is complex).
      // navigatorKey: GlobalKey<NavigatorState>(),
    );
  }
}