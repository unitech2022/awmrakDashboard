class CartModel {
  int? id;
  int? orderId;
  String? image;
  String? nameProduct;
  int? productId;
  int? price;
  int? total;
  int? marketId;
  String? userId;
  int? quantity;

  CartModel(
      {this.id,
        this.orderId,
        this.image,
        this.nameProduct,
        this.productId,
        this.price,
        this.total,
        this.marketId,
        this.userId,
        this.quantity});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    image = json['image'];
    nameProduct = json['nameProduct'];
    productId = json['productId'];
    price = json['price'];
    total = json['total'];
    marketId = json['market_id'];
    userId = json['userId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderId'] = this.orderId;
    data['image'] = this.image;
    data['nameProduct'] = this.nameProduct;
    data['productId'] = this.productId;
    data['price'] = this.price;
    data['total'] = this.total;
    data['market_id'] = this.marketId;
    data['userId'] = this.userId;
    data['quantity'] = this.quantity;
    return data;
  }
}
