class Order {
  int? id;
  int? idProduct;
  String? nameProduct;
  int? idCustomer;
  String? nameCustomer;
  int? countOrder;
  int? unitPrice;
  int? totalPrice;
  String? typePay;
  String? status;
  String? createdAt;
  String? updatedAt;
  int?deleteStatus;

  Order(
      {this.id,
      this.idProduct,
      this.nameProduct,
      this.idCustomer,
      this.nameCustomer,
      this.countOrder,
      this.unitPrice,
      this.totalPrice,
      this.typePay,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deleteStatus});
  Order.fromJson(Map<String,dynamic>json){
    id = json['id'];
    idProduct = json['idProduct'];
    nameProduct = json['nameProduct'];
    idCustomer = json['idCustomer'];
    nameCustomer = json['nameCustomer'];
    countOrder = json['countOrder'];
    unitPrice = json['unitPrice'];
    totalPrice = json['totalPrice'];
    typePay = json['typePay'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deleteStatus=json['deleteStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] =id;
    data['idProduct'] =idProduct;
    data['nameProduct'] =nameProduct;
    data['idCustomer'] = idCustomer;
    data['nameCustomer'] = nameCustomer;
    data['countOrder'] =countOrder;
    data['unitPrice'] = unitPrice;
    data['totalPrice'] =totalPrice;
    data['typePay'] =typePay;
    data['status'] =status;
    data['createdAt'] =createdAt;
    data['updatedAt'] =updatedAt;
    data['deleteStatus']=deleteStatus;
    return data;
  }

}
