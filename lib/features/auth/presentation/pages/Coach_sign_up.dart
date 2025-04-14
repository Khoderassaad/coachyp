import 'package:coachyp/features/auth/data/model/repositories_impl/auth_repository_impl.dart';
import 'package:coachyp/features/auth/domain/Enteties/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../../colors.dart';

import '../../domain/usecases/register_user.dart';

class CoachSignUp extends StatefulWidget {
  const CoachSignUp({super.key});

  @override
  State<CoachSignUp> createState() => _CoachSignUpState();
}

class _CoachSignUpState extends State<CoachSignUp> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController Name = TextEditingController();
  bool obscureText1 = true;
  bool obscureText2 = true;
  String? confirmPasswordError;

  final _formKey = GlobalKey<FormState>();
  String? emailError;
  String? passwordError;

  @override
  int _selectedButtonIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          SizedBox(
            height: 173,
            width: 600,
            child: Image.asset(
              "assets/image/spart-club.jpg",
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedButtonIndex = 0;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.resolveWith<Color>((states) {
                      if (_selectedButtonIndex == 0) {
                        return Colors.grey;
                      }
                      return Colors.white;
                    }),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    minimumSize:
                        WidgetStateProperty.all<Size>(const Size(150, 50)),
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                    ),
                  ),
                  child: buildLabel("become a\n   client"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedButtonIndex = 1;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.resolveWith<Color>((states) {
                      if (_selectedButtonIndex == 1) {
                        return Colors.grey;
                      }
                      return Colors.white;
                    }),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    minimumSize:
                        WidgetStateProperty.all<Size>(const Size(150, 50)),
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                    ),
                  ),
                  child: buildLabel("become a \n   coach"),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildLabel("Name"),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: Name,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "  Enter Your Name",
                              
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                        const SizedBox(height: 5),
                        buildLabel("Email"),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "  Your Email",
                              errorText: emailError,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter an email";
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                .hasMatch(value)) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 5),
                        buildLabel("Password"),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Enter Your Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)))
                              .copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText1
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText1 = !obscureText1;
                                });
                              },
                            ),
                          ),
                          obscureText: obscureText1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        buildLabel("Confirme Password"),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Retype Your Password",
                                  errorText: confirmPasswordError,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)))
                              .copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText2 = !obscureText2;
                                });
                              },
                            ),
                          ),
                          obscureText: obscureText2,
                        ),
                        const SizedBox(height: 20), // Added const

                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              // Email validation using a regular expression
                              final emailRegExp = RegExp(
                                  r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                              if (!emailRegExp.hasMatch(email.text)) {
                                emailError =
                                    "Enter a valid email"; // Set error message for email
                              } else {
                                emailError = null; // Clear email error if valid
                              }

                              // Password confirmation validation
                              if (password.text !=
                                  confirmPasswordController.text) {
                                confirmPasswordError =
                                    "Passwords do not match"; // Set error message for password confirmation
                              } else {
                                confirmPasswordError =
                                    null; // Clear error if passwords match
                              }
                            });

                            // Proceed only if there are no validation errors
                            if (emailError == null &&
                                confirmPasswordError == null) {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text,
                                );
                                 FirebaseAuth.instance.currentUser!.sendEmailVerification();
                                Navigator.of(context)
                                    .pushReplacementNamed("Login");
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  print('The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  await AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: 'Account already exist',
                                ).show();
                                }
                              } catch (e) {
                                print(e);
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
                              " Sign up ",
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        ),

                        const SizedBox(height: 5),

                        const Divider(
                          color: Colors.white,
                          indent: 80,
                          endIndent: 80,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) {
                  return myLinearGradient().createShader(bounds);
                },
                child: const Text(
                  " Already have an account ?",
                  style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 20,
                      fontFamily: 'Jersey15'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed("sign_up");
                },
                child: const Text(
                  "Go back",
                  style: TextStyle(
                      color: AppColors.s2, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}