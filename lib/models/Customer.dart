class Customer {
  int? id;
  String? nameCustomer;
  String? username;
  String? password;
  String? email;
  String? phoneNumber;
  String? wallet;
  String? address;
  String? description;
  int? isDelete;
  String? createdAt;
  String? updatedAt;

  Customer({
    this.id,
    this.nameCustomer,
    this.username,
    this.password,
    this.email,
    this.phoneNumber,
    this.wallet,
    this.address,
    this.description,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameCustomer = json['nameCustomer'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    wallet = json['wallet'];
    address = json['address'];
    description = json['description'];
    isDelete = json['isDelete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['nameCustomer'] = nameCustomer;
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['wallet'] = wallet;
    data['address'] = address;
    data['description'] = description;
    data['isDelete'] = isDelete;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
