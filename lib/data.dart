class Data {
  String productname;
  double price;
  int quantity;
  double total;

  Data({
    this.productname,
    this.price,
    this.quantity,
    this.total,
  });
}

List<Data> data() {
  return <Data>[
    Data(
      productname: 'jithin',
      price: 200,
      quantity: 1,
      total: 400,
    ),
  ];
}
