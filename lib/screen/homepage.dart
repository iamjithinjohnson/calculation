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
  List<FormData> datas = [];
  bool firsttouch = true;

  final AddFormController controller = Get.put(AddFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GetBuilder<AddFormController>(
          builder: (_) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: onAddForm,
              foregroundColor: Colors.white,
            );
          },
        ),
        body: Container(
            color: Colors.grey[100],
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     colors: [
            //       Colors.white,
            //       Colors.grey[200],
            //     ],
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //   ),
            // ),
            child: datas.length <= 0
                ? Center(
                    child: EmptyState(
                      title: 'Oops',
                      message: 'Add form by tapping add button below',
                    ),
                  )
                : FutureBuilder(
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.data == ConnectionState.waiting
                        ? Center(
                            // connection waiting
                            heightFactor: 5,
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            addAutomaticKeepAlives: true,
                            itemCount: datas.length,
                            itemBuilder: (_, i) => datas[i],
                          );
                  })));
  }

  void onAddForm() {
    var _data = Data();
    setState(() {
      datas.add(
        FormData(
          datas: _data,
          //onDelete: () => onDelete(_user),
        ),
      );

      if (firsttouch) {
        FormData(
          onvalidate: false,
          //onDelete: () => onDelete(_user),
        );
        firsttouch = false;
      } else {
        FormData(
          onvalidate: true,
          //onDelete: () => onDelete(_user),
        );
      }
    });
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
