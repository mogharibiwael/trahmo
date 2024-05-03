import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trahmoo/feature/Home/model/benefactor.dart';
import 'package:trahmoo/feature/Home/model/category.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trahmoo/feature/Home/model/category_state.dart';
import '../../../core/app_provider.dart';
import '../model/state.dart';

class HomeController extends GetxController{
  RxBool isChecked = false.obs;
  RxBool isLoading=false.obs;
  RxInt selectedPaymentOption = 0.obs;
  RxInt selectedPaymentOption2 = 0.obs;
  Benefactor benefactor=Benefactor();
  String amount='';
  int id=0;
  RxInt category_id=0.obs;
  RxList<Category> listCategory = <Category>[].obs;
  RxList<Tabraa> listStates = <Tabraa>[].obs;
  RxList<Tabraa> listStates2 = <Tabraa>[].obs;
  RxList<CategoryState> categoryState = <CategoryState>[].obs;
  RxInt selectedContainerIndex = 0.obs;
  var amountController = TextEditingController(text: '1000').obs;

  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController amountStateController=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController beneficiaryName=TextEditingController();
  TextEditingController beneficiaryAddress=TextEditingController();
  TextEditingController beneficiaryPhone=TextEditingController();
  TextEditingController addressController=TextEditingController();
  void setAmount(String value) {
    amountController.value.text = value;
  }
  String get getAmountController => amountController.value.text;

  PickedFile? pickedFile;

  Rx<File?> imageFile = Rx<File?>(null);

  void setImageFile(File? file) {
    imageFile.value = file;
  }

  String ?selectedItem;







  @override
  void onInit() async{
    await fetchState();
    await getCategoryWithState();
  }

  changeCheckButton(newValue){
    print("yess");
    isChecked.value = newValue;
  }

  Future<List<Tabraa>> fetchState() async {
    print('-------------');
    isLoading.value = true;
    try {
      http.Response response = await http.get(
        Uri.parse(AppProvider.getState),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final decodedResponse = utf8.decode(responseBody.runes.toList());
        final jsonData = jsonDecode(decodedResponse);
        List<Tabraa> stateList = [];
        for (var i = 0; i < jsonData.length; i++) {
          Tabraa tabraa = Tabraa.fromJson(jsonData[i]);
          stateList.add(tabraa);
        }
        listStates.value = stateList;
        return listStates.value;
      } else {
        print(json.decode(response.body));
        throw Exception('Failed to load products');
      }
    } catch (e,stackTrace) {
      print(stackTrace);
      return [];
    }
  }

  Future<List<Tabraa>> getStateDetails() async {
    isLoading.value = true;
    try {
      http.Response response = await http.get(
        Uri.parse(AppProvider.getState),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      isLoading.value = false;
      print(response.body);
      print('-------------------');
      if (response.statusCode == 200) {
        print('/////////////////');
        final responseBody = response.body;
        final decodedResponse = utf8.decode(responseBody.runes.toList());
        final jsonData = jsonDecode(decodedResponse);
        List<Tabraa> stateList = [];
        for (var i = 0; i < jsonData.length; i++) {
          Tabraa tabraa = Tabraa.fromJson(jsonData[i]);
          stateList.add(tabraa);
        }
        listStates.value = stateList;
        print("------------------------------");

        print(listStates[0].state?.image);
        print("------------------------------");
        return listStates.value;
      } else {
        print(json.decode(response.body));
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<int> sendTabraaData(String amount,int id,Benefactor benefactor) async {
    Map<String, dynamic> body = {
      'id':id.toString(),
      'amount':amount,
      'benefactor':json.encode(benefactor.toJson())
    };

    isLoading.value = true;
    try {
      http.Response response = await http.post(
        Uri.parse(AppProvider.sendTabraa),
        body:body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      print("-------==============9999999");
      print(response.body);
      print("-------==============9999999");

      isLoading.value = false;
      if (response.statusCode == 200) {
       return 200;
      } else {
       return 0;
      }
    } catch (e,stackTrace) {
      print(e);
      print(stackTrace);
      return 0;
    }
  }



  Future<List<CategoryState>> getCategoryWithState() async {
    isLoading.value = true;
    try {
      http.Response response = await http.get(
        Uri.parse(AppProvider.getCategoryState),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      isLoading.value = false;
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final responseBody = response.body;
        final decodedResponse = utf8.decode(responseBody.runes.toList());
        final jsonData = jsonDecode(decodedResponse);
        List<CategoryState> categoryStateList = [];
        for (var i = 0; i < jsonData.length; i++) {
          CategoryState categoryState = CategoryState.fromJson(jsonData[i]);
          categoryStateList.add(categoryState);
        }
        print('----------------------');
        print('---------''=======================-------------');
        print(categoryStateList);
        print('---------=========================-------------');
        categoryState.value = categoryStateList;
        return categoryState.value;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e,stackTrack) {
      print(e);
      print(stackTrack);
      return [];
    }
  }


  Future<List<Tabraa>> getTabraaByCategory() async {
    isLoading.value = true;
    try {
      http.Response response = await http.get(
        Uri.parse(AppProvider.getStateByCategory+'/'+category_id.value.toString()),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      isLoading.value = false;
      print(response.body);
      if (response.statusCode == 200) {
        final responseBody = response.body;
        final decodedResponse = utf8.decode(responseBody.runes.toList());
        final jsonData = jsonDecode(decodedResponse);
        List<Tabraa> stateList2 = [];
        for (var i = 0; i < jsonData.length; i++) {
          Tabraa tabraa = Tabraa.fromJson(jsonData[i]);
          stateList2.add(tabraa);
        }
        listStates2.value = stateList2;
        return listStates.value;
      } else {
        print(json.decode(response.body));
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<int> uploadState() async {
    isLoading.value = true;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AppProvider.addStateFromApp),
      );

      // Add text fields to the request body
      request.fields['name'] = name.text;
      request.fields['amount'] = amountStateController.text;
      request.fields['description'] = description.text;
      request.fields['address'] = addressController.text;
      request.fields['benficiary[name]'] = name.text;
      request.fields['benficiary[address]'] = addressController.text;
      request.fields['benficiary[phone]'] = beneficiaryPhone.text;
      request.fields['benficiary[note]'] = "note";
      request.fields['category'] = selectedItem!;

      // Attach the image file to the request
      var multipartFile = await http.MultipartFile.fromPath(
        'image',
        imageFile.value!.path,
      );
      request.files.add(multipartFile);

      var response = await request.send();
      isLoading.value = false;
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonData = jsonDecode(responseBody);

        print(jsonData);




        return 200;
      } else {
        // print(json.decode(response.body));
        throw Exception('Failed to load products');
      }
    } catch (e,track) {
      print(e);
      print(track);
      return 0;
    }
  }






}