import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coingecko/repository/coin_repo.dart';
import 'package:coingecko/repository/model/coin_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'geckocoins_event.dart';
part 'geckocoins_state.dart';

class GeckoCoinsBloc extends Bloc<GeckoCoinsEvent, GeckoCoinsState> {
  GeckoCoinsBloc({required this.coinRepo}) : super(const GeckoCoinsState()) {
    on<GetCoinsList>(_mapGetToState);
  }

  final GeckoCoinsRepository coinRepo;

  FutureOr<void> _mapGetToState(
      GetCoinsList event, Emitter<GeckoCoinsState> emit) async {
    emit(state.copyWith(coinsStatus: CoinsStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 3), () async {
        var _coins = await coinRepo.getCoins();

        if (_coins != null) {
          emit(state.copyWith(
              coinsStatus: CoinsStatus.loaded, geckoCoins: _coins));
        } else {
          emit(state.copyWith(
              coinsStatus: CoinsStatus.error,
              error: 'Something wented wrong!'));
        }
      });
    } catch (e) {
      emit(
        state.copyWith(coinsStatus: CoinsStatus.error, error: e.toString()),
      );
    }
  }
}
