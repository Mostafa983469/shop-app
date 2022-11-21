class SearchModel {
  bool? status;
  late Searchdata data;

  SearchModel(Map<String, dynamic> json){
    status = json['status'];
    data = Searchdata(json['data']);
  }
}

class Searchdata{
  int? current_page;
  List<Product> ProductData = [];

  Searchdata(Map<String, dynamic> json){
    current_page = json['current_page'];
    json['data'].forEach((element) {
      ProductData.add(Product(element));
    });
  }
}


class Product{
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;

  Product(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}