import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rafsakaos_app/presentation/pages/registerPage.dart';
import 'package:rafsakaos_app/presentation/widgets/myButton.dart';
import 'package:rafsakaos_app/presentation/widgets/myTextfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Login Error'),
            content: Text(e.code == 'user-not-found'
                ? 'Incorrect Email!'
                : 'Incorrect Password!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // Title
                Text(
                  'Papipakonveksi',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Sign In title
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign-In',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Email field
                MyTextField(
                  controller: emailController,
                  hintText: 'Masukkan Email',
                  obscureText: false,
                ),
                const SizedBox(height: 15),

                // Password field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Masukkan Kata Sandi',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // Remember me and Forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (value) {}),
                        Text('Ingat Saya'),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Login Button
                MyButton(
                  text: 'Masuk',
                  onTap: signUserIn,
                ),

                const SizedBox(height: 25),

                // OR divider
                Row(
                  children: [
                    Expanded(
                        child:
                            Divider(color: Colors.grey[400], thickness: 0.5)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('atau'),
                    ),
                    Expanded(
                        child:
                            Divider(color: Colors.grey[400], thickness: 0.5)),
                  ],
                ),

                const SizedBox(height: 20),

                // Social media login icons
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset('assets/google.png', height: 40),
                //     const SizedBox(width: 20),
                //     Image.asset('assets/facebook.png', height: 40),
                //     const SizedBox(width: 20),
                //     Image.asset('assets/apple.png', height: 40),
                //   ],
                // ),

                const SizedBox(height: 25),

                // Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('apakah anda sudah punya akun?'),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage(
                                    onTap: () {},
                                  )),
                        );
                      },
                      child: const Text(
                        'Buat Akun',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
