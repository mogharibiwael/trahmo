import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trahmoo/core/route/app_routes.dart';
import 'package:trahmoo/core/style/app_colors.dart';
import 'package:trahmoo/core/style/app_text.dart';
import 'package:trahmoo/core/widget/button.dart';
import 'package:trahmoo/core/widget/textFeildWidget.dart';
import 'package:trahmoo/feature/SignUp/controller/signup.dart';
import 'package:trahmoo/feature/login/view/login.dart';


class SignUP extends StatelessWidget {
    SignUP() ;
    var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController= TextEditingController();
    TextEditingController emailController= TextEditingController();
    TextEditingController passwordController= TextEditingController();
    SignUpController controller=Get.find<SignUpController>();
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
        body: Container(margin:
        const EdgeInsets.symmetric(vertical:25,
            horizontal: 16) ,
            child:SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height *0.02,),
                    Align(
                      alignment:Alignment.centerLeft ,
                      child: Text(AppText.signUpText,style:
                      TextStyle(fontSize:34 ,fontWeight: FontWeight.w800),

                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height *0.1,),

                    TextFeildWidget(isScure: false,type: TextInputType.text,controller: nameController,label: AppText.nameFieldLabel,icon: Icons.check,iconColor: AppColors.checkIconColor,),
                    SizedBox(height: 8),
                    TextFeildWidget(isScure: false,type: TextInputType.emailAddress,controller: emailController,label: AppText.emailFieldLabel,icon: Icons.check,iconColor: AppColors.checkIconColor,),
                    SizedBox(height: 8),
                    TextFeildWidget(isScure: true,type: TextInputType.text,controller: passwordController,label:AppText.passwordFieldLabel,icon: Icons.check,iconColor: AppColors.checkIconColor,),
                    SizedBox(height: 16,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_){
                          return Login();
                        }));
                      },
                      child: Align(alignment: Alignment.centerRight,child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(AppText.alreadyHaveAccount),
                          SizedBox(width: 8,),
                          Image.asset("assets/image/arrow.png",width: 20,),
                        ],
                      )),
                    ),
                    SizedBox(height:37,),
                    AppButton(formKey: formKey,text: AppText.signUpTextCapitalize,onpress: ()async{
                        if(formKey.currentState!.validate()){
                        var result=await  controller.registerUser(nameController.text, emailController.text, passwordController.text);
                        print("#####################");
                        print(result);
                        print("#####################");

                        if(result==201) {

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
                     //
                        }

                    },),
                    SizedBox(height: 20,),
                    Text(AppText.orSignUp),
                    SizedBox(height: 12,),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center
                    ,children: [
                      Image.asset("assets/image/google.png",width: 92,height: 64,),
                      Image.asset("assets/image/facebook.png",width: 92,height: 64,),
                    ],)
                    // FloatingActionButton(onPressed: () {  },child: Text(),)
                  ],


                ),
              ),
            )

        ),
      ),

    ) ;
  }
}


