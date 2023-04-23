class Product {
  String? sId;
  int? itemsId;
  String? itemsName;
  String? itemsDesc;
  String? itemsImage;

  Product(
      {this.sId,
      this.itemsId,
      this.itemsName,
      this.itemsDesc,
      this.itemsImage});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    itemsId = json['itemsId'];
    itemsName = json['itemsName'];
    itemsDesc = json['itemsDesc'];
    itemsImage = json['itemsImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['itemsId'] = this.itemsId;
    data['itemsName'] = this.itemsName;
    data['itemsDesc'] = this.itemsDesc;
    data['itemsImage'] = this.itemsImage;
    return data;
  }
}
