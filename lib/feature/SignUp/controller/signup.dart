import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trahmoo/core/app_provider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/localdata/localdata.dart';

class SignUpController extends GetxController{

  final type=2;
  final phone="771981596";

  final _email = ''.obs;
  get email => this._email.value;
  set email(value) => this._email.value = value;

  final _password = ''.obs;
  get password => this._password.value;
  set password(value) => this._password.value = value;

  final _loading = false.obs;
  get loading => this._loading.value;
  set loading(value) => this._loading.value = value;

  Future<int> registerUser(String name, String email, String password) async {

   try {
     final response = await http.post(
         Uri.parse('${AppProvider.baseUrl}/api/user/'),
         headers: {
           'Content-Type': 'application/json'
         },
         body: jsonEncode({
           'username': name,
           'email': email,
           'password': password,
         })
     );

     print("#######################************");
     print(response.statusCode);
     print("#######################************");

     if (response.statusCode == 201) {
       print("here if");
       var mapdata=json.decode(response.body);
       print(response.body);
        await LocalData.saveData("Token", mapdata['token']);
        await LocalData.saveData("id",mapdata['data']['id'].toString());

       print('#######################');
       print(await LocalData.getData('id'));
       print('#######################');
       return response.statusCode;
     } else {
       print("here else");
       print(response.statusCode);
       print(response.body);
       return response.statusCode;
     }
   }catch(e){
     print(e);

     return 0;
   }
  }


  SignUp(){




  }







}