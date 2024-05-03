


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:trahmoo/core/style/app_colors.dart';
import 'package:trahmoo/core/style/app_text.dart';
import 'package:trahmoo/core/widget/button.dart';
import 'package:trahmoo/feature/SignUp/view/sign_up.dart';
import 'package:trahmoo/feature/forgit_password/view/forgit_password.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/route/app_routes.dart';
import '../../../core/widget/textFeildWidget.dart';
import '../controller/login.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  SignInController controller=Get.find<SignInController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    Container(
        margin:
        const EdgeInsets.symmetric(vertical: 14,
            horizontal: 16)
    ,child: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Align(
              alignment:Alignment.centerLeft ,
              child: Text(AppText.login,style:
             const TextStyle(fontSize:34 ,fontWeight: FontWeight.w800),

              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            TextFeildWidget(isScure: false,type: TextInputType.text,controller: emailController,label: "email",icon: Icons.check,iconColor: AppColors.checkIconColor,),
            SizedBox(height: 8),
            TextFeildWidget(isScure: true,type: TextInputType.text,controller: passwordController,label: "password",icon: Icons.check,iconColor: AppColors.checkIconColor,),
            SizedBox(height: 16,),

            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return SignUP();
                }));
              },
              child: Align(alignment: Alignment.centerRight,child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(AppText.signUpText),
                  SizedBox(width: 8,),
                  Image.asset("assets/image/arrow.png",width: 20,),
                ],
              )),

            ),
            SizedBox(height:37,),
            AppButton(formKey: formKey,text: AppText.loginTextCapitalize,onpress: ()async{

              var result=await  controller.login(emailController.text, passwordController.text);
              print('-------------');
              print(result);
              print('-------------');

              if(result==200) {

                print(result);
                Get.toNamed(AppRoutes.home_page);
              }else{
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  title: 'لم تكتمل عملية التسجيل',
                  desc: 'الرجاء التأكد من البيانات المدخلة',
                  btnCancelOnPress: () {

                  },
                  btnOkOnPress: () {},
                )..show();
              }

            },),
            SizedBox(height: 125,),
            Text(AppText.orSignUp),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center
              ,children: [
              Image.asset("assets/image/google.png",width: 92,height: 64,),
              Image.asset("assets/image/facebook.png",width: 92,height: 64,),
            ],)

          ],
        ),
      ),
    ),));
  }
}

