// custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anka/product/provider/theme_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.autoLeading,
    super.key,
  });

  final bool autoLeading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: autoLeading,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: SizedBox(
        width: 220,
        child: Image(
          color: Theme.of(context).colorScheme.onSurface,
          image: const AssetImage('assets/anka_logo.png'),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Provider.of<ThemeProvider>(context).darkMode
                ? Icons.light_mode
                : Icons.dark_mode,
            color: Provider.of<ThemeProvider>(context).darkMode
                ? Colors.yellow
                : Colors.indigo,
            size: 30,
          ),
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleDarkMode(
                !Provider.of<ThemeProvider>(context, listen: false).darkMode);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
