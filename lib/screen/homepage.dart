import 'package:calculation/database/model.dart';
import 'package:calculation/screen/show.dart';
import 'package:calculation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../data.dart';
import 'empty_state.dart';
import 'package:get/get.dart';
import 'package:calculation/database/database.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data> _datas = [];
  double price = 1.0;
  double quantity = 1;
  double total = 0.0;
  double fulltotal = 0.0;
  bool click = false;

  final form = GlobalKey<FormState>();

  bool firsttouch = true;

  final AddFormController controller = Get.put(AddFormController());

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _qtyFocus = FocusNode();

  Future<List<Client>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = getAllClients();
    //print(asd);
  }

  Future<List<Client>> getAllClients() async {
    final userdata = await DBProvider.db.getAllClients();
    return userdata;
  }

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var priceConttroller = TextEditingController();
    var quantityController = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: lightgrey,
        // floatingActionButton: GetBuilder<AddFormController>(
        //   builder: (_) {
        //     return FloatingActionButton(
        //       child: Icon(Icons.add),
        //       onPressed: onAddForm,
        //       foregroundColor: Colors.white,
        //     );
        //   },
        // ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.picture_in_picture),
                title: Text('Gallery'),
                onTap: () {
                  // enter something
                },
              ),
              ListTile(
                leading: Icon(Icons.location_city),
                title: Text('Location'),
                onTap: () {
                  // enter something
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Dark mode'),
                onTap: () {
                  setState(() {
                    Navigator.pop(context);

                    if (click) {
                      darkmode(click);
                      click = false;
                    } else {
                      darkmode(click);
                      click = true;
                    }
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.hourglass_empty),
                title: Text('Privacy Policy'),
                onTap: () {
                  //enter something
                },
              ),
              ListTile(
                leading: Icon(Icons.hourglass_empty),
                title: Text('Terms and condition'),
                onTap: () {
                  //enter something
                },
              ),
            ],
          ),
        ),
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
                          padding: EdgeInsets.only(right: 20),
                          color: darkmode(click),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton(
                                child: Text(
                                  'Clear',
                                  style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _datas.clear();
                                    DBProvider.db.deleteAll();
                                    total = fulltotal = 0.0;
                                  });
                                },
                              ),
                              AnimatedSwitcher(
                                duration: Duration(milliseconds: 200),
                                key: ValueKey(fulltotal),
                                child: Text(
                                  'Total $fulltotal',
                                  style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: white,
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
                                    key: ValueKey(total),
                                    child: Text(
                                      'Rs $total',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  RaisedButton(
                                    color: darkmode(click),
                                    child: Text(
                                      'submit',
                                      style: TextStyle(
                                        color: white,
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
                // child: _datas.length <= 0
                //     ? Container(
                //         padding: EdgeInsets.only(top: 100),
                //         child: EmptyState(
                //           title: 'Oops',
                //           message: 'Empty Data',
                //         ),
                //       )
                child: FutureBuilder<List<Client>>(
                    future: DBProvider.db.getAllClients(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Client>> snapshot) {
                      if (snapshot.hasData) {
                        return Flexible(
                          child: ListView.builder(
                            //addAutomaticKeepAlives: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              Client item = snapshot.data[index];
                              return Dismissible(
                                key: UniqueKey(),
                                background: Container(color: Colors.grey[200]),
                                onDismissed: (direction) {
                                  DBProvider.db.deleteClient(item.id);
                                },
                                child: Show(
                                  name: item.name,
                                  price: item.price,
                                  quantity: item.quantity,
                                  total: item.total,
                                  click: click,
                                  //total: _datas[index].total,
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                            heightFactor: 5,
                            child: CircularProgressIndicator());
                      }
                    }),
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

  // void onAddForm() {
  //   var _data = Data();

  //   // setState(() {
  //   //   datas.add(
  //   //     FormData(),
  //   //   );
  //   // });
  // }

  void sum(TextEditingController price, TextEditingController quantity,
      TextEditingController name) {
    double p = double.parse(price.text);
    double q = double.parse(quantity.text);
    setState(() {
      total = p * q;
      fulltotal += total;
      var newuser = Client(
        id: 1,
        name: name.text,
        price: p,
        quantity: q,
        total: total,
      );
      DBProvider.db.newClient(newuser);
    });
    _datas.add(
      Data(
        productname: name.text.toString(),
        price: p,
        quantity: q,
        total: total,
      ),
    );

    // print(_datas.length);
    // for (var item in _datas) {
    //   print(item.productname);
    //   print(item.price);
    //   print(item.quantity);
    //   print(item.total);
    // }
  }

  InputDecoration buildInputDecoration(String text) {
    return InputDecoration(
        labelText: text,
        filled: true,
        fillColor: lightgrey,
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
