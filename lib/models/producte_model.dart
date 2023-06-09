class Product {
  int? id;
  String? sellerId;
  int? homeCategoryId;
  String? name;
  String? detail;
  var price;
  bool? isSlider;
  String? image;
  String? city;
  int? categoryId;
  int? offerId;
  int? status;
  String? createAt;

  Product(
      {this.id,
        this.homeCategoryId,
        this.sellerId,
        this.name,
        this.isSlider,
        this.detail,
        this.price,
        this.image,
        this.city,
        this.categoryId,
        this.offerId,
        this.status,
        this.createAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['sellerId'];
    name = json['name'];
    isSlider = json['isSlider'];
    detail = json['detail'];
    price = json['price'];
    image = json['image'];
    city = json['city'];
    homeCategoryId = json['homeCategoryId'];
    categoryId = json['categoryId'];
    offerId = json['offerId'];
    status = json['status'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['sellerId'] = this.sellerId;
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['price'] = this.price;
    data['isSlider'] = this.isSlider;
    data['image'] = this.image;
    data['city'] = this.city;
    data['categoryId'] = this.categoryId;
    data['homeCategoryId'] = this.homeCategoryId;
    data['offerId'] = this.offerId;
    data['status'] = this.status;
    data['createAt'] = this.createAt;
    return data;
  }
}