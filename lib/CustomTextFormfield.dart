import 'package:flutter/material.dart';
import 'package:todo/MyTheme.dart';

class CustomTextFormField extends StatelessWidget {
  TextInputType keyboardInput;
  TextEditingController controller;
  String label;
  String ? Function(String?) validator;
  CustomTextFormField({required this.controller, required this.label, required this.keyboardInput, required this.validator});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      label: Text(label),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: MyTheme.primartight, width: 3)
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: MyTheme.primartight, width: 3)
      ),


    ),
    keyboardType: keyboardInput,
      validator: validator,

    );
  }
}
