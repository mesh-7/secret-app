import 'package:flutter/material.dart';

/// A text field that keeps its input obscured and allows toggling visibility.
class EncryptedTextField extends StatefulWidget {
  const EncryptedTextField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;

  @override
  State<EncryptedTextField> createState() => _EncryptedTextFieldState();
}

class _EncryptedTextFieldState extends State<EncryptedTextField> {
  bool _obscured = true;

  void _toggle() {
    setState(() => _obscured = !_obscured);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscured,
      obscuringCharacter: '•',
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(_obscured ? Icons.visibility : Icons.visibility_off),
          onPressed: _toggle,
        ),
      ),
    );
  }
}
