import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stock_market/home_page.dart';
import 'package:http/http.dart' as http;

void main() async {
  List currencies = await getCurrencies();
  print(currencies);
  runApp(MyApp(currencies));
}

class MyApp extends StatelessWidget {
  final List _currencies;
  MyApp(this._currencies);
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto',
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),
      home:  HomePage(_currencies),
    );
  }
}
//String ApiKey = "07c6f3bb-32a9-41eb-b369-d8e9fb65edbf";
Future<List> getCurrencies() async {
  // String ApiKey = "07c6f3bb-32a9-41eb-b369-d8e9fb65edbf";
  String cryptoUrl =
      "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";
  http.Response response = await http.get(Uri.parse(cryptoUrl),headers: {'X-CMC_PRO_API_KEY': '07c6f3bb-32a9-41eb-b369-d8e9fb65edbf',"Accept": "application/json"});
  return jsonDecode(response.body);
}

