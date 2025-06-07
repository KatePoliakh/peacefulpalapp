import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;

  const CustomAppBar({super.key, required this.title, this.leading});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: leading ?? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: Navigator.of(context).pop,
      ),
    );
  }
}