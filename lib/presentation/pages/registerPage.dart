import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafsakaos_app/presentation/widgets/myButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rafsakaos_app/presentation/widgets/myTextfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void createUser(String userId, String username) {
    final newUser = {
      'Nama': username,
      'timestamp': DateTime.now().microsecondsSinceEpoch,
      'uid': userId,
    };
    FirebaseFirestore.instance.collection('username').doc(userId).set(newUser);
  }

  void register() async {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      if (confirmPasswordController.text == passwordController.text) {
        final UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        final User? user = userCredential.user;
        if (user != null) {
          // Use the user ID as document ID for storing user data
          createUser(user.uid, usernameController.text);
        }
        if (!mounted) return;
        Navigator.pop(context); // Close loading dialog
        // Optionally, you can navigate to another screen upon successful registration
      } else {
        // Show error message
        showErrorMessage('password-mismatch');
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      Navigator.pop(context); // Close loading dialog
      // Display error message
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String errorCode) {
    String errorMessage;
    switch (errorCode) {
      case 'email-already-in-use':
        errorMessage = 'Email is already in use. Please use a different email.';
        break;
      case 'invalid-email':
        errorMessage = 'Invalid email address. Please enter a valid email.';
        break;
      case 'weak-password':
        errorMessage = 'Password is too weak. Please use a stronger password.';
        break;
      case 'password-mismatch':
        errorMessage =
            'Passwords do not match. Please enter matching passwords.';
        break;
      default:
        errorMessage = 'An unexpected error occurred. Please try again later.';
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color white
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Title
                  Text(
                    'Papipakonveksi',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Create Account Text
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Username Field
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),

                  // Email Field
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),

                  // Password Field
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),

                  // Confirm Password Field
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),

                  // Register Button
                  MyButton(
                    text: 'Register',
                    onTap: register,
                  ),
                  const SizedBox(height: 20),

                  // OR Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('atau'),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sudah punya akun? '),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
