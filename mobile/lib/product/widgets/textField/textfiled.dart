import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.label,
    required this.controller,
    required this.obscure,
    required this.passwordTextfield,
    super.key,
  });
  final TextEditingController controller;
  final String label;
  final bool obscure;
  final bool passwordTextfield;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        style: Theme.of(context).textTheme.titleLarge,
        controller: widget.controller,
        cursorColor: Theme.of(context).colorScheme.inverseSurface,
        decoration: InputDecoration(
          filled: true,
          labelStyle: Theme.of(context).textTheme.titleLarge,
          labelText: widget.label,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          suffixIcon: widget.passwordTextfield
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
        obscureText: _obscureText,
      ),
    );
  }
}
