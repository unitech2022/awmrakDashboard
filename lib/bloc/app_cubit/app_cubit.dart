import 'dart:convert';

import 'package:dashbordawamrak/models/home_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../constants/constans.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);


  ModelHome homeModel = ModelHome();
  bool load = false;
  getHomeData() async {
    load = true;
    emit(HomeGetDataLoad());
    var request =
    http.MultipartRequest('GET', Uri.parse(baseUrl + 'dashboard-home-admin'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);
      homeModel = ModelHome.fromJson(jsonData);

      load = false;
      emit(HomeLoadDataSuccess());
    } else {
      load = false;
      print("errrrrrrrrrror"+response.statusCode.toString());
      emit(HomeLoadDataError());
    }
  }
}
