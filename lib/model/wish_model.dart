import 'package:shoes/model/product_model.dart';

class WishModel {
  String? sId;
  String? userid;
  ProductModel? productid;
  int? quantity;
  int? iV;

  WishModel({this.sId, this.userid, this.productid, this.quantity, this.iV});

  WishModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userid = json['userid'];
    productid = json['productid'] != null
        ? new ProductModel.fromJson(json['productid'])
        : null;
    quantity = json['quantity'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userid'] = this.userid;
    if (this.productid != null) {
      data['productid'] = this.productid!.toJson();
    }
    data['quantity'] = this.quantity;
    data['__v'] = this.iV;
    return data;
  }
}
