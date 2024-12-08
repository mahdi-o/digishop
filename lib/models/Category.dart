class Category{
  int? id;
  String? name;
  String? imageAddress;
  int?deleteStatus;

  Category({this.id, this.name, this.imageAddress,this.deleteStatus});

}


List<Category> categoryList = [
  Category(id: 1,name:'dell',imageAddress:'assets/images/icon-dell-color.png',deleteStatus: 0),
  Category(id: 3,name:'microsoft' ,imageAddress:'assets/images/icon-micro-color.png',deleteStatus: 0),
  Category(id: 2,name:'apple' ,imageAddress:'assets/images/icon-apple-black.png',deleteStatus: 0),
  Category(id: 4,name:'hp' ,imageAddress:'assets/images/icon-hp-color.png',deleteStatus: 0),
  Category(id: 8,name:'lenovo' ,imageAddress:'assets/images/icon-lenovo-color.png',deleteStatus: 0),
  Category(id: 7,name:'asus' ,imageAddress:'assets/images/icon-asus-color.png',deleteStatus: 0),
];
