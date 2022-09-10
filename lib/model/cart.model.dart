import 'package:hive/hive.dart';

class CartModel {
  CartModel(
      {required this.url,
      required this.title,
      required this.color,
      required this.size,
      required this.price,
      required this.quantity});
  @HiveField(0)
  String url;
  String title;
  String color;
  String price;
  String size;
  String quantity;

  Map<String, dynamic> tojson(CartModel item) {
    return {
      "url": item.url,
      "title": item.title,
      "color": item.color,
      "size": item.size,
      "quantity": item.quantity,
      "price": item.price
    };
  }

  CartModel fromjson(Map<String, dynamic> data) {
    return CartModel(
        url: data['url'],
        title: data['title'],
        price: data['price'],
        color: data['color'],
        size: data['size'],
        quantity: data['quantity']);
  }
}
