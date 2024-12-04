import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "./Image/ms-removebg-preview.png",
            ),
            fit: BoxFit.contain,
          ),
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 55, 15, 124),
              Colors.black,
            ],
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
            ),
            Text(
              "Welcome Back",
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            Text(
              "Enter your credential for Login",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 550,
            ),
            Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              padding: EdgeInsets.only(left: 20, right: 50),
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(193, 13, 1, 34)),
              child: Row(
                children: [
                  Image.asset(
                    "Image/google-symbol.png",
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(
                    width: 56,
                  ),
                  Text(
                    "Sign in With Google",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
