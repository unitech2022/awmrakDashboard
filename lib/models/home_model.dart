import 'package:dashbordawamrak/models/order.dart';



class ModelHome {
  int? countProduct;
  int? countMarkets;
  int? countOrders;
  int? countUsers;
  List<ResponseOrder>? orders;

  ModelHome(
      {this.countProduct,
        this.countMarkets,
        this.countOrders,
        this.countUsers,
        this.orders});

  ModelHome.fromJson(Map<String, dynamic> json) {
    countProduct = json['countProduct'];
    countMarkets = json['countMarkets'];
    countOrders = json['countOrders'];
    countUsers = json['countUsers'];
    if (json['orders'] != null) {
      orders =[];
      json['orders'].forEach((v) {
        orders!.add( ResponseOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countProduct'] = this.countProduct;
    data['countMarkets'] = this.countMarkets;
    data['countOrders'] = this.countOrders;
    data['countUsers'] = this.countUsers;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
