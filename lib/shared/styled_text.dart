import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.text,
      {super.key, this.textOverflow, this.softWrap = true});

  final String text;
  final TextOverflow? textOverflow;
  final bool softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: textOverflow,
        softWrap: softWrap,
        textAlign: TextAlign.center,
        style: GoogleFonts.kanit(
          textStyle: Theme.of(context).textTheme.bodyMedium,
        ));
  }
}

class StyledHeading extends StatelessWidget {
  const StyledHeading(this.text,
      {super.key, this.textOverflow, this.softWrap = true});

  final String text;
  final TextOverflow? textOverflow;
  final bool softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(),
        overflow: textOverflow,
        softWrap: softWrap,
        style: GoogleFonts.kanit(
          textStyle: Theme.of(context).textTheme.headlineMedium,
        ));
  }
}

class StyledTitle extends StatelessWidget {
  const StyledTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(),
        style: GoogleFonts.kanit(
          textStyle: Theme.of(context).textTheme.titleMedium,
        ));
  }
}
