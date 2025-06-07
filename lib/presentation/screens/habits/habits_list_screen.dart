import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/screens/habits/add_habit_screen.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';

class HabitsListScreen extends StatelessWidget {
  const HabitsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Привычки',
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, AddHabitScreen.routeName);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, i) => ListTile(
          title: Text("Привычка $i"),
          trailing: const Icon(Icons.check_circle_outline),
        ),
      ),
    );
  }
}