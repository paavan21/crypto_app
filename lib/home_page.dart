import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class HomePage extends StatefulWidget {

  List currencies;
  HomePage(this.currencies);
  //const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List currencies;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("crypto"),
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              itemCount: widget.currencies.length,
              itemBuilder: (BuildContext context, int index) {
                final Map currency = widget.currencies[index];
                final MaterialColor color = _colors[index % _colors.length];
               // final Crypto currency = currencies[index];
                return _getListItemUi(currency,color);
              },
            ),
          ),
        ],
      ),
    );
  }

  ListTile _getListItemUi(Map currency,MaterialColor color) {
    return  ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(currency['name'][0]),
      ),
      title:
          Text(currency['name'], style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: _getSubTitleText(
          currency['price_usd'], currency['percent_change_1h']),
      isThreeLine: true,
    );
  // ListTile _getListItemUi(Map currency,MaterialColor color) {
  //   return ListTile(
  //     leading: FadeInImage(placeholder: new AssetImage('assets/2.0x/stars.png'), image: new NetworkImage("http://cryptoicons.co/32@2x/color/"+currency.symbol.toLowerCase()+"@2x.png")),
  //     title: Text(currency.name,
  //         style: const TextStyle(fontWeight: FontWeight.bold)),
  //     subtitle:
  //     _getSubtitleText(currency.price_usd, currency.percent_change_1h),
  //     isThreeLine: true,
  //   );
  }
  }

  Widget _getSubTitleText(String priceUSD, String percentChange) {
    TextSpan priceTextWidget = TextSpan(
        text: "\$$priceUSD\n", style: const TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour: $percentChange%";
    TextSpan percentageChangeTextWidget;

    if (double.parse(percentChange) > 0) {
      percentageChangeTextWidget = TextSpan(
          text: percentageChangeText, style: TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidget = TextSpan(
          text: percentageChangeText, style: TextStyle(color: Colors.red));
    }
    return RichText(
      text: TextSpan(children: [priceTextWidget, percentageChangeTextWidget]),
    );
  }

