import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class CartModel {
  CartModel(
      {required this.url,
      required this.title,
      required this.color,
      this.id = "",
      required this.size,
      required this.price,
      required this.quantity,
      required this.homedelivery,
      required this.addressline1,
      required this.state,
      required this.country,
      required this.landmark,
      required this.pincode});

  String url;
  String title;
  String id;
  String color;
  String price;
  String size;
  String quantity;
  bool homedelivery;
  String addressline1;
  String state;
  String country;
  String landmark;
  String pincode;

  Map<String, dynamic> tojson(CartModel item) {
    return {
      "url": item.url,
      "title": item.title,
      "color": item.color,
      "size": item.size,
      "id": item.id,
      "quantity": item.quantity,
      "price": item.price
    };
  }

  static CartModel fromjson(var data) {
    return CartModel(
        url: data['url'].toString(),
        title: data['title'].toString(),
        price: data['price'].toString(),
        color: data['color'].toString(),
        id: data['id'].toString(),
        size: data['size'].toString(),
        quantity: data['quantity'].toString(),
        homedelivery: data['homedelivery'],
        addressline1: data['addressline1'].toString(),
        state: data['state'].toString(),
        country: data['country'].toString(),
        landmark: data['landmark'].toString(),
        pincode: data['pincode'].toString());
  }
}
