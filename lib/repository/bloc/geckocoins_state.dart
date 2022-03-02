part of 'geckocoins_bloc.dart';

enum CoinsStatus { initial, loading, loaded, error }

@immutable
class GeckoCoinsState extends Equatable {
  const GeckoCoinsState(
      {this.coinsStatus = CoinsStatus.initial, this.geckoCoins, String? error})
      : error = error ?? '';

  final CoinsStatus coinsStatus;
  final List<GeckoCoin>? geckoCoins;
  final String error;

  @override
  List<Object?> get props => [coinsStatus, geckoCoins, error];

  GeckoCoinsState copyWith(
      {CoinsStatus? coinsStatus, List<GeckoCoin>? geckoCoins, String? error}) {
    return GeckoCoinsState(
      coinsStatus: coinsStatus ?? this.coinsStatus,
      geckoCoins: geckoCoins ?? this.geckoCoins,
      error: error ?? this.error,
    );
  }
}
