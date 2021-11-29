import 'dart:convert';

import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:url_launcher/url_launcher.dart';

import 'api/data.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyData(),
    );
  }
}

class MyData extends StatefulWidget {
  const MyData({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyData> {
  // Future<List<Data>>? futureData;

  List<Data> data = [];
  List<String> titleList = [
    'id',
    'store_name',
    'first_name',
    'last_name',
    'email',
    'social',
    'Phone no.',
    'Address',
    'Banner',
    'BannerId',
    'ShopUrl',
    'Categories'
  ];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API and ListView Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter ListView'),
        ),
        body: FutureBuilder(
          // future: fetchData(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              data = snapshot.data as List<Data>;
            }
            if (data.isNotEmpty) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                      defaultColumnWidth: const FixedColumnWidth(150),
                      border: TableBorder.symmetric(
                          inside:
                              const BorderSide(width: 1, color: Colors.blue),
                          outside: const BorderSide(width: 1)),
                      children: [
                        TableRow(
                          children: titleList
                              .map((e) => TableCell(
                                      child: Center(
                                          child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e.toString()),
                                  ))))
                              .toList(),
                        ),
                        for (int i = 0; i < data.length; i++)
                          TableRow(
                            children: List<TableCell>.generate(titleList.length,
                                (int index) {
                              return TableCell(
                                child: Center(
                                  child: index == 8
                                      ? Image.network(
                                          tableCells(index, data[i]),
                                          height: 150,
                                          width: 150)
                                      : index == 10 || index == 5
                                          ? GestureDetector(
                                              onTap: () async {
                                                if (await canLaunch(tableCells(
                                                    index, data[i]))) {
                                                  await launch(tableCells(
                                                      index, data[i]));
                                                } else {
                                                  throw 'Could not launch ${tableCells(index, data[i])}';
                                                }
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  tableCells(index, data[i]),
                                                  style: const TextStyle(
                                                    color: Colors.blue,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : index == 4
                                              ? GestureDetector(
                                                  onTap: () async {
                                                    Email email = Email(to: [
                                                      data[i].email.toString()
                                                    ]);
                                                    EmailLauncher.launch(email)
                                                        .then((value) {
                                                      // success
                                                      print(value);
                                                    }).catchError((error) {
                                                      // has error
                                                      print(error);
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      tableCells(
                                                          index, data[i]),
                                                      style: const TextStyle(
                                                        color: Colors.blue,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(tableCells(
                                                      index, data[i])),
                                                ),
                                ),
                              );
                            }),
                          ),
                      ]),

                  // DataTable(
                  //   horizontalMargin: 2,
                  //   showBottomBorder: true,
                  //   dividerThickness: 3,
                  //   columnSpacing: 20,
                  //   dataRowHeight: 50,
                  //   columns: titleList
                  //       .map<DataColumn>(
                  //         (e) => DataColumn(
                  //             label: Text(
                  //           e.toString(),
                  //           style: const TextStyle(fontStyle: FontStyle.italic),
                  //         )),
                  //       )
                  //       .toList(),
                  //   rows: <DataRow>[
                  //     for (int i = 0; i < data.length; i++)
                  //       DataRow(
                  //         // cells: titleList.map<DataCell>((e) {
                  //         //   return DataCell(
                  //         //     Text(data[i].e.toString()),
                  //         //   );
                  //         // }).toList(),
                  //         cells: <DataCell>[
                  //           DataCell(Container(
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 15),
                  //             child: Text(data[i].id.toString()),
                  //           )),
                  //           DataCell(Container(
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 15),
                  //             child: Text(data[i].storeName.toString()),
                  //           )),
                  //           DataCell(Container(
                  //             // height: 400,
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 10),
                  //             child: Text(data[i].firstName.toString()),
                  //           )),
                  //           DataCell(Container(
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 10),
                  //             child: Text(data[i].lastName.toString()),
                  //           )),
                  //           DataCell(Container(
                  //             padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  //             child: InkWell(
                  //               onTap: () async {
                  //                 Email email =
                  //                     Email(to: [data[i].email.toString()]);
                  //                 EmailLauncher.launch(email).then((value) {
                  //                   // success
                  //                   print(value);
                  //                 }).catchError((error) {
                  //                   // has error
                  //                   print(error);
                  //                 });
                  //               },
                  //               child: Text(
                  //                 data[i].email.toString(),
                  //                 style: const TextStyle(
                  //                     color: Colors.blue,
                  //                     decoration: TextDecoration.underline,
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: 16.0),
                  //               ),
                  //             ),
                  //           )),
                  //           DataCell(Container(
                  //             padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  //             child: InkWell(
                  //               onTap: () async {
                  //                 if (await canLaunch(
                  //                     data[i].social.toString())) {
                  //                   await launch(data[i].social.toString());
                  //                 } else {
                  //                   throw 'Could not launch ${data[i].social.toString()}';
                  //                 }
                  //               },
                  //               child: Text(
                  //                 data[i].social.toString(),
                  //                 style: const TextStyle(
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: 16.0),
                  //               ),
                  //             ),
                  //           )),
                  //           DataCell(Container(
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 10),
                  //             child: Text(data[i].phoneNumber.toString()),
                  //           )),
                  //           DataCell(Container(
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 10),
                  //             child: Text(data[i].address.toString()),
                  //           )),
                  //           // DataCell(Text(data[i].location.toString())),
                  //           DataCell(Container(
                  //             padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  //             child: Image.network(data[i].banner.toString(),
                  //                 height: 200, width: 150),
                  //           )),
                  //           DataCell(Container(
                  //             padding: const EdgeInsets.symmetric(
                  //                 vertical: 10, horizontal: 10),
                  //             child: Text(data[i].bannerId.toString()),
                  //           )),
                  //           DataCell(
                  //             Container(
                  //               padding: const EdgeInsets.symmetric(
                  //                   horizontal: 10, vertical: 10),
                  //               child: GestureDetector(
                  //                 onTap: () async {
                  //                   if (await canLaunch(
                  //                       data[i].shopUrl.toString())) {
                  //                     await launch(
                  //                       data[i].shopUrl.toString(),
                  //                     );
                  //                   } else {
                  //                     throw 'Could not launch ${data[i].shopUrl.toString()}';
                  //                   }
                  //                 },
                  //                 child: Text(
                  //                   data[i].shopUrl.toString(),
                  //                   style: const TextStyle(
                  //                       color: Colors.blue,
                  //                       decoration: TextDecoration.underline,
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 16.0),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           DataCell(Container(
                  //               padding: const EdgeInsets.symmetric(
                  //                   horizontal: 10, vertical: 10),
                  //               child: Text(data[i].categories.toString()))),
                  //         ],
                  //       ),
                  //   ],
                  // ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    print('data');
    final response =
        await http.get(Uri.parse('https://bdc.designtrade.net/bdc/stores'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      // print(jsonResponse);

      for (int i = 0; i < jsonResponse['data']['data'].length; i++) {
        setState(() {});
        data.add(Data(
          id: jsonResponse['data']['data'][i]['id'],
          storeName: jsonResponse['data']['data'][i]['store_name'],
          firstName: jsonResponse['data']['data'][i]['first_name'],
          lastName: jsonResponse['data']['data'][i]['last_name'],
          email: jsonResponse['data']['data'][i]['email'] ?? "",
          social: jsonResponse['data']['data'][i]['social']['twitter'],
          phoneNumber: jsonResponse['data']['data'][i]['phone'],
          showEmail: jsonResponse['data']['data'][i]['show_email'],
          address: jsonResponse['data']['data'][i]['address']['street_1'] +
              jsonResponse['data']['data'][i]['address']['street_2'] +
              jsonResponse['data']['data'][i]['address']['city'],
          // location: jsonResponse['data']['data'][i]['location'],
          banner: jsonResponse['data']['data'][i]['banner'],
          bannerId: jsonResponse['data']['data'][i]['banner_id'],
          shopUrl: jsonResponse['data']['data'][i]['shop_url'],
          categories: jsonResponse['data']['data'][i]['categories'][0]['name'],
        ));
        // print(i);
      }
      // return data;
      // return jsonResponse.map((data) => Data.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  String tableCells(int index, Data cellData) {
    if (index == 0) {
      return cellData.id.toString();
    } else if (index == 1) {
      return cellData.storeName.toString();
    } else if (index == 2) {
      return cellData.firstName.toString();
    } else if (index == 3) {
      return cellData.lastName.toString();
    } else if (index == 4) {
      return cellData.email.toString();
    } else if (index == 5) {
      return cellData.social.toString();
    } else if (index == 6) {
      return cellData.phoneNumber.toString();
    } else if (index == 7) {
      return cellData.address.toString();
    } else if (index == 8) {
      return cellData.banner.toString();
    } else if (index == 9) {
      return cellData.bannerId.toString();
    } else if (index == 10) {
      return cellData.shopUrl.toString();
    } else if (index == 11) {
      return cellData.categories.toString();
    } else {
      return 'data not found';
    }
  }
}
