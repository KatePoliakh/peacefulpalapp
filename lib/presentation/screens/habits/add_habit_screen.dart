import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';
import 'package:peacefulpalapp/presentation/widgets/primary_button.dart';

class AddHabitScreen extends StatelessWidget {
  static const routeName = '/add_habit';

  const AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Новая привычка'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(decoration: InputDecoration(labelText: 'Название привычки')),
            const SizedBox(height: 16),
            PrimaryButton(text: 'Сохранить', onPressed: Navigator.of(context).pop),
          ],
        ),
      ),
    );
  }
}