import 'package:flutter/material.dart';

import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/persentation/auth/pages/signup.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signupText(context),
      appBar: BasicAppbar(
        title: Image.asset(AppVectors.logo, height: 150, width: 150),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _signInText(),
            SizedBox(height: 30),
            _userNameOrEmailField(context),
            SizedBox(height: 30),

            _passwaordField(context),
            SizedBox(height: 30),
            BasicAppButton(onPressed: () {}, title: 'Sign In'),
          ],
        ),
      ),
    );
  }

  Widget _signInText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _userNameOrEmailField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Enter Username Or Emial',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwaordField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: ' Password',
        labelText: 'Password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not A Member? ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SignupPage(),
                ),
              );
            },
            child: const Text(
              'Register Now',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
