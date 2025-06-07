import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';
import 'package:peacefulpalapp/presentation/widgets/primary_button.dart';

class BreathingScreen extends StatelessWidget {
  static const routeName = '/breathing';

  const BreathingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Дыхательное упражнение'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Упражнение "4-7-8"', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.green.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Center(child: Text('Дышите...')),
            ),
            const SizedBox(height: 20),
            PrimaryButton(text: 'Старт', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}