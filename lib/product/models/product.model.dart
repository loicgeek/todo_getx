import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_getx/product/models/category.model.dart';
import 'package:todo_app_getx/product/models/image.model.dart';

class Product {
  String id;
  String name;
  double price;
  String desc;
  int quantity;
  String userId;
  String username;
  Category category;
  List<ImageModel> gallery;
  List<String> likes;

  Product({
    this.id,
    this.name,
    this.price,
    this.desc,
    this.quantity,
    this.userId,
    this.username,
    this.category,
    this.gallery,
    this.likes,
  });

  factory Product.fromSnapshot(DocumentSnapshot snap) {
    return Product(
      id: snap.documentID,
      name: snap.data["name"],
      price: snap.data['price'],
      desc: snap.data['desc'],
      username: snap.data['username'],
      userId: snap.data['user_id'],
      gallery: List<ImageModel>.from(
          snap.data['gallery'].map((e) => ImageModel.fromJson(e))),
    );
  }

  toJson() {
    return {"name": name, "price": price, "desc": desc};
  }
}
