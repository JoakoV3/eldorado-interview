import 'package:interview/data/repositories/currency_repository_impl.dart';
import 'package:interview/domain/models/currency.dart';
import 'package:interview/domain/models/exchange_rate.dart';

/// Use case para convertir monedas
class ConvertCurrencyUseCase {
  final CurrencyRepository _repository;

  ConvertCurrencyUseCase({CurrencyRepository? repository})
    : _repository = repository ?? CurrencyRepository();

  /// Ejecuta la conversión de monedas
  ///
  /// Retorna un [ExchangeRate] con toda la información de la conversión
  Future<ExchangeRate> execute({
    required Currency fromCurrency,
    required Currency toCurrency,
    required double amount,
  }) async {
    // Determinar el tipo de conversión:
    // 0 -> CRYPTO a FIAT
    // 1 -> FIAT a CRYPTO
    final isCryptoToFiat = fromCurrency.type == CurrencyType.crypto;
    final type = isCryptoToFiat ? 0 : 1;

    final cryptoCurrencyId = isCryptoToFiat ? fromCurrency.id : toCurrency.id;

    final fiatCurrencyId = isCryptoToFiat ? toCurrency.id : fromCurrency.id;

    // Obtener la tasa de cambio desde el repositorio
    final rate = await _repository.getExchangeRate(
      type: type,
      cryptoCurrencyId: cryptoCurrencyId,
      fiatCurrencyId: fiatCurrencyId,
      amount: amount,
      amountCurrencyId: fromCurrency.id,
    );

    // Calcular el monto a recibir
    // Si es crypto a fiat, multiplicamos
    // Si es fiat a crypto, dividimos
    final amountToReceive = isCryptoToFiat ? amount * rate : amount / rate;

    return ExchangeRate(
      rate: rate,
      amountToReceive: amountToReceive,
      fromCurrency: fromCurrency.code,
      toCurrency: toCurrency.code,
      amount: amount,
    );
  }
}
