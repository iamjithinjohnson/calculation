import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data.dart';

class FormData extends StatefulWidget {
  FormData({this.datas});
  final List datas;
  // final String name;
  // final int price;
  // final int quantity;

  //static var priceConttroller = TextEditingController();

  @override
  _FormDataState createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
  List<Data> _datas = [];
  double price = 1.0;
  int quantity = 1;
  double total = 0.0;
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //KeyController controller = Get.put(KeyController());

    var nameController = TextEditingController();
    var priceConttroller = TextEditingController();
    var quantityController = TextEditingController();

    // if (widget.onvalidate) {
    //   //form.currentState.validate();
    //   //controller.totalOf();
    //   //print(_.keyTotal);
    // }
    return GetBuilder<KeyController>(
      builder: (_) {
        return Form(
          key: form,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Material(
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            //initialValue: datas.productname,
                            onSaved: (val) => val,
                            validator: (val) =>
                                val.length > 3 ? null : 'Enter product name',
                            decoration: buildInputDecoration("Name"),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: TextFormField(
                            controller: priceConttroller,
                            keyboardType: TextInputType.number,
                            // onChanged: (value) {
                            //   //   //_.keyPrice = double.parse(value);
                            //   //   //KeyController(keyPrice: double.parse(value));
                            //   //   //controller.totalOf();
                            //   //
                            //   price = double.parse(value);
                            //   total = price * quantity;
                            //   //
                            // },
                            //initialValue: datas.price,
                            onSaved: (val) => val,
                            validator: (val) =>
                                val.length > 0 ? null : 'Enter price',
                            decoration: buildInputDecoration("Price"),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: TextFormField(
                            controller: quantityController,
                            keyboardType: TextInputType.number,
                            // onChanged: (value) {
                            //   // _.keyQuantity = int.parse(value);
                            //   // //KeyController(keyQuantity: int.parse("1"));
                            //   // controller.totalOf();

                            //   quantity = int.parse(value);
                            //   total = price * quantity;
                            // },
                            //initialValue: datas.quantity,
                            onSaved: (val) => val,
                            validator: (val) =>
                                val.length > 0 ? null : 'Enter Quantity',
                            decoration: buildInputDecoration("Qty"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 170),
                          child:
                              // TextFormField(
                              //   initialValue: datas.total = _.keyTotal.toString(),
                              //   //'Total ${datas.total = _.keyTotal}',
                              // ),
                              Text(
                            'Total : $total',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        // RaisedButton(
                        //   child: Text('submit'),
                        //   onPressed: () {
                        //     form.currentState.save();
                        //     form.currentState.validate();
                        //     controller.totalOf();
                        //     print(_.keyTotal);
                        //   },
                        // ),
                        RaisedButton(
                          child: Text('submit'),
                          onPressed: () {
                            form.currentState.save();
                            form.currentState.validate();
                            //controller.totalOf();
                            //print(_.keyTotal);
                            sum(
                              priceConttroller,
                              quantityController,
                              nameController,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void sum(
    TextEditingController price,
    TextEditingController quantity,
    TextEditingController name,
  ) {
    double p = double.parse(price.text);
    double q = double.parse(quantity.text);
    setState(() {
      total = p * q;
    });
    _datas.add(
      Data(
        productname: name.text.toString(),
        price: p,
        quantity: q,
        total: total,
      ),
    );
    print(_datas.length);
    for (var item in _datas) {
      print(item.productname);
      print(item.price);
      print(item.quantity);
      print(item.total);
    }
  }

  InputDecoration buildInputDecoration(String text) {
    return InputDecoration(
        labelText: text,
        filled: true,
        fillColor: Colors.grey[100],
        //focusColor: Colors.green,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        isDense: true);
  }
}

class KeyController extends GetxController {
  // double keyPrice = 0.0;
  // int keyQuantity = 1;
  // double keyTotal = 0.0;
  // var total;

  // totalOf() {
  //   keyTotal = keyPrice * keyQuantity;
  //   update();
  // }

  // @override
  // void onClose() {
  //   // called just before the Controller is deleted from memory
  //   totalOf();
  //   super.onClose();
  // }

  // sampleof() {
  //   // var price = double.parse(FormData.priceConttroller.text);
  //   // var quantity = int.parse(FormData.quantityController.text);
  //   // total = price * quantity;
  //   update();
  // }
}
