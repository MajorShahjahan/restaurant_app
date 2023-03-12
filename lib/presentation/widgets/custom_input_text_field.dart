import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key? key,
        this.controller,
        this.onTap,
        this.onChanged,
        this.keyboardType,
        required this.readOnly,
        this.suffixIcon,
        this.padding,
        this.validator,
        this.margin,
        this.maxLines,
        this.hintText,
        this.obscureText = false})
      : assert(obscureText !=null),
        super(key: key);

  final TextEditingController? controller;
  final bool readOnly;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? padding;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? margin;
  final int? maxLines;
  final String? hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      //height: 42,
      child: TextFormField(
        cursorColor: Colors.lightBlue,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            suffixIconColor: Colors.lightBlueAccent,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(color: Colors.lightBlue),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(13)),
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(13)),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: Colors.redAccent,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                )),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            contentPadding: const EdgeInsets.all(10),
            errorMaxLines: 2,
        ),
      ),
    );
  }
}