import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../constants/constans.dart';
import '../../models/producte_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  static ProductCubit get(context) => BlocProvider.of<ProductCubit>(context);
  List<Product> products = [];
  bool load = false;

  getProductsByCategory(int id) async {
    products = [];
    load = true;
    emit(GetProductDataLoad());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + "product/get-products-by-id?categoryId=1"));

    // request.headers.addAll(headers);
    // request.fields.addAll({'categoryId': '1', 'city': 'البلينا'});
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      print(jsonData);
      jsonData.forEach((v) {
        products.add(Product.fromJson(v));
      });
      load = false;
      emit(GetProductDataSuccess(products));
    } else {
      print("errrrrrrrrrror" + response.statusCode.toString());
      emit(GetProductDataError());
    }
  }

  getProductsByCategoryDio(int id) async {
    products = [];
    load = true;
    emit(GetProductDataLoad());

    var headers = {
      'Content-Type': 'application/json',

      'Access-Control-Allow-Origin': '*',
      // 'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE',
      // // If needed
      // 'Access-Control-Allow-Headers': 'X-Requested-With,content-type',
      // // If needed
      // 'Access-Control-Allow-Credentials': true
      // If  needed
    };

    final dio = Dio(BaseOptions(
        baseUrl: baseUrl, headers: headers, responseType: ResponseType.plain));
    final response = await dio.get("product/get-products-by-id",
        queryParameters: {'categoryId': id.toString()});

    if (response.statusCode == 200) {
      print(response.statusCode);
      var decode = jsonDecode(response.data.toString());
      print(decode);
      products = [];
      decode.forEach((v) {
        products.add(Product.fromJson(v));
      });
      load = false;
      emit(GetProductDataSuccess(products));
    } else {
      print("errrrrrrrrrror" + response.statusCode.toString());
      emit(GetProductDataError());
    }
  }

  bool loadSlider=false;
  List<Product> sliders=[];
  getSliders() async {
    sliders = [];
    loadSlider = true;
    emit(SliderProductErrorStat());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + "product/get-products-sliders"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      print(response.statusCode.toString());
      jsonData.forEach((v) {
        sliders.add(Product.fromJson(v));
      });
      loadSlider = false;
      emit(SliderProductSuccessStat());
    } else {
      loadSlider = false;
      print("errrrrrrrrrror" + response.statusCode.toString());
      emit(SliderProductErrorStat());
    }
  }












  bool loadAddProduct = false;

  Future addProduct(Product product) async {
    loadAddProduct = true;
    emit(AddProductLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + 'product/add-product'));



    request.fields.addAll({
      'name': product.name!,
      'image': product.image!,
      'SellerId': product.sellerId!,
      'Detail': product.detail!,
      'Price': product.price.toString(),
      'CategoryId': product.categoryId.toString(),
      'offerId': '0',
      'Status': '0',
      'city': product.city!,
      'isSlider': 'true',
      "homeCategoryId":product.homeCategoryId.toString()
    });



    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonsDataString;
      print(jsonData);
      loadAddProduct = false;
      getSliders();
      emit(AddProductSuccessStat("success"));
    } else {
      print(response.reasonPhrase);
      loadAddProduct = false;
      emit(AddProductErrorStat("Error"));
    }
  }

  bool loadDelete = false;

  deleteProduct({id, context}) async {
    print("oooooooooooo");
    loadDelete = true;
    emit(DeleteProductLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + "product/delete-product=admin"));
    request.fields.addAll({'id': '$id'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      Product product = Product.fromJson(jsonData);
      print("ppppppppppp" + product.name!);
      loadDelete = false;
      getProductsByCategoryDio(product.categoryId!);
      emit(DeleteProductSuccessStat("تم حذف العنصر"));
    } else {
      print(response.statusCode.toString());
      loadDelete = false;
      // print(response.reasonPhrase);
      emit(DeleteProductErrorStat("حدث خطأ"));
    }
  }

  bool loadUpdate = false;

  Future updateProduct(Product product) async {
    loadUpdate = true;
    emit(UpdateProductLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + "product/update-product"));
    request.fields.addAll({
      "id":product.id.toString(),
      'name': product.name!,
      'image': product.image!,
      'SellerId': product.sellerId!,
      'Detail': product.detail!,
      'Price': product.price.toString(),
      'CategoryId': product.categoryId.toString(),
      'offerId': '0',
      'Status': '0',
      'city': product.city!,
      'isSlider': 'true',
      "homeCategoryId":product.homeCategoryId.toString()
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      print(await response.stream.bytesToString());
      loadUpdate = false;
      getSliders();
      emit(UpdateProductSuccessStat("success"));
      // getCategories();
    } else {
      loadUpdate = false;
      print(response.reasonPhrase);
      emit(UpdateProductErrorStat("Error"));
    }
  }

  updateStatusProduct({id, status, categoryId, type}) async {
    loadUpdate = true;
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + 'product/update-status-product'));
    request.fields.addAll({'id': id.toString(), 'status': status.toString()});
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      loadUpdate = false;
      if(type==0) {
        getSliders();
      } else {
        getProductsByCategoryDio(categoryId);
      }


      emit(UpdateProductSuccessStat("success"));
    } else {
      print(response.statusCode);
      loadUpdate = false;
      emit(UpdateProductErrorStat("error"));
    }
  }
}
