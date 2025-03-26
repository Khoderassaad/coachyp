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
      body: Padding(
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
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil("Login", (Route) => false);
          },
          child: Icon(Icons.exit_to_app_rounded)),
    );
  }
}
