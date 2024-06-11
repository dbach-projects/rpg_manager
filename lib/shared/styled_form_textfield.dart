import 'package:flutter/material.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledFormTextfield extends StatelessWidget {
  const StyledFormTextfield(
      {super.key,
      required this.label,
      required this.textInputType,
      required this.prefixIcon,
      required this.maxLength,
      required this.validator,
      required this.onSaved,
      this.maxLines = 1,
      this.initialValue});

  final String label;
  final TextInputType textInputType;
  final Icon prefixIcon;
  final int maxLength;
  final String? Function(String?) validator;
  final String? initialValue;
  final void Function(String?) onSaved;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      initialValue: initialValue,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: textInputType,
      style:
          GoogleFonts.kanit(textStyle: Theme.of(context).textTheme.bodyMedium),
      cursorColor: AppColors.textColor,
      decoration:
          InputDecoration(prefixIcon: prefixIcon, label: StyledText(label)),
      validator: validator,
    );
  }
}
