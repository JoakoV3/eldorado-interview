part of 'currency_bloc.dart';

@immutable
sealed class CurrencyEvent {}

/// Evento para cargar las monedas disponibles (crypto y fiat)
final class LoadCurrenciesEvent extends CurrencyEvent {}

/// Evento para seleccionar la moneda de origen
final class SelectFromCurrencyEvent extends CurrencyEvent {
  final Currency currency;

  SelectFromCurrencyEvent(this.currency);
}

/// Evento para seleccionar la moneda de destino
final class SelectToCurrencyEvent extends CurrencyEvent {
  final Currency currency;

  SelectToCurrencyEvent(this.currency);
}

/// Evento para actualizar el monto a convertir
final class UpdateAmountEvent extends CurrencyEvent {
  final String amount;

  UpdateAmountEvent(this.amount);
}

/// Evento para realizar la conversión de monedas
final class ConvertCurrencyEvent extends CurrencyEvent {}

/// Evento para intercambiar las monedas (swap)
final class SwapCurrenciesEvent extends CurrencyEvent {}
