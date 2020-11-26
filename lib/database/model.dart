import 'dart:convert';

Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Client {
  int id;
  String name;
  double price;
  double quantity;
  double total;

  Client({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.total,
  });

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      quantity: json["quantity"],
      total: json["total"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
        "total": total,
      };
}
