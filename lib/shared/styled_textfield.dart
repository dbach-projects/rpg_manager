import 'package:flutter/material.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledTextfield extends StatelessWidget {
  const StyledTextfield(
      {super.key,
      required this.controller,
      required this.label,
      required this.textInputType,
      this.prefixIcon,
      this.sufixIcon,
      this.obscureText = false,
      this.onChanged});

  final TextEditingController controller;
  final String label;
  final TextInputType textInputType;
  final Icon? prefixIcon;
  final Icon? sufixIcon;
  final bool obscureText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      onChanged: onChanged,
      controller: controller,
      keyboardType: textInputType,
      style:
          GoogleFonts.kanit(textStyle: Theme.of(context).textTheme.bodyMedium),
      cursorColor: AppColors.textColor,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon,
          label: StyledText(label)),
    );
  }
}
