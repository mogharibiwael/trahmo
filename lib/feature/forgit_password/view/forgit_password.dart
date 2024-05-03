import 'package:flutter/material.dart';
import 'package:trahmoo/core/style/app_colors.dart';
import 'package:trahmoo/core/style/app_text.dart';
import 'package:trahmoo/core/widget/button.dart';

import '../../../core/widget/textFeildWidget.dart';

class ForgetPassword extends StatelessWidget {
   ForgetPassword({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController=TextEditingController();
    return Scaffold(body: Container(
      margin:
      const EdgeInsets.symmetric(vertical: 99,
          horizontal: 16)
      ,child:
    Form(
      key: formKey,
      child: Column(
        children: [
          Align(
            alignment:Alignment.centerLeft ,
            child: Text(AppText.forgotPassword,style:
            TextStyle(fontSize:34 ,fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(height: 73),
          Text(AppText.contentForgotPasswordHint),
          SizedBox(height: 16,),
          TextFeildWidget(type: TextInputType.emailAddress,isScure: false,controller:emailController ,label: "email",icon: Icons.close,iconColor: Colors.red),
          SizedBox(height:37,),
          AppButton(formKey: formKey,text: AppText.send,onpress: (){

          },),



        ],
      ),
    ),));
  }
}

