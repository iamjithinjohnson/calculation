import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data.dart';

class FormData extends StatelessWidget {
  // final String name;
  // final int price;
  // final int quantity;
  final Data datas;
  final bool onvalidate;

  FormData({
    this.datas,
    this.onvalidate = true,
  });
  final KeyController controller = Get.put(KeyController());

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (onvalidate) {
      //form.currentState.validate();
      //controller.totalOf();
      //print(_.keyTotal);
    }
    return GetBuilder<KeyController>(
      builder: (_) {
        return Form(
          key: form,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                            keyboardType: TextInputType.name,
                            initialValue: datas.productname,
                            onSaved: (val) => datas.productname = val,
                            validator: (val) =>
                                val.length > 3 ? null : 'Enter product name',
                            decoration: buildInputDecoration("Name"),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              _.keyPrice = double.parse(value);
                              //KeyController(keyPrice: double.parse(value));
                              controller.totalOf();
                            },
                            initialValue: datas.price,
                            onSaved: (val) => datas.price = val,
                            validator: (val) =>
                                val.length > 0 ? null : 'Enter price',
                            decoration: buildInputDecoration("Price"),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              _.keyQuantity = int.parse(value);
                              //KeyController(keyQuantity: int.parse("1"));
                              controller.totalOf();
                            },
                            initialValue: datas.quantity,
                            onSaved: (val) => datas.quantity = val,
                            validator: (val) =>
                                val.length > 0 ? null : 'Enter Quantity',
                            decoration: buildInputDecoration("Qty"),
                          ),
                        ),
                      ],
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 170),
                      child:
                          // TextFormField(
                          //   initialValue: datas.total = _.keyTotal.toString(),
                          //   //'Total ${datas.total = _.keyTotal}',
                          // ),
                          Text('Total ${datas.total = _.keyTotal.toString()}'),
                    ),
                    RaisedButton(
                      child: Text('submit'),
                      onPressed: () {
                        form.currentState.save();
                        form.currentState.validate();
                        controller.totalOf();
                        print(_.keyTotal);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
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
  double keyPrice = 0.0;
  int keyQuantity = 1;
  double keyTotal = 0.0;

  totalOf() {
    keyTotal = keyPrice * keyQuantity;
    update();
  }
}
