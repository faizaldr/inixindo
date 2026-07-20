import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  bool obscureText;
  final IconData? icon;
  final Widget? suffixIcon;
  final Widget? suffixIcon2;
  final TextInputType keyboardType;

  FormInput({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.obscureText = false,
    this.icon,
    this.suffixIcon,
    this.suffixIcon2,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FormInputState();
  }
}

class _FormInputState extends State<FormInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: widget.icon != null
              ? Icon(widget.icon, color: Theme.of(context).primaryColor)
              : null,
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                  icon: widget.obscureText
                      ? widget.suffixIcon!
                      : widget.suffixIcon2!,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12)
          )
        ),
      ),
    );
  }
}
