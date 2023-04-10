import 'market.dart';

class Order {
  int? id;
  String? userId;
  var price;
  int? status ,addressId;
  int? sellerId;
  String? fcmToken;
  String? createdAt;

  Order(
      {this.id,
        this.userId,
        this.fcmToken,
        this.price,
        this.status,
        this.sellerId,
        this.addressId,
        this.createdAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    price = json['price'];
    fcmToken = json['fcmToken'];
    status = json['status'];
    addressId = json['addressId'];
    sellerId = json['sellerId'];
    createdAt = json['createdAt'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['price'] = this.price;
    data['addressId']= addressId ;
    data['status'] = this.status;
    data['fcmToken'] = this.fcmToken;
    data['sellerId'] = this.sellerId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class ResponseOrder {
  String? userPhone;
  String? userName;
  String? userEmail;
  Order? order;
  MarketModel? field;

  ResponseOrder({this.order, this.field,this.userName,this.userPhone,this.userEmail});

  ResponseOrder.fromJson(Map<String, dynamic> json) {
    userPhone = json['userPhone'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    field = json['field'] != null ? MarketModel.fromJson(json['field']) : null;
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userPhone'] = this.userPhone;
    data['userName'] = this.userName;
    data['userEmail'] = this.userEmail;
    if (this.order != null) {
      data['order'] = order!.toJson();
    }
    if (this.field != null) {
      data['field'] = field!.toJson();
    }
    return data;
  }
}
