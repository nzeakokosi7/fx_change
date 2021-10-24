import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

enum InputType { email, password, number, text }

class Input extends StatefulWidget {
  final bool multi;
  final int? lines;
  final int? maxLength;
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final InputType? type;
  final TextCapitalization? capitalization;
  final String? Function(String?)? validator;
  final IconButton? prefixIcon;
  final IconButton? suffixIcon;

  Input.multi(
      {this.label,
      this.hint,
      this.controller,
      this.type,
      this.maxLength,
      this.capitalization,
      this.validator,
      this.prefixIcon,
      this.suffixIcon,
      this.lines})
      : multi = true;

  Input(
      {this.label,
      this.hint,
      this.controller,
      this.type,
      this.maxLength,
      this.capitalization,
      this.validator,
      this.prefixIcon,
      this.suffixIcon})
      : multi = false,
        lines = 1;

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      controller: widget.controller,
      obscureText: widget.type == InputType.password ? obscure : false,
      keyboardType: widget.type == InputType.email
          ? TextInputType.emailAddress
          : widget.type == InputType.number
              ? TextInputType.number
              : TextInputType.text,
      inputFormatters: widget.type == InputType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      validator: widget.validator,
      minLines: widget.multi ? widget.lines : 1,
      maxLines: widget.multi ? widget.lines : 1,
      textCapitalization: widget.capitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Colors.grey),
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: widget.type == InputType.password
              ? IconButton(
                  onPressed: () => setState(() {
                        obscure = !obscure;
                      }),
                  icon: obscure
                      ? const Icon(Icons.visibility_outlined)
                      : const Icon(Icons.visibility_off_outlined))
              : widget.suffixIcon,
          prefixIcon: widget.prefixIcon),
    );
  }
}
