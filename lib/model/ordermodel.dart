
class OrderModel {
  OrderModel(
      {required this.subtotal,
      required this.shipping,
      required this.taxes,
      required this.discount,
      required this.total});

  String subtotal;
  String shipping;
  String taxes;
  String discount;
  String total;

  Map<String, dynamic> tojson(OrderModel data) {
    return {
      "subtotal": data.subtotal,
      "shipping": data.shipping,
      "taxes": data.taxes,
      "discount": data.discount,
      "total": data.total
    };
  }

  OrderModel fromjson(Map<String, dynamic> data) {
    return OrderModel(
        subtotal: data["subtotal"],
        shipping: data["shipping"],
        taxes: data["taxes"],
        discount: data["discount"],
        total: data['total']);
  }
}
