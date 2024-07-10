import 'package:bitcoin_ticker/services/network_help.dart';

const apikey = '0424C379-7076-4AE0-A5C6-F91FABAEAD26';
const coinExchangeUrl = 'https://rest.coinapi.io/v1/exchangerate/';

class CoinDataModel {
  Future<dynamic> getCoinData(String coin, String currency) async {
    NetworkHelp networkUrl =
        NetworkHelp(url: '$coinExchangeUrl$coin/$currency?apikey=$apikey');
    var coinData = await networkUrl.getData();
    return coinData;
  }
}
