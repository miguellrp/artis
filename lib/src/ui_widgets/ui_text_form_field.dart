import 'package:artis/src/utilities/util_color.dart';
import 'package:flutter/material.dart';

class UITextFormField extends StatefulWidget {
  final TextInputType inputType;
  final String labelText;
  final IconButton? suffixIcon;
  String? text;
  final int? maxLength;

  UITextFormField({this.inputType = TextInputType.text, required this.labelText, this.suffixIcon, this.maxLength, super.key});

  @override
  UITextFormFieldState createState() => UITextFormFieldState();
}

class UITextFormFieldState extends State<UITextFormField> {
  final FocusNode _textFormFieldFocusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _textFormFieldFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _textFormFieldFocusNode.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _textFormFieldFocusNode.hasFocus;
    });
  }

  Color getTextColor(BuildContext context) {
    return _isFocused ? Theme.of(context).colorScheme.primary : UtilColor.getDarkWhiteColor(context);
  }

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      keyboardType: widget.inputType,
      focusNode: _textFormFieldFocusNode,
      style: TextStyle(color: getTextColor(context)),
      onChanged: (value) => widget.text = value,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        label: Text(widget.labelText, style: TextStyle(color: getTextColor(context).withAlpha(100))),
        constraints: BoxConstraints(maxWidth: 300),
        counterStyle: TextStyle(color: getTextColor(context).withAlpha(155)),
        suffixIconColor: getTextColor(context).withAlpha(100),
        suffixIcon: widget.suffixIcon,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(
          width: 2,
          color: UtilColor.getDarkWhiteColor(context).withAlpha(50))
        ),
        border: OutlineInputBorder(borderSide: BorderSide(width: 5))
      ),
    );
  }
}
