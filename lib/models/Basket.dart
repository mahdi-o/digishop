class Basket {
  int? id;
  String? nameBasket;
  String? usernameId;
  int? productId;
  int? count;
  int? isPaying;
  String? createdAt;
  String? updatedAt;


  Basket(
      {this.id,
        this.nameBasket,
        this.usernameId,
        this.productId,
      this.count,
      this.isPaying,
      this.createdAt,
      this.updatedAt});

  Basket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameBasket = json['nameBasket'];
    usernameId = json['usernameId'];
    productId = json['productId'];
    count = json['count'];
    isPaying = json['isPaying'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['nameBasket']=nameBasket;
    data['usernameId'] = usernameId;
    data['productId'] = productId;
    data['count'] = count;
    data['isPaying'] = isPaying;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
