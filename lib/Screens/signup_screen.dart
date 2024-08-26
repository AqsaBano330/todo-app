import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todoapp/Screens/login_screen.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/widgets/custom_button.dart';
import 'package:todoapp/widgets/custom_text.dart';
import 'package:todoapp/widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController conpasscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Function to show error messages in a SnackBar
    showErrorMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }

    // Function to sign up with email and password
    signup() async {
      if (passcontroller.text.toString().trim() ==
          conpasscontroller.text.toString().trim()) {
        try {
          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailcontroller.text.toString().trim(),
            password: passcontroller.text.toString().trim(),
          );

          print(credential.user!.uid);
          print(credential.user!.email);

          DocumentReference signupdetail = FirebaseFirestore.instance.collection("users").doc(credential.user!.uid);

          signupdetail.set({
            "uid": credential.user!.uid,
            "firstname": firstnamecontroller.text.toString().trim(),
            "lastname": lastnamecontroller.text.toString().trim(),
            "email": credential.user!.email,
          });
          showErrorMessage("Account Created");
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            showErrorMessage("The password provided is too weak");
          } else if (e.code == 'email-already-in-use') {
            showErrorMessage("The account already exists for that email.");
          }
        } catch (e) {
          showErrorMessage("Try Again");
        }
      } else {
        showErrorMessage("Password is not the same");
      }
    }

    // Function to sign in with Google
    signInWithGoogle() async {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if (gUser != null) {
        final GoogleSignInAuthentication gAuth = await gUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );

        try {
          final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
          final User? user = userCredential.user;
          if (user != null) {
            // User has been signed in with Google.
            // You can add additional code to handle this case.
          }
        } catch (e) {
          showErrorMessage("Google Sign-In Failed");
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50, bottom: 30),
                  child: CustomText(
                    text: "Sign Up",
                    textColor: AppColors.themecolor,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: CustomTextField(
                    controller: firstnamecontroller,
                    obscuretext: false,
                    label: "First Name",
                    hinttext: "Enter Your First Name",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: CustomTextField(
                    controller: lastnamecontroller,
                    obscuretext: false,
                    label: "Last Name",
                    hinttext: "Enter Your Last Name",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: CustomTextField(
                    controller: emailcontroller,
                    obscuretext: false,
                    label: "Email",
                    hinttext: "Enter Your Email",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: CustomTextField(
                    controller: passcontroller,
                    obscuretext: true,
                    label: "Password",
                    hinttext: "Enter Your Password",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: CustomTextField(
                    controller: conpasscontroller,
                    obscuretext: true,
                    label: "Confirm Password",
                    hinttext: "Confirm Password",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const CustomText(
                          text: "SignIn with",
                          textColor: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          signInWithGoogle();
                        },
                        icon: const FaIcon(FontAwesomeIcons.google),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  buttontext: "SignUp",
                  onpressed: () {
                    signup();
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: "Already have an account?  ",
                        textColor: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          child: CustomText(
                            text: "Signin",
                            textColor: AppColors.themecolor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

