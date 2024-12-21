import 'package:flutter/material.dart';

class PrimaryTextformfield extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  Widget? prefix;
  Widget? suffix;
  bool obsecure = false;

  PrimaryTextformfield({
    required this.hint,
    this.controller,
    this.prefix,
    this.suffix,
    required this.obsecure,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 14,
        ),
        prefix: prefix == null ? const SizedBox() : prefix!,
        suffix: suffix == null ? const SizedBox() : suffix!,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xffBABABA),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
