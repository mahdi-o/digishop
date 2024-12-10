class Invoice {
  int? id;
  int? idCustomer;
  String? nameCustomer;
  String? typePay;
  String? discount;
  int? isPaying;
  String? createdAt;
  String? updatedAt;
  int? deleteStatus;

  Invoice(
      {this.id,
      this.idCustomer,
      this.nameCustomer,
      this.typePay,
      this.discount,
      this.isPaying,
      this.createdAt,
      this.updatedAt,
      this.deleteStatus});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCustomer = json['idCustomer'];
    nameCustomer = json['nameCustomer'];
    typePay = json['typePay'];
    discount = json['discount'];
    isPaying = json['isPaying'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deleteStatus=json['deleteStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['idCustomer'] = idCustomer;
    data['nameCustomer'] = nameCustomer;
    data['typePay'] = typePay;
    data['discount'] = discount;
    data['isPaying'] = isPaying;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deleteStatus']=deleteStatus;
    return data;
  }
}
