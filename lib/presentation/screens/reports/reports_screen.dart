import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Отчеты'),
      body: Center(
        child: Text('Personal progress', style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}