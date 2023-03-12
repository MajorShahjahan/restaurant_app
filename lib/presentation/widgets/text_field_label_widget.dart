import 'package:flutter/material.dart';

class TextFieldLabelWidget extends StatelessWidget {
  const TextFieldLabelWidget({
    Key? key,
    required this.label,
    this.padding,
  }) : super(key: key);

  final String label;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
