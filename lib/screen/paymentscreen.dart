import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';
import '../myconfig.dart';

class PaymentScreen extends StatefulWidget {
  final User user;
  final int point;
  final String userpoint;

  const PaymentScreen(
      {super.key,
      required this.user,
      required this.point,
      required this.userpoint});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final df = DateFormat('dd/MM/yyyy');
  late double screenHeight, screenWidth, cardwitdh;
  late User user = User(
    id: "na",
    email: "na",
    name: "na",
    password: "na",
    otp: "na",
    datereg: "na",
    phone: "na",
    point: "na",
  );

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: screenHeight * 0.25,
              width: screenWidth,
              child: Card(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    margin: EdgeInsets.all(11),
                    width: screenWidth * 0.35,
                    height: screenHeight * 0.35,
                    child: Image.asset(
                      "assets/images/bank.jpg",
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          const Text(
                            "Barter Company Bank (72345124)",
                            style: TextStyle(fontSize: 20),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 5, 8),
                            child: Divider(
                              color: Colors.blueGrey,
                              height: 2,
                              thickness: 2.0,
                            ),
                          ),
                          Table(
                            columnWidths: const {
                              0: FractionColumnWidth(0.3),
                              1: FractionColumnWidth(0.7)
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: const [
                              TableRow(children: [
                                Icon(Icons.email),
                                Text(
                                  "barter24@gmail.com",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ]),
                              TableRow(children: [
                                Icon(Icons.phone),
                                Text(
                                  "016-7231247",
                                ),
                              ]),
                            ],
                          ),
                        ],
                      )),
                ]),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 4, 300, 4),
              child: Text(
                "Pay With: ",
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: const Row(
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(' FPX  '),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(' Touch n go'),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(' Credit/debit card '),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
            ),
            const Divider(
              color: Colors.blueGrey,
              height: 2,
              thickness: 2.0,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("TOTAL: RM " + widget.point.toString(),
                  style: TextStyle(fontSize: 26)),
            ),
            const Divider(
              color: Colors.blueGrey,
              height: 2,
              thickness: 2.0,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  width: 275,
                  child: ElevatedButton(
                      onPressed: () {
                        successfulPay();
                      },
                      child: const Text(
                        "Successful Payment",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  width: 275,
                  child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Payment Fail")));
                      },
                      child: const Text("Fail Payment",
                          style: TextStyle(fontSize: 16))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> successfulPay() async {
    Navigator.of(context).pop();
    await http.post(
        Uri.parse(
            "${MyConfig().SERVER}/barterit/php/update_profile.php"), // Need to change
        body: {
          "selectpoint": widget.point.toString(),
          "userid": widget.user.id,
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);

        if (jsondata['status'] == "success") {
          //user = User.fromJson(jsondata['data']);   //error
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Payment Success")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Payment Fail")));
        }
      }
      setState(() {});
    }).timeout(const Duration(seconds: 5));
  }
}
