class Category{
  int? id;
  String? name;
  String? imageAddress;

  Category({this.id, this.name, this.imageAddress});

}


List<Category> categoryList = [
  Category(id: 1,name:'dell',imageAddress:'assets/images/icon-dell-color.png'),
  Category(id: 3,name:'microsoft' ,imageAddress:'assets/images/icon-micro-color.png'),
  Category(id: 2,name:'apple' ,imageAddress:'assets/images/icon-apple-black.png'),
  Category(id: 4,name:'hp' ,imageAddress:'assets/images/icon-hp-color.png'),
  Category(id: 8,name:'lenovo' ,imageAddress:'assets/images/icon-lenovo-color.png'),
  Category(id: 7,name:'asus' ,imageAddress:'assets/images/icon-asus-color.png'),
];
