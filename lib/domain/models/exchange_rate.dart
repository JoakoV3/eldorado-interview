import 'package:equatable/equatable.dart';

class ExchangeRate extends Equatable {
  final double rate;
  final double amountToReceive;
  final String fromCurrency;
  final String toCurrency;
  final double amount;

  const ExchangeRate({
    required this.rate,
    required this.amountToReceive,
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
  });

  @override
  List<Object?> get props => [
    rate,
    amountToReceive,
    fromCurrency,
    toCurrency,
    amount,
  ];
}
