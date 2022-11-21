class FavouriteModel {
  bool? status;
  late Favourite data;

  FavouriteModel(Map<String, dynamic> json){
    status = json['status'];
    data = Favourite(json['data']);
  }
}

class Favourite{
  int? current_page;
  List<FavouriteData> favouriteData = [];

  Favourite(Map<String, dynamic> json){
    current_page = json['current_page'];
    json['data'].forEach((element) {
      favouriteData.add(FavouriteData(element));
    });
  }
}

class FavouriteData{
  int? FavouriteId ;
  late Product product;

  FavouriteData(Map<String, dynamic> json){
    FavouriteId = json['id'];
    product = Product(json['product']);
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