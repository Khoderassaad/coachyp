import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:coachyp/features/auth/presentation/pages/User_sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool _obscureText = true;
  String? emailError;
  String? passwordError;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          SizedBox(
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
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildLabel("EMAIL"),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: " ENTER YOUR EMAIL",
                              errorText: emailError,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return 'Please enter your EMAIL';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        buildLabel("PASSWORD"),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "ENTER YOUR PASSWORD",
                                  errorText: passwordError,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)))
                              .copyWith(
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
                            } else if (int.parse(value) != null) {
                              return 'enter your real email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10), // Added const
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [],
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
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              if (email.text.isEmpty) {
                                emailError =
                                    "This can't be empty"; // Set error message for email
                              } else {
                                emailError =
                                    null; // Clear error if the input is valid
                              }

                              if (password.text.isEmpty) {
                                passwordError =
                                    "This can't be empty"; // Set error message for password
                              } else {
                                passwordError = null;
                              }
                            });

                            if (emailError == null && passwordError == null) {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text,

                                );

                                if (credential.user!.emailVerified) {
                                  Navigator.of(context)
                                    .pushReplacementNamed("HomePage");
                                }
                                else{
                                  await AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: 'Please verify your Email',
                                ).show();
                                }
                              } on FirebaseAuthException catch (e) {
                                await AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: 'Email or Password is invalid',
                                ).show();
                              }
                            }
                          },

                          
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),

                          child: ShaderMask(
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
                        ),
                        const SizedBox(
                          height: 15,
                        ),
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
                                    fontSize: 20,
                                    fontFamily: 'Jersey15'),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed("sign_up");
                              },
                              child: const Text(
                                "SIGN UP",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.s2),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 10),
                        const Divider(
                          color: Colors.white,
                          indent: 80,
                          endIndent: 80,
                        ),
                        SizedBox(height: 5,),
                        Center(
                          child: ShaderMask(
                            shaderCallback: (bounds) {
                              return myLinearGradient().createShader(bounds);
                            },
                            child: const Text(
                              // Added const
                              " OR ",
                              style: TextStyle(
                                  color: Colors.amberAccent,
                                  fontSize: 19,
                                  fontFamily: 'Jersey15'),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        const Divider(
                          color: Colors.white,
                          indent: 80,
                          endIndent: 80,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(FontAwesomeIcons.google),
                                SizedBox(width: 10),
                                Text(
                                  "SIGN IN WITH GOOGLE ?",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
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
