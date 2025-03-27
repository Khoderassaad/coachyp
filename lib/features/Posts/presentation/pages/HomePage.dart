import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../auth/presentation/widgets/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: AppColors.primary,
      body: 
      
      
      
      Padding(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          
          children: [
           
            Padding(
              padding: const EdgeInsets.all(8.0),
              
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.person),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return myLinearGradient().createShader(bounds);
                      },
                      child: const Text(
                        " COACHY ",
                        style: TextStyle(
                            color: Colors.amberAccent,
                            fontSize: 50,
                            fontFamily: 'Jersey15'),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.notification_add)),
                    ],
                  )
                ],
              ),
            ),
            
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () async {
      //       await FirebaseAuth.instance.signOut();
      //       Navigator.of(context)
      //           .pushNamedAndRemoveUntil("Login", (Route) => false);
      //     },
      //     child: Icon(Icons.exit_to_app_rounded)),
      
    @override
  Widget build(BuildContext context) {
    /// [AnnotatedRegion<SystemUiOverlayStyle>] only for android black navigation bar. 3 button navigation control (legacy)

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        // backgroundColor: Colors.grey,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.bookmark_rounded,
                size: 56,
                color: Colors.amber[400],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.favorite_rounded,
                size: 56,
                color: Colors.red[400],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.email_rounded,
                size: 56,
                color: Colors.green[400],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.folder_rounded,
                size: 56,
                color: Colors.blue[400],
              ),
            ),
          ],
        ),
        bottomNavigationBar: WaterDropNavBar(
          backgroundColor: navigationBarColor,
          onItemSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
          },
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              filledIcon: Icons.bookmark_rounded,
              outlinedIcon: Icons.bookmark_border_rounded,
            ),
            BarItem(
                filledIcon: Icons.favorite_rounded,
                outlinedIcon: Icons.favorite_border_rounded),
            BarItem(
              filledIcon: Icons.email_rounded,
              outlinedIcon: Icons.email_outlined,
            ),
            BarItem(
              filledIcon: Icons.folder_rounded,
              outlinedIcon: Icons.folder_outlined,
            ),
          ],
        ),
      ),
    );
  }

      
    );
    
  }
}
