import 'package:flutter/material.dart';
import 'package:hitechpos/views/Registration/registration_key.dart';

class RegistrationBeforeLogin extends StatelessWidget {
  const RegistrationBeforeLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            RegistrationKeyScreen(),
          ],
        ),
      ),
    );
  }
}
