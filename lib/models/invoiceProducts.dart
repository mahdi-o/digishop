class InvoiceProducts {
  int? id;
  int? idInvoice;
  int? idProduct;
  int? count;
  int? deleteStatus;


  InvoiceProducts(
      {this.id,
      this.idInvoice,
      this.idProduct,
      this.count,
      this.deleteStatus});

  InvoiceProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idInvoice = json['idInvoice'];
    idProduct = json['idProduct'];
    count = json['count'];
    deleteStatus=json['deleteStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['idInvoice'] = idInvoice;
    data['idProduct'] = idProduct;
    data['count'] = count;
    data['deleteStatus']=deleteStatus;
    return data;
  }
}
