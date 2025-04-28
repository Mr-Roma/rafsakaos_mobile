import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafsakaos_app/presentation/pages/authPage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    void singUserOut(BuildContext context) async {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              AuthPage())); // Navigate back to the previous screen
    }

    return Scaffold(
      body: Center(
        child: Container(
          height: 60,
          width: 301,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 1),
                    blurRadius: 8,
                    spreadRadius: 0)
              ]),
          child: ListTile(
            title: Text(
              'Log Out',
              style: GoogleFonts.poppins(
                  fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      "Alert!",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    content: Text(
                      "Yakin ingin keluar dari aplikasi?",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          singUserOut(context);
                        },
                        child: Text(
                          "OK",
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
