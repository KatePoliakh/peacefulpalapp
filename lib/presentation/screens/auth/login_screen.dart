import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';
import 'package:peacefulpalapp/presentation/widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Sign in'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(decoration: InputDecoration(labelText: 'Email')),
            const SizedBox(height: 16),
            TextFormField(decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 24),
            PrimaryButton(text: 'Войти', onPressed: () {}),
            const SizedBox(height: 16),
            TextButton(onPressed: () {}, child: const Text('Forgot password?')),
            const SizedBox(height: 8),
            TextButton(onPressed: () {}, child: const Text('Create account')),
          ],
        ),
      ),
    );
  }
}