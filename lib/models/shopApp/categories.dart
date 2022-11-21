class CategoriesModel {
  late bool status ;
  late CategoriesData data;
  CategoriesModel(Map<String,dynamic> json){
    status = json['status'];
    data = CategoriesData(json['data']);
  }

}

class CategoriesData {
  late int currentPage;
  List<DataModel> Data = [];

  CategoriesData(Map<String,dynamic> json){
   currentPage = json['current_page'];
   json['data'].forEach((element) {
     Data.add(DataModel(element));
   });
  }
}

class DataModel{
  late int id ;
  late String name;
  late String image;

  DataModel(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}