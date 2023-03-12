import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    required this.onPress,
    this.label,
    this.color,
    this.padding,
    Key? key,
  }) : super(key: key);

  final void Function()? onPress;
  final Widget? label;
  final Color? color;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(padding ?? 20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.06,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shadowColor: Colors.grey,
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.lightBlue, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
          onPressed: onPress,
          child: label,
        ),
      ),
    );
  }
}
