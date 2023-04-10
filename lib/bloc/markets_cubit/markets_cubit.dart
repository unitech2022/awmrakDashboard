import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../constants/constans.dart';
import '../../models/market.dart';

part 'markets_state.dart';

class MarketsCubit extends Cubit<MarketsState> {
  MarketsCubit() : super(MarketsInitial());

  static MarketsCubit get(context) => BlocProvider.of<MarketsCubit>(context);

  List<MarketModel> markets = [];

  Map<int, int> favorites = {};

  bool loadMarkets = false;

  getMarkets({city}) async {
    loadMarkets = true;
    markets = [];
    emit(GetMarketsDataLoad());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + 'field/get-all-fields'));

    if (city != null) {
      request.fields.addAll({
        'City': city,
      });
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      jsonData.forEach((v) {
        markets.add(MarketModel.fromJson(v));
      });

      loadMarkets = false;

      emit(GetMarketsDataSuccess());
    } else {
      print(response.reasonPhrase);
      loadMarkets = false;
      emit(GetMarketsDataError());
    }
  }

  bool loadUpdate = false;

  updateStatusMarket({id, status}) async {
    loadUpdate = true;
    emit(UpdateMarketsDataLoad());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + 'field/update-status-field'));
    request.fields.addAll({'id': id.toString(), 'status': status.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      loadUpdate = false;
      getMarkets();
      emit(UpdateMarketsDataSuccess());
    } else {
      print(response.statusCode);
      loadUpdate = false;
      emit(UpdateMarketsDataError());
    }
  }




  bool loadDelete = false;

  deleteMarket({id}) async {
    loadDelete = true;
    emit(DeleteMarketsDataLoad());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + 'field/remove-field'));
    request.fields.addAll({'id': id.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      loadDelete = false;
      getMarkets();
      emit(DeleteMarketsDataSuccess());
    } else {
      print(response.statusCode);
      loadDelete = false;
      emit(DeleteMarketsDataError());
    }
  }


  MarketModel? category;

  void changeValue(MarketModel category2) {
    category = category2;
    emit(ChangeValueSubCategory());
  }

}
