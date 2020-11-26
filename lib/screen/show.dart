import 'package:calculation/theme/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Show extends StatelessWidget {
  final String name;
  final double price;
  final double quantity;
  final double total;
  final bool click;
  Show({
    this.name,
    this.price,
    this.quantity,
    this.total,
    this.click,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Material(
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: [
              Table(
                children: [
                  TableRow(
                      decoration: BoxDecoration(color: darkmode(click)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              children: [Text('Name', style: headtextstyle)]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              children: [Text('Price', style: headtextstyle)]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Text('Quantity', style: headtextstyle)
                          ]),
                        ),
                      ]),
                  TableRow(
                      decoration: BoxDecoration(color: Colors.white),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Column(children: [Text(name, style: textstyle)]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Text('${price.toString()}\t\tRs', style: textstyle)
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Text(quantity.toString(), style: textstyle)
                          ]),
                        )
                      ]),
                ],
              ),
              Container(
                color: white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Total : $total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      IconButton(icon: Icon(Icons.delete), onPressed: null),
                      IconButton(icon: Icon(Icons.create), onPressed: null)
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  TextStyle textstyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  TextStyle headtextstyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: white,
    fontSize: 17,
  );
}
