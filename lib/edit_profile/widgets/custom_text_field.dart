import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {String? labelText,
      String? initialValue,
      void Function(String value)? onChanged,
      super.key})
      : _initialValue = initialValue,
        _labelText = labelText,
        _onChanged = onChanged;

  final String? _labelText;
  final String? _initialValue;
  final void Function(String value)? _onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: _initialValue,
      decoration: InputDecoration(
        labelText: _labelText,
        labelStyle: TextStyle(
          color: Color(0xFF999999),
          fontWeight: FontWeight.w600,
        ),
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF000000),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 2,
          ),
        ),
      ),
      onChanged: _onChanged,
    );
  }
}
