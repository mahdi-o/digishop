class Product {
  int? id;
  String? nameProduct;
  String? brand;
  String? imageAddress;
  String? price;
  String? ram;
  int? count;
  String? screen;
  String? cpu;
  String? hard;
  int? star;
  String? createdAt;
  String? updatedAt;
  int? deleteStatus;

  Product(
      {this.id,
      this.nameProduct,
      this.brand,
      this.imageAddress,
      this.price,
      this.ram,
      this.count,
      this.screen,
      this.cpu,
      this.hard,
      this.star,
      this.createdAt,
      this.updatedAt,
      this.deleteStatus});



  Product.fromJson(Map<String, dynamic> json) {
      print('object1111111111111111111111');
    id = json['id'];
    nameProduct = json['nameProduct'];
    brand = json['brand'];
    imageAddress = json['imageAddress'];
    price = json['price'];
    ram = json['ram'];
    print('object2222222222222');
    count = json['count'];
    print('object33333333333333333');
    screen = json['screen'];
    cpu = json['cpu'];
    hard = json['hard'];
    star = json['star'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deleteStatus = json['deleteStatus'];
print('object44444444444444');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['nameProduct']=nameProduct;
    data['brand'] = brand;
    data['imageAddress'] = imageAddress;
    data['price'] = price;
    data['ram'] = ram;
    data['count'] = count;
    data['screen']=screen;
    data['cpu'] = cpu;
    data['hard'] = hard;
    data['star'] = star;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deleteStatus']=deleteStatus;
    return data;
  }
}


List<Product> proLaptopList = [
  Product(
      id: 1,
      nameProduct:
          'لپ تاپ 16 اینچی ایسوس مدل Vivobook 16 R1605ZA-MB120-i7 1255U 16GB 512SSD',
      brand: 'asus',
      price: '31500000',
      imageAddress: 'assets/images/laptop-asus1.png',
      ram: '16 گیگابایت',
      cpu: 'Core i7',
      hard: '512 گیگابایت',
      screen: '16 اینچ',
      count: 1,
      star: 4,
    deleteStatus: 0,
  ),
  Product(
      id: 2,
      nameProduct:
          'لپ تاپ 16 اینچی ایسوس مدل Vivobook 16 R1605ZA-MB118-i5 1235U 16GB 512SSD',
      brand: 'asus',
      price: '28200000',
      imageAddress: 'assets/images/laptop-asus2.png',
      ram: '16 گیگابایت',
      cpu: 'Core i5',
      hard: '512 گیگابایت',
      screen: '16 اینچ',
      count: 1,
      star: 4,deleteStatus: 0,),
  Product(
      id: 3,
      nameProduct:
          'لپ تاپ 15.6 اینچی لنوو مدل LOQ 15IRH8-i7 13620H 16GB 512SSD RTX4050',
      brand: 'lenovo',
      price: '55390000',
      imageAddress: 'assets/images/laptop-lenova1.png',
      ram: '16 گیگابایت',
      cpu: 'Core i7',
      hard: '512 گیگابایت',
      screen: '15.6 اینچ',
      count: 1,
      star: 4,deleteStatus: 0,),
  Product(
      id: 4,
      nameProduct:
          'لپ تاپ 15.6 اینچی لنوو مدل ThinkBook 15 G4 IAP-i5 1235U 8GB 512SSD MX550',
      brand: 'lenovo',
      price: '28499000',
      imageAddress: 'assets/images/laptop-lenova2.png',
      ram: '8 گیگابایت',
      cpu: 'Core i5',
      hard: '512 گیگابایت',
      screen: '15.6 اینچ',
      count: 1,
      star: 4,deleteStatus: 0,),
  Product(
      id: 5,
      nameProduct:
          'لپ تاپ 15.6 اینچی اچ‌پی مدل G8 255-R5 5500U 16GB 1SSD - کاستوم شده',
      brand: 'hp',
      price: '24750000',
      imageAddress: 'assets/images/laptop-hp1.png',
      ram: '16 گیگابایت',
      cpu: 'Ryzen 5',
      hard: '1 ترابایت',
      screen: '15.6 اینچ',
      count: 1,
      star: 3,deleteStatus: 0,),
  Product(
      id: 6,
      nameProduct:
          'لپ تاپ 16.1 اینچی اچ‌پی مدل OMEN 16-b0001-i7 11800H 32GB 1SSD RTX3070',
      brand: 'hp',
      price: '58990000',
      imageAddress: 'assets/images/laptop-hp2.png',
      ram: '32 گیگابایت',
      cpu: 'Core i7',
      hard: '1 ترابایت',
      screen: '16 اینچ',
      count: 1,
      star: 4,deleteStatus: 0,),
  Product(
      id: 7,
      nameProduct:
          'لپ تاپ 13.3 اینچی اپل مدل MacBook Air MGN63 2020-M1 8GB 256SSD',
      brand: 'apple',
      price: '51400000',
      imageAddress: 'assets/images/laptop-apple1.png',
      ram: '8 گیگابایت',
      cpu: 'M1',
      hard: '256 گیگابایت',
      screen: '13.3 اینچ',
      count: 1,
      star: 4,deleteStatus: 0,),
  Product(
      id: 8,
      nameProduct: 'لپ تاپ 15.3 اینچی اپل مدل MacBook Air MQKW3 M2 2023',
      brand: 'apple',
      price: '75900000',
      imageAddress: 'assets/images/laptop-apple2.png',
      ram: '8 گیگابایت',
      cpu: 'M2',
      hard: '256 گیگابایت',
      screen: '15.3 اینچ',
      count: 1,
      star: 4,deleteStatus: 0,),
  Product(
      id: 9,
      nameProduct:
          'لپ تاپ 15.6 اینچی دل مدل Inspiron G15 5530-i7 13650HX 16GB 512SSD RTX4050',
      brand: 'dell',
      price: '24750000',
      imageAddress: 'assets/images/laptop-del1.png',
      ram: '16 گیگابایت',
      cpu: 'Core i7',
      hard: '512 گیگابایت',
      screen: '15.6 اینچ',
      count: 1,
      star: 3,deleteStatus: 0,),
  Product(
      id: 10,
      nameProduct:
          'لپ تاپ 15.6 اینچ دل مدل Vostro 3520-i7 16GB 512SSD MX550 Linux - کاستوم شده',
      brand: 'dell',
      price: '39990000',
      imageAddress: 'assets/images/laptop-del2.png',
      ram: '16 گیگابایت',
      cpu: 'Core i7',
      hard: '512 گیگابایت',
      screen: '15.6 اینچ',
      count: 1,
      star: 5,deleteStatus: 0,),
  Product(
      id: 11,
      nameProduct:
          'لپ تاپ 13.5 اینچی مایکروسافت مدل Surface Laptop 4-i5 1135G7 16GB 256SSD',
      brand: 'microsoft',
      price: '40900000',
      imageAddress: 'assets/images/laptop-micro1.png',
      ram: '16 گیگابایت',
      cpu: 'Core i5',
      hard: '256 گیگابایت',
      screen: '13.5 اینچ',
      count: 1,
      star: 4,deleteStatus: 0,),
  Product(
      id: 12,
      nameProduct:
          'لپ تاپ 13.5 اینچی مایکروسافت مدل Surface Laptop 5-i7 32GB 512GB Iris Xe',
      brand: 'microsoft',
      price: '78990000',
      imageAddress: 'assets/images/laptop-micro2.png',
      ram: '32 گیگابایت',
      cpu: 'Core i7',
      hard: '512 گیگابایت',
      screen: '13.5 اینچ',
      count: 1,
      star: 3,deleteStatus: 0,),
];

List<Product> proLaptopListCustom = [
  Product(
      id: 1,
      nameProduct: 'Vivobook 16 R1605ZA-MB120-i7 1255U 16GB 512SSD',
      brand: 'asus',
      price: '31500000',
      imageAddress: 'assets/images/laptop-asus1.png',
      ram: '16 گیگابایت',
      cpu: 'Core i7',
      hard: '512 گیگابایت',
      screen: '16 اینچ',
      count: 1,
      star: 4,deleteStatus: 0,),
  Product(
      id: 2,
      nameProduct: 'Vivobook 16 R1605ZA-MB118-i5 1235U 16GB 512SSD',
      brand: 'asus',
      price: '28200000',
      imageAddress: 'assets/images/laptop-asus2.png',
      ram: '16 گیگابایت',
      cpu: 'Core i5',
      hard: '512 گیگابایت',
      screen: '16 اینچ',
      count: 1,
      star: 4,deleteStatus: 0,),
  Product(
      id: 3,
      nameProduct: 'LOQ 15IRH8-i7 13620H 16GB 512SSD RTX4050',
      brand: 'lenovo',
      price: '55390000',
      imageAddress: 'assets/images/laptop-lenova1.png',
      ram: '16 گیگابایت',
      cpu: 'Core i7',
      hard: '512 گیگابایت',
      screen: '15.6 اینچ',
      count: 1,
      star: 4,deleteStatus: 0,),
  Product(
      id: 4,
      nameProduct: 'ThinkBook 15 G4 IAP-i5 1235U 8GB 512SSD MX550',
      brand: 'lenovo',
      price: '28499000',
      imageAddress: 'assets/images/laptop-lenova2.png',
      ram: '8 گیگابایت',
      cpu: 'Core i5',
      hard: '512 گیگابایت',
      screen: '15.6 اینچ',
      count: 1,
      star: 4,deleteStatus: 0,),
  Product(
      id: 5,
      nameProduct: 'G8 255-R5 5500U 16GB 1SSD',
      brand: 'hp',
      price: '24750000',
      imageAddress: 'assets/images/laptop-hp1.png',
      ram: '16 گیگابایت',
      cpu: 'Ryzen 5',
      hard: '1 ترابایت',
      screen: '15.6 اینچ',
      count: 1,
      star: 3,deleteStatus: 0,),
  Product(
      id: 6,
      nameProduct: 'OMEN 16-b0001-i7 11800H 32GB 1SSD RTX3070',
      brand: 'hp',
      price: '58990000',
      imageAddress: 'assets/images/laptop-hp2.png',
      ram: '32 گیگابایت',
      cpu: 'Core i7',
      hard: '1 ترابایت',
      screen: '16 اینچ',
      count: 1,
      star: 4,deleteStatus: 0,),
  Product(
      id: 7,
      nameProduct: 'MacBook Air MGN63 2020-M1 8GB 256SSD',
      brand: 'apple',
      price: '51400000',
      imageAddress: 'assets/images/laptop-apple1.png',
      ram: '8 گیگابایت',
      cpu: 'M1',
      hard: '256 گیگابایت',
      screen: '13.3 اینچ',
      count: 1,
      star: 4,deleteStatus: 0,),
  Product(
      id: 8,
      nameProduct: 'MacBook Air MQKW3 M2 2023',
      brand: 'apple',
      price: '75900000',
      imageAddress: 'assets/images/laptop-apple2.png',
      ram: '8 گیگابایت',
      cpu: 'M2',
      hard: '256 گیگابایت',
      screen: '15.3 اینچ',
      count: 1,
      star: 4,deleteStatus: 0,),
  Product(
      id: 9,
      nameProduct: 'Inspiron G15 5530-i7 13650HX 16GB 512SSD RTX4050',
      brand: 'dell',
      price: '24750000',
      imageAddress: 'assets/images/laptop-del1.png',
      ram: '16 گیگابایت',
      cpu: 'Core i7',
      hard: '512 گیگابایت',
      screen: '15.6 اینچ',
      count: 1,
      star: 3,deleteStatus: 0,),
  Product(
      id: 10,
      nameProduct: 'Vostro 3520-i7 16GB 512SSD MX550 Linux',
      brand: 'dell',
      price: '39990000',
      imageAddress: 'assets/images/laptop-del2.png',
      ram: '16 گیگابایت',
      cpu: 'Core i7',
      hard: '512 گیگابایت',
      screen: '15.6 اینچ',
      count: 1,
      star: 5,deleteStatus: 0,),
  Product(
      id: 11,
      nameProduct: 'Surface Laptop 4-i5 1135G7 16GB 256SSD',
      brand: 'microsoft',
      price: '40900000',
      imageAddress: 'assets/images/laptop-micro1.png',
      ram: '16 گیگابایت',
      cpu: 'Core i5',
      hard: '256 گیگابایت',
      screen: '13.5 اینچ',
      count: 1,
      star: 4,deleteStatus: 0,),
  Product(
      id: 12,
      nameProduct: 'Surface Laptop 5-i7 32GB 512GB Iris Xe',
      brand: 'microsoft',
      price: '78990000',
      imageAddress: 'assets/images/laptop-micro2.png',
      ram: '32 گیگابایت',
      cpu: 'Core i7',
      hard: '512 گیگابایت',
      screen: '13.5 اینچ',
      count: 1,
      star: 3,deleteStatus: 0,),
];
