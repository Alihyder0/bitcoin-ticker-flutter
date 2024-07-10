import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/components/crypto_card.dart';
import 'package:bitcoin_ticker/services/coin_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  bool isWaiting = false;
  String selectedCurrency = 'AUD';

  Map<String, String> coinValues = {};

  void getData() async {
    isWaiting = true;
    try {
      var coinData = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = coinData;
      });
    } catch (e) {
      print(e);
    }
  }

  Column makeCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(CryptoCard(
        selectedCurrency: selectedCurrency,
        value: isWaiting ? '?' : coinValues[crypto],
        cryptoCurrency: crypto,
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  // Future<void> getInitialCoinData() async {
  //   var coinData = await CoinDataModel().getCoinData('BTC', selectedCurrency);
  //   updateUi(coinData);
  // }

  // List<DropdownMenuItem> getDropDownMenuItems() {
  //   List<DropdownMenuItem<String>> dropdownItems = [];

  //   for (int i = 0; i < currenciesList.length; i++) {
  //     String currency = currenciesList[i];
  //     var newItem = DropdownMenuItem(
  //       value: currency,
  //       child: Text(currency),
  //     );
  //     dropdownItems.add(newItem);
  //   }
  //   return dropdownItems;
  // }

  List<Text> getWidgets() {
    List<Text> widgets = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      widgets.add(newItem);
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: CupertinoPicker(
                backgroundColor: Colors.lightBlue,
                itemExtent: 32.0,
                onSelectedItemChanged: (selectedIndex) {
                  setState(() {
                    selectedCurrency = currenciesList[selectedIndex];
                    getData();
                  });
                },
                children: getWidgets(),
              )),
        ],
      ),
    );
  }
}

// DropdownButton(
//                 value: selectedCurrency,
//                 items: getDropDownMenuItems(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedCurrency = value;
//                   });
//                 }),