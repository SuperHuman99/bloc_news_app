import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({Key? key, required this.onPressed, required this.label})
      : super(key: key);

  final Function onPressed;
  final String label;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onPressed();
      },
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      )),
      child: Text(
        widget.label,
      ),
    );
  }
}
