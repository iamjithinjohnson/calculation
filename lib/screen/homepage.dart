import 'package:calculation/screen/show.dart';
import 'package:flutter/material.dart';
import 'package:calculation/form.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../data.dart';
import '../empty_state.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data> _datas = [];
  double price = 1.0;
  int quantity = 1;
  double total = 0.0;
  double fulltotal = 0.0;
  final form = GlobalKey<FormState>();

  bool firsttouch = true;

  final AddFormController controller = Get.put(AddFormController());

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _qtyFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var priceConttroller = TextEditingController();
    var quantityController = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.grey[100],
        // floatingActionButton: GetBuilder<AddFormController>(
        //   builder: (_) {
        //     return FloatingActionButton(
        //       child: Icon(Icons.add),
        //       onPressed: onAddForm,
        //       foregroundColor: Colors.white,
        //     );
        //   },
        // ),
        body: SafeArea(
          child: Column(
            children: [
              Form(
                key: form,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Material(
                    elevation: 1,
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(8),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton(
                                child: Text(
                                  'Clear',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _datas.clear();
                                    total = fulltotal = 0.0;
                                  });
                                },
                              ),
                              Text(
                                'Total $fulltotal',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: TextFormField(
                                      focusNode: _nameFocus,
                                      onFieldSubmitted: (term) {
                                        _fieldFocusChange(
                                            context, _nameFocus, _priceFocus);
                                      },
                                      textInputAction: TextInputAction.next,
                                      controller: nameController,
                                      keyboardType: TextInputType.name,
                                      //initialValue: datas.productname,
                                      onSaved: (val) => val,
                                      validator: (val) =>
                                          val.length > 0 ? null : 'Enter name',
                                      decoration: buildInputDecoration("Name"),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      focusNode: _priceFocus,
                                      onFieldSubmitted: (term) {
                                        _fieldFocusChange(
                                            context, _priceFocus, _qtyFocus);
                                      },
                                      controller: priceConttroller,
                                      keyboardType: TextInputType.number,
                                      onSaved: (val) => val,
                                      validator: (val) =>
                                          val.length > 0 ? null : 'Enter price',
                                      decoration: buildInputDecoration("Price"),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: TextFormField(
                                      focusNode: _qtyFocus,
                                      onFieldSubmitted: (value) {
                                        form.currentState.save();
                                        form.currentState.validate();
                                        _fieldFocusChange(
                                            context, _qtyFocus, _nameFocus);
                                        sum(
                                          priceConttroller,
                                          quantityController,
                                          nameController,
                                        );
                                        // _fieldFocusChange(
                                        //     context, _qtyFocus, _nameFocus);
                                      },
                                      controller: quantityController,
                                      keyboardType: TextInputType.number,
                                      onSaved: (val) => val,
                                      validator: (val) =>
                                          val.length > 0 ? null : 'Enter Qty',
                                      decoration: buildInputDecoration("Qty"),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 170),
                                    child: Text(
                                      'Rs $total',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  RaisedButton(
                                    color: Colors.blue,
                                    child: Text(
                                      'submit',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    onPressed: () {
                                      form.currentState.save();
                                      form.currentState.validate();
                                      _qtyFocus.unfocus();
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
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: _datas.length <= 0
                    ? Container(
                        padding: EdgeInsets.only(top: 100),
                        child: EmptyState(
                          title: 'Oops',
                          message: 'Add form by tapping add button below',
                        ),
                      )
                    : Flexible(
                        child: ListView.builder(
                          //addAutomaticKeepAlives: true,
                          itemCount: _datas.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            return Show(
                              name: _datas[index].productname,
                              price: _datas[index].price,
                              quantity: _datas[index].quantity,
                              total: _datas[index].total,
                            );
                          },
                        ),
                      ),
              )
            ],
          ),
        ));
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void onAddForm() {
    var _data = Data();

    // setState(() {
    //   datas.add(
    //     FormData(),
    //   );
    // });
  }

  void sum(TextEditingController price, TextEditingController quantity,
      TextEditingController name) {
    double p = double.parse(price.text);
    int q = int.parse(quantity.text);
    setState(() {
      total = p * q;
      fulltotal += total;
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

class AddFormController extends GetxController {
  // void onAddForm() {
  //   var _data = Data();
  //   HomePage.datas.add(FormData(
  //     datas: _data,
  //     //onDelete: () => onDelete(_user),
  //   ));
  //   update();
  // }
}
