import 'dart:convert';


import 'package:dashbordawamrak/models/care_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../constants/constans.dart';
part 'care_state.dart';

class CareCubit extends Cubit<CareState> {

  CareCubit() : super(CareInitial());
  static CareCubit get(context) => BlocProvider.of<CareCubit>(context);

  List<Care> listCares = [];

  bool loadCares = false;

  getCares() async {
     listCares = [];
     loadCares = true;
    emit(GetCaresLoadStat());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + "cares/get-cares"));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        listCares.add(Care.fromJson(e));
      });
      loadCares = false;
      emit(GetCaresSuccessStat(listCares));
    } else {
      loadCares = false;
      print(response.statusCode);
    }
  }

  bool loadAdd = false;

  Future addCare({care,endPoint,status}) async {
    loadAdd = true;
    emit(AddCareLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + endPoint));


    request.fields.addAll({'name': care.name, 'image': care.image,"desc":care.desc});

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonsDataString;
      print(jsonData);
      loadAdd = false;

        getCares();


      emit(AddCareSuccessStat("success"));
      // getCategories();
    } else {

      loadAdd = false;
      print(response.statusCode.toString() + ">>>>>>>>>>>>>");
      emit(AddCareErrorStat("error"));
    }
  }

  //delete

  bool loadDelete = false;

  deleteCare({id, context, endPoint, status}) async {
    loadDelete = true;
    emit(DeleteCareLoadStat());
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + endPoint));
    request.fields.addAll({'id': '$id'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      loadDelete = false;

      getCares();
      emit(DeleteCareSuccessStat("تم حذف العنصر"));

    } else {
      loadDelete = false;
      print(response.statusCode.toString()+">>>>>>>>>>>>>");
      emit(DeleteCareErrorStat("حدث خطأ"));
    }
  }

  bool loadUpdate = false;

  Future updateCare({category,endPoint,status}) async {
    loadUpdate = true;
    emit(UpdateCaresLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + endPoint));
    request.fields.addAll({
      'name': category.name,
      'image': category.image,
      'id': category.id.toString()
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      print(await response.stream.bytesToString());
      loadUpdate = false;

      getCares();
      emit(UpdateCaresSuccessStat("success"));
      // getCategories();
    } else {
      loadUpdate = false;
      print(response.reasonPhrase);
      emit(UpdateCaresSuccessErrorStat());
    }
  }



  bool loadImage = false;

  Future uploadSelectedFile({objFile}) async {
    loadImage = true;
    emit(UpdateCategoriesLoadImageStat());
    //---Create http package multipart request object

    final request = http.MultipartRequest(
      "POST",
      Uri.parse(baseUrl + "image/upload/car"),
    );
    //-----add other fields if needed

    //-----add selected file with request
    request.files.add(new http.MultipartFile(
        "file", objFile.readStream, objFile.size,
        filename: objFile.name));

    //-------Send request
    var resp = await request.send();

    //------Read response
    String result = await resp.stream.bytesToString();

    //-------Your response
    print(result);
    loadImage = false;
    emit(UpdateCategoriesLoadedImageStat(result));
  }

}
