import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';

class HotlineScreen extends StatelessWidget {
  const HotlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Экстренная помощь'),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, i) => ListTile(
          title: Text('Горячая линия $i'),
          subtitle: Text('+7 (XXX) XXX-XX-XX'),
          trailing: const Icon(Icons.call),
        ),
      ),
    );
  }
}