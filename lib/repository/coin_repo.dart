import 'package:coingecko/repository/coin_service.dart';
import 'package:coingecko/repository/model/coin_model.dart';

class GeckoCoinsRepository {
  final CoinService _coinService;

  GeckoCoinsRepository({CoinService? coinService})
      : _coinService = coinService ?? CoinService();

  Future<List<GeckoCoin>?> getCoins() async => await _coinService.getCoins();
}
