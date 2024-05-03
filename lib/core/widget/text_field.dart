import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeneralTextFeild extends StatelessWidget {
  const GeneralTextFeild({
    Key? key,
    required this.hasValidate,
    required this.controller,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final bool hasValidate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.zero,
          ),
        ),
        validator: (value) {
          if (hasValidate && value!.isEmpty) {
            return 'الرجاء ملئ الحقل';
          }
          return null;
        },
      ),
    );
  }
}