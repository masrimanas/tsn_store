import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:tsn_store/domain/entities/product.dart';

class ProductModel {
  int? id;
  List<String>? gender;
  String? name;
  int? price;
  String? urlImage;
  List<String>? size;

  ProductModel({
    this.id,
    this.gender,
    this.name,
    this.price,
    this.urlImage,
    this.size,
  });

  ProductModel.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.data()!["id"],
        name = doc.data()!["name"],
        gender = (doc.data()!["gender"] as List)
            .map((item) => item as String)
            .toList(),
        price = doc.data()!["price"],
        urlImage = doc.data()!["url_image"],
        size = (doc.data()!["size"] as List)
            .map((item) => item as String)
            .toList();

  Map<String, dynamic> toFireStore(Product product) => {
        'id': product.id,
        'name': product.name,
        'gender': product.gender.first,
        'price': product.price,
        'url_image': product.urlImage,
        'size': product.size.first,
      };

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      gender: product.gender,
      name: product.name,
      price: product.price,
      urlImage: product.urlImage,
      size: product.size,
    );
  }
  Product toEntity() {
    return Product(
      id: id!,
      gender: gender!,
      name: name!,
      price: price!,
      urlImage: urlImage!,
      size: size!,
    );
  }

  factory ProductModel.fromMap(Map<String, dynamic>? data) => ProductModel(
        id: data?['id'],
        name: data?['name'],
        gender: data?['gender'],
        price: data?['price'],
        urlImage: data?['url_image'],
        size: data?['size'],
      );
}
