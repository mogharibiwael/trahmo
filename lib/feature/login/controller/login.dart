import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/app_provider.dart';
import '../../../core/localdata/localdata.dart';

class SignInController extends GetxController{

  final type=2;
  final _email = ''.obs;
  get email => this._email.value;
  set email(value) => this._email.value = value;
  final _password = ''.obs;
  get password => this._password.value;
  set password(value) => this._password.value = value;
  final _loading = false.obs;
  get loading => this._loading.value;
  set loading(value) => this._loading.value = value;
  Future<int> login(String email, String password) async {
    try {
      final response = await http.post(
          Uri.parse('${AppProvider.baseUrl}/api/login/'),
          headers: {
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            'email': email,
            'password': password,
          })
      );
      if (response.statusCode == 200) {
        print("here if");
        var mapdata=json.decode(response.body);
        LocalData.saveData("Token", mapdata['token']);
        LocalData.saveData("id", mapdata['data']['id'].toString());
        print(response.body);
        return response.statusCode;
      } else {
        print("here else");
        print(response.statusCode);
        print(response.body);
        return 0;
      }
    }catch(e){
      print(e);

      return 0;
    }
  }


  SignUp(){




  }







}