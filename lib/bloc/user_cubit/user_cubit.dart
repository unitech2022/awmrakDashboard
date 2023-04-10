import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

import '../../constants/constans.dart';
import '../../helpers/functions.dart';
import '../../models/user_model.dart';
import '../category_cubit/category_cubit.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of<UserCubit>(context);
  List<UserModel> listAllUsers = [];

  List<UserModel> listAdmins = [];

  List<UserModel> listUsers = [];

  bool loadUsers = false;

  getUsers() async {
    listAllUsers = [];
    listUsers = [];
    listAdmins=[];
    loadUsers = true;
    emit(GetUsersLoadStat());
    var request =
        http.MultipartRequest('GET', Uri.parse(baseUrl + "user/get-all"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        listAllUsers.add(UserModel.fromJson(e));
      });

      listAllUsers.forEach((element) {
        if (element.role == "admin") {
          listAdmins.add(element);
        }

        if (element.role == "user") {
          listUsers.add(element);
        }
      });
      loadUsers = false;
      emit(GetUsersSuccessStat(listUsers));
    } else {
      loadUsers = false;
      print(response.statusCode);
    }
  }


  bool loadDelete = false;

  deleteProduct({id, context}) async {
    print("oooooooooooo");
    loadDelete = true;
    emit(DeleteAdminLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + "user/delete-admin"));
    request.fields.addAll({'userId': '$id'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
   getUsers();
      emit(DeleteAdminSuccessStat());
    } else {
      print(response.statusCode.toString());
      loadDelete = false;
      // print(response.reasonPhrase);
      emit(DeleteAdminErrorStat());
    }
  }

  sendNotification({title,body, context, onSuccess}) async {
    emit(SendNotificationLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + 'api/notification/send/topic'));
    request.fields.addAll({
      'topice': 'user',
      'title': title,
      'body': body,
      'subject': 'dd',
      'imageUrl': '20220412T091809.jpeg',
      'desc': 'ffgg'
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      HelperFunctions.slt.notifyUser(
          color: Colors.green, message: "تم ارسال الرسالة", context: context);
      onSuccess();
      emit(SendNotificationSuccessStat());
    } else {
      print(response.statusCode.toString());
      emit(SendNotificationErrorStat());
    }
  }
}
