// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:async';

import 'package:coingecko/repository/model/coin_model.dart';
import 'package:dio/dio.dart';

class CoinService {
  final Dio dio;

  CoinService({Dio? dio}) : dio = dio ?? Dio();

  final String _url =
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false';

  Future<List<GeckoCoin>?> getCoins() async {
    Response response;

    List<GeckoCoin> coins = [];

    response =
        await dio.get(_url, options: Options(responseType: ResponseType.plain));

    print(response.data);

    if (response.statusCode == 200) {
      print(response.statusCode);

      final List resBody = json.decode(response.data.toString());

      print('This is body ---> ${resBody.length}');

      coins = resBody.map((e) => GeckoCoin.fromMap(e)).toList();

      print('This is coins ---> ${coins.length}');

      return coins;
    }

    return null;
  }
}
