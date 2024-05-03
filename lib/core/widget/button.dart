import 'package:flutter/material.dart';
import 'package:trahmoo/core/style/app_colors.dart';
import 'package:trahmoo/core/style/app_text.dart';
import 'package:trahmoo/feature/Home/view/home_page.dart';

class AppButton extends StatelessWidget {

   AppButton({
    required this.text,
    required this.formKey,
     required this.onpress
  }) ;
   var formKey = GlobalKey<FormState>();
  final text;
  VoidCallback onpress;
  @override
  Widget build(BuildContext context) {
    return Container(height: 40,
        width: double.infinity,
        child: ElevatedButton(style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.buttonColor)
    ),onPressed:onpress, child:Text(text) ));
  }
}
