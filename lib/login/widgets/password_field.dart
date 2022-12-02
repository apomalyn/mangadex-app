import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String labelText;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onEditionComplete;

  const PasswordField(
      {super.key,
      required this.labelText,
      this.validator,
      this.onEditionComplete});

  @override
  State<PasswordField> createState() => _PasswordState();
}

class _PasswordState extends State<PasswordField> {
  /// Define if the password is visible or not
  bool _obscureText = true;

  final double borderRadiusOnFocus = 2.0;

  @override
  Widget build(BuildContext context) => TextFormField(
        autofillHints: const [AutofillHints.password],
        cursorColor: Colors.white,
        obscureText: _obscureText,
        decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: Colors.white54),
            errorStyle: TextStyle(color: errorTextColor),
            suffixIcon: IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white),
                onPressed: _toggle)),
        style: const TextStyle(color: Colors.white),
        validator: widget.validator,
        onEditingComplete: widget.onEditionComplete,
      );

  /// Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Color get errorTextColor => Theme.of(context).brightness == Brightness.light
      ? Colors.amberAccent
      : Colors.redAccent;
}
