import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/text.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    this.obscureText,
    this.controller,
    this.hintText,
    this.border,
    this.maxLines,
    this.prefixIcon,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.labelText,
  }) : super(key: key);
  final bool? obscureText;
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final InputBorder? border;
  final int? maxLines;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
            hintText: '$hintText',
            label: text(
              '$labelText',
              color: Colors.blue,
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            )),
      ),
    );
  }
}
