import 'package:coachyp/features/auth/presentation/pages/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../blocs/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isChecked = false;
  bool _obscureText = true;

@override
  // void initState() {
  //   FirebaseAuth.instance
  // .authStateChanges()
  // .listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          Container(
              height: 300,
              child: Image.asset(
                "assets/image/spart-club.jpg",
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          SingleChildScrollView( 
            child: Column(
              children: [
                
                const SizedBox(height: 15), 
                ShaderMask(
                  shaderCallback: (bounds) {
                    return myLinearGradient().createShader(bounds);
                  },
                  child: const Text( 
                    " LOGIN ",
                    style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 40,
                        fontFamily: 'Jersey15'),
                  ),
                ),
                const SizedBox(height: 20), 
                Padding( 
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildLabel("EMAIL"), 
                        const SizedBox(height: 6), 
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            fillColor: Colors.white, 
                            filled: true,
                           hintText: " ENTER YOUR EMAIL",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                          ), 
           
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your EMAIL';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 17), 
                        buildLabel("PASSWORD"), 
                        const SizedBox(height: 6), 
                        TextFormField(
                          controller: _passwordController,
                          decoration: 
                          InputDecoration(
                            fillColor: Colors.white, 
                            filled: true,
                            hintText: "ENTER YOUR PASSWORD",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          )).copyWith( 
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          obscureText: _obscureText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            else if (int.parse(value)!=null){
                              return 'enter your real email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10), // Added const
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.9,
                                  child: Checkbox(
                                    value: _isChecked,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        _isChecked = newValue!;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 4), // Added const
                                ShaderMask(
                                  shaderCallback: (bounds) {
                                    return myLinearGradient().createShader(bounds);
                                  },
                                  child: const Text( // Added const
                                    "Remember me",
                                    style: TextStyle(
                                      color: Colors.amberAccent,
                                      fontSize: 21,
                                      fontFamily: 'Jersey15',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ShaderMask(
                              shaderCallback: (bounds) {
                                return myLinearGradient().createShader(bounds);
                              },
                              child: GestureDetector(
                                onTap: () {},
                                child: const Text( 
                                  "FORGOT PASSWORD?",
                                  style: TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 17,
                                    fontFamily: 'Jersey15',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                         SizedBox(height: 10), 
                        ElevatedButton(
                          onPressed: () {},
                          child:  ShaderMask(
                            shaderCallback: (bounds) {
                              return myLinearGradient().createShader(bounds);
                            },
                            child: const Text( 
                              " LOGIN ",
                              style: TextStyle(
                                  color: Colors.amberAccent,
                                  fontSize: 25,
                                  fontFamily: 'Jersey15'),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          ShaderMask(
                    shaderCallback: (bounds) {
                      return myLinearGradient().createShader(bounds);
                    },
                    child: const Text( 
                      " Do not have an account ?  ",
                      style: TextStyle(
                          color: Colors.amberAccent,
                          fontSize: 16,
                          fontFamily: 'Jersey15'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Sign_in()),
                          );
                    },
                    child: Text("SIGN UP"),
                  )
                        ],),
          
                         SizedBox(height: 10),
                         Center(child:ShaderMask(
                            shaderCallback: (bounds) {
                              return myLinearGradient().createShader(bounds);
                            },
                            child: const Text( // Added const
                              " OR ",
                              style: TextStyle(
                                  color: Colors.amberAccent,
                                  fontSize: 19,
                                  fontFamily: 'Jersey15'),
                            ),
                          ),), 
                         SizedBox(height: 15,),
                        ElevatedButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(FontAwesomeIcons.google), 
                                const SizedBox(width: 10), 
                                const Text( 
                                  "SIGN IN WITH GOOGLE ?",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 

  
}