import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dashbordawamrak/bloc/app_cubit/app_cubit.dart';
import 'package:dashbordawamrak/bloc/products_cubit/product_cubit.dart';
import 'package:dashbordawamrak/models/cart_model.dart';
import 'package:dashbordawamrak/models/order.dart';
import 'package:dashbordawamrak/models/producte_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../constants/constans.dart';


part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  static OrderCubit get(context) => BlocProvider.of<OrderCubit>(context);
  List<ResponseOrder> listOrders = [];

  bool loadOrders = false;

  getOrders({endPoint}) async {
    listOrders = [];
    loadOrders = true;
    emit(GetOrdersLoadStat());
    var request = http.MultipartRequest('GET', Uri.parse(baseUrl + endPoint));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var responseBody = await response.stream.bytesToString();
      print(response);
      listOrders = [];
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        listOrders.add(ResponseOrder.fromJson(e));
      });
      loadOrders = false;
      print(listOrders.length.toString() + "ssssssssssssssss");
      emit(GetOrdersSuccessStat(listOrders));
    } else {
      loadOrders = false;
      print(response.statusCode);
      emit(GetOrdersErrorStat("errrror${response.statusCode}"));
    }
  }



  String? currentValue;

  void changeValue(value) {
    currentValue = value;
    emit(ChangeValue());
  }

  bool loadUpdate = false;

  updateStatusOrder({status, id,fcmToken,context,userId}) async {
    loadUpdate = true;
    emit(UpdateOrderLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl+'order/update-status-order-admin'));
    request.fields.addAll({'status': status.toString(), 'id': id.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // var responseBody = await response.stream.bytesToString();
      print("okkkkkkkkkkkkkkk");

      // final data = jsonDecode(responseBody);
      //
      // Order order = Order.fromJson(data);
      // currentValue = status[status];
      if(status== 1) {
        sendNotification(title:"تم ارسال طلب رقم $id" ,body: "الرجاء متابعة صفحة الطلبات",fcmToken:fcmToken,userId: userId );
      }else if(status==0){
        sendNotification(title:"تم وقف طلب رقم $id" ,body: "الرجاء متابعة صفحة الطلبات",fcmToken:fcmToken,userId: userId );
      }
      getOrders(endPoint: "order/get-Orders-admin");
      AppCubit.get(context).getHomeData();
      loadUpdate = false;
      emit(UpdateOrderSuccessStat());
    } else {
      print(response.statusCode);
      loadUpdate = false;
      emit(UpdateOrderErrorStat("error"));
    }
  }


  sendNotification({fcmToken,title,body,userId})async{

    var request = http.MultipartRequest('POST', Uri.parse(baseUrl+'api/notification/send'));
    request.fields.addAll({
      'deviceId':fcmToken,
      'isAndroiodDevice': 'true',
      'title': title,
      'userId': userId,
      'body': body
    });
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("seeeeeeeeeend");
    }
    else {
      print("noooooooooooo");
    }
  }


  bool loadDelete = false;

  deleteOrder({id, context,status}) async {
    loadDelete = true;
    emit(DeleteOrderLoadStat());



    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + "order/delete-Order-admin"));
    request.fields.addAll({'id': '$id'});


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      loadDelete = false;
      if(status==0){
        AppCubit.get(context).getHomeData();
      }else {
        getOrders(endPoint: "order/get-Orders-admin");
      }


      emit(DeleteOrderSuccessStat("تم حذف العنصر"));
    } else {
      loadDelete = false;
      print(response.statusCode.toString());
      emit(DeleteOrderErrorStat("حدث خطأ"));
    }
  }


  bool loadDetails = false;
  List<CartModel> listOrderDetails=[];
  detailsOrder(int id)async{


    listOrderDetails = [];
    loadDetails = true;
      emit(DetailsOrderLoadStat());

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
      final response = await dio.get("order/get-Order-details=admin",
          queryParameters: {'orderId': id.toString()});

      if (response.statusCode == 200) {
        print(response.statusCode);
        var decode = jsonDecode(response.data.toString());
        print(decode);
        listOrderDetails = [];
        decode.forEach((v) {
          listOrderDetails.add(CartModel.fromJson(v));
        });
        loadDetails = false;
        emit(DetailsOrderSuccessStat());
      } else {
        print("errrrrrrrrrror" + response.statusCode.toString());
          emit(DetailsOrderErrorStat());
      }

  }
}
