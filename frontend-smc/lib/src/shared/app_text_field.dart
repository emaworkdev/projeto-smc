import 'package:smc/src/shared/required_label.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTextField extends StatefulWidget {
  final String label;
  final bool required;
  final String hint;
  final double? width;
  final bool password;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool autoFocus;
  final FocusNode? nextFocus;
  final Color color;
  final Color colorHint;
  bool isIcon;
  IconData icone;

  AppTextField({
    Key? key,
    required this.label,
    this.required = false,
    required this.hint,
    this.width,
    this.password = false,
    required this.controller,
    required this.validator,
    required this.onChanged,
    required this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.autoFocus = false,
    this.nextFocus,
    this.color = Colors.black,
    this.colorHint = Colors.white30,
    this.isIcon = false,
    this.icone = Icons.add,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RequiredLabel(widget.label, widget.required, widget.color),
        _textField(context),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  _textField(context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        //key: Key(label),
        controller: widget.controller,
        obscureText: widget.password ? _obscureText : widget.password,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        autofocus: widget.autoFocus,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        onFieldSubmitted: (String text) {
          if (widget.nextFocus != null) {
            FocusScope.of(context).requestFocus(widget.nextFocus);
          }
        },
        style: TextStyle(
          fontSize: 16,
          color: widget.color,
        ),
        decoration: InputDecoration(
          labelStyle: TextStyle(
            fontSize: 20,
            color: widget.color,
          ),
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontSize: 14,
            color: widget.colorHint,
          ),
          suffixIcon: widget.password
              ? IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  })
              : IconButton(
                  icon: widget.isIcon ? Icon(widget.icone) : Container(),
                  onPressed: () {},
                ),
        ),
      ),
    );
  }
}
