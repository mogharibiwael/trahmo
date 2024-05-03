import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:trahmoo/core/localdata/localdata.dart';
import 'package:trahmoo/feature/product/models/products.dart';

import '../../../core/app_provider.dart';
import '../../Home/model/category.dart';

class ProductDetailsController extends GetxController {
  RxBool favoriteState =false.obs;
  // List<FavoriteProduct> favoriteList=[];


  var isLoading = false.obs;
  var productIdToRequest = 0.obs;

  RxInt length = 0.obs;
  RxList<Product> listProduct = <Product>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchProducts();
    var id=await LocalData.getData("id");
    await getFavoriteState(id);
  }
  getFavoriteState(id)async{
    var id = await LocalData.getData("id");

    var temp=await LocalData.getData('id');
    print("temp--------------------");
    print(temp);
    print("temp--------------------");
    try {
      final response = await http.get(
        Uri.parse(
            '${AppProvider.baseUrl}/api/add_and_get_favorite/${id}'),

        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          // HttpHeaders.authorizationHeader: 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        log(response.body);
        var data=json.decode(response.body);

        List<Product> productList = [];

        // for (var i = 0; i < data.length; i++) {
        //   FavoriteProduct favoriteProduct = FavoriteProduct.fromJson(data[i]);
        //   favoriteList.add(favoriteProduct);
        // }
        return response.statusCode;
      } else {
        print(response.body);
        return 0;
      }
    } catch (e) {
      print("catch");
      print(e);
      print("catch");
      return 0;

    }

  }
  add_or_update_favorate(product_id)async{
    var id = await LocalData.getData("id");

    var temp=await LocalData.getData('id');
    print("temp--------------------");
    print(temp);
    print("temp--------------------");
    try {
      final response = await http.post(
        Uri.parse(
            '${AppProvider.baseUrl}/api/add_and_get_favorite/${id}'),
        body: {
          'state':"0",
          'product':product_id,
        },

        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          // HttpHeaders.authorizationHeader: 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        log(response.body);
        return response.statusCode;
      } else {
        print(response.body);
        return 0;
      }
    } catch (e) {
      print("catch");
      print(e);
      print("catch");
      return 0;

    }
  }
  getFavorite(){

    LocalData.getData('favoriteProductId');
  }
  changeFavoriteState(id){
    LocalData.saveData('favoriteProductId', id.toString());
    favoriteState.value=!favoriteState.value;
  }

  Future<List<Product>> fetchProducts() async {
    isLoading.value = true;
    length.value = 0;
    print('Welcome to the Product Details Page!');

    var token = await LocalData.getData("Token");

    try {
      http.Response response = await http.get(
        Uri.parse('${AppProvider.baseUrl}/api/product'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
      );

      print(response.statusCode);
      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseBody = response.body;

        final decodedResponse = utf8.decode(responseBody.runes.toList());
        final jsonData = jsonDecode(decodedResponse);
        print(jsonData);
        List<Product> productList = [];

        for (var i = 0; i < jsonData.length; i++) {
          Product product = Product.fromJson(jsonData[i]);
          productList.add(product);
        }

        listProduct.value = productList;
        length.value = productList.length;

        return productList;
      } else {
        print(json.decode(response.body));
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future <int> sendRequest(id) async {
    var token = await LocalData.getData("Token");

    var temp=await LocalData.getData('id');
      print("temp--------------------");
      print(temp);
    print("temp--------------------");
    try {
      final response = await http.post(
        Uri.parse(
            '${AppProvider.baseUrl}/api/order/${id}'),
        body: {
          'state':"0",
          'user':await LocalData.getData('id')
        },

        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          // HttpHeaders.authorizationHeader: 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        log(response.body);
        return response.statusCode;
      } else {
        print(response.body);
        return 0;
      }
    } catch (e) {
      print("catch");
      print(e);
      print("catch");
      return 0;

    }
  }
}