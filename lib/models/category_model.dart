class CategoryModel {
  bool? status;
  CategoryDataModel? data;
  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = CategoryDataModel.fromJson(json["data"]);
  }
}

class CategoryDataModel {
  int? currentPage;
  List<DataItemModel>? data = [];
  String? first_page_url;
  int? from;
  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    if (json["data"] != null) {
      json["data"].forEach((e) {
        data!.add(DataItemModel.fromJson(e));
      });
    }
    first_page_url = json["first_page_url"];
    from = json["from"];
  }
}

class DataItemModel {
  dynamic id;
  dynamic name;
  dynamic image;
  DataItemModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
}
