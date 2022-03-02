import 'package:coingecko/repository/bloc/geckocoins_bloc.dart';
import 'package:coingecko/widgets/history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/coin_repo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.sort,
              color: Colors.black,
            ),
            label: const Text(
              'Sort/Filter',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: RepositoryProvider(
        create: (context) => GeckoCoinsRepository(),
        child: BlocProvider(
          create: (context) =>
              GeckoCoinsBloc(coinRepo: context.read<GeckoCoinsRepository>())
                ..add(GetCoinsList()),
          child: BlocBuilder<GeckoCoinsBloc, GeckoCoinsState>(
            builder: (context, state) {
              if (state.coinsStatus == CoinsStatus.loading) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (state.coinsStatus == CoinsStatus.loaded) {
                return ListView.separated(
                  itemBuilder: (c, i) {
                    var _coin = state.geckoCoins![i];
                    return HistoryTile(
                      image: _coin.image,
                      topText: _coin.name,
                      midText: _coin.price.toString(),
                      bottomText: 'Market Rank: ${_coin.marketRank}',
                    );
                  },
                  separatorBuilder: (c, i) => const SizedBox(height: 4),
                  itemCount: state.geckoCoins!.length,
                );
              }
              if (state.coinsStatus == CoinsStatus.error) {
                return Center(child: Text(state.error));
              }
              return const Text('Something is wrong');
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 12,
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomBarIcons(Icons.bar_chart, true),
              bottomBarIcons(Icons.web_rounded, false),
              bottomBarIcons(Icons.notifications_outlined, false),
              bottomBarIcons(Icons.person_outline, false)
            ],
          ),
        ),
      ),
    );
  }
}

Widget bottomBarIcons(IconData icon, bool selected) {
  return Column(
    children: [
      Icon(
        icon,
        size: 28,
        color: selected ? Colors.black : Colors.grey,
      ),
      const SizedBox(height: 4),
      selected
          ? Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black),
            )
          : const Text('')
    ],
  );
}
