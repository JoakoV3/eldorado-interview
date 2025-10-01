part of 'currency_bloc.dart';

enum CurrencyStatus { initial, loading, loaded, converting, error }

@immutable
class CurrencyState extends Equatable {
  final CurrencyStatus status;
  final List<Currency> cryptoCurrencies;
  final List<Currency> fiatCurrencies;
  final Currency? selectedFromCurrency;
  final Currency? selectedToCurrency;
  final String amount;
  final ExchangeRate? exchangeRate;
  final String? errorMessage;

  const CurrencyState({
    this.status = CurrencyStatus.initial,
    this.cryptoCurrencies = const [],
    this.fiatCurrencies = const [],
    this.selectedFromCurrency,
    this.selectedToCurrency,
    this.amount = '0',
    this.exchangeRate,
    this.errorMessage,
  });

  CurrencyState copyWith({
    CurrencyStatus? status,
    List<Currency>? cryptoCurrencies,
    List<Currency>? fiatCurrencies,
    Currency? selectedFromCurrency,
    Currency? selectedToCurrency,
    String? amount,
    ExchangeRate? exchangeRate,
    String? errorMessage,
    bool clearExchangeRate = false,
    bool clearError = false,
  }) {
    return CurrencyState(
      status: status ?? this.status,
      cryptoCurrencies: cryptoCurrencies ?? this.cryptoCurrencies,
      fiatCurrencies: fiatCurrencies ?? this.fiatCurrencies,
      selectedFromCurrency: selectedFromCurrency ?? this.selectedFromCurrency,
      selectedToCurrency: selectedToCurrency ?? this.selectedToCurrency,
      amount: amount ?? this.amount,
      exchangeRate: clearExchangeRate
          ? null
          : (exchangeRate ?? this.exchangeRate),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    status,
    cryptoCurrencies,
    fiatCurrencies,
    selectedFromCurrency,
    selectedToCurrency,
    amount,
    exchangeRate,
    errorMessage,
  ];
}
