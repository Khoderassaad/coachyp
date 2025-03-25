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
        child: Container(
          height: 800,
          width: 400,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.photo),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return myLinearGradient().createShader(bounds);
                      },
                      child: const Text(
                        " COACHY ",
                        style: TextStyle(
                            color: Colors.amberAccent,
                            fontSize: 40,
                            fontFamily: 'Jersey15'),
                      ),
                    ),
                    Row(
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
