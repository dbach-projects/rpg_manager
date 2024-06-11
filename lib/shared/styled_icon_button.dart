import 'package:flutter/material.dart';

class StyledIconButton extends StatelessWidget {
  const StyledIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
        ));
  }
}
