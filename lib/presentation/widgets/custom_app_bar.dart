// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.primaryColor, 
      elevation: 0,
      title: Text(title),
      leading: leading != null
          ? Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.3),
              ),
              child: leading,
            )
          : null,
      actions: [
        if (trailing != null)
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.3),
            ),
            child: trailing,
          ),
      ],
      iconTheme: IconThemeData(color: Colors.white), toolbarTextStyle: TextTheme(
        headlineSmall: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ).bodyMedium, titleTextStyle: TextTheme(
        headlineSmall: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ).titleLarge,
    );
  }
}