import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/data/repositories/currency_repository_impl.dart';
import 'package:interview/domain/models/currency.dart';
import 'package:interview/domain/models/exchange_rate.dart';
import 'package:interview/domain/usecases/convert_currency_usecase.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyRepository _repository;
  final ConvertCurrencyUseCase _convertCurrencyUseCase;

  CurrencyBloc({
    CurrencyRepository? repository,
    ConvertCurrencyUseCase? convertCurrencyUseCase,
  }) : _repository = repository ?? CurrencyRepository(),
       _convertCurrencyUseCase =
           convertCurrencyUseCase ?? ConvertCurrencyUseCase(),
       super(const CurrencyState()) {
    on<LoadCurrenciesEvent>(_onLoadCurrencies);
    on<SelectFromCurrencyEvent>(_onSelectFromCurrency);
    on<SelectToCurrencyEvent>(_onSelectToCurrency);
    on<UpdateAmountEvent>(_onUpdateAmount);
    on<ConvertCurrencyEvent>(_onConvertCurrency);
    on<SwapCurrenciesEvent>(_onSwapCurrencies);
  }

  Future<void> _onLoadCurrencies(
    LoadCurrenciesEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(state.copyWith(status: CurrencyStatus.loading));

    try {
      final cryptoCurrencies = _repository.getCryptoCurrencies();
      final fiatCurrencies = _repository.getFiatCurrencies();

      emit(
        state.copyWith(
          status: CurrencyStatus.loaded,
          cryptoCurrencies: cryptoCurrencies,
          fiatCurrencies: fiatCurrencies,
          selectedFromCurrency: cryptoCurrencies.first,
          selectedToCurrency: fiatCurrencies.first,
          amount: '0',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CurrencyStatus.error,
          errorMessage: 'Error al cargar las monedas: $e',
        ),
      );
    }
  }

  void _onSelectFromCurrency(
    SelectFromCurrencyEvent event,
    Emitter<CurrencyState> emit,
  ) {
    emit(
      state.copyWith(
        selectedFromCurrency: event.currency,
        clearExchangeRate: true,
        clearError: true,
      ),
    );
  }

  void _onSelectToCurrency(
    SelectToCurrencyEvent event,
    Emitter<CurrencyState> emit,
  ) {
    emit(
      state.copyWith(
        selectedToCurrency: event.currency,
        clearExchangeRate: true,
        clearError: true,
      ),
    );
  }

  void _onUpdateAmount(UpdateAmountEvent event, Emitter<CurrencyState> emit) {
    emit(
      state.copyWith(
        amount: event.amount,
        clearExchangeRate: true,
        clearError: true,
      ),
    );
  }

  Future<void> _onConvertCurrency(
    ConvertCurrencyEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    final amount = double.tryParse(state.amount);
    final fromCurrency = state.selectedFromCurrency;
    final toCurrency = state.selectedToCurrency;

    if (amount == null || amount <= 0) {
      emit(
        state.copyWith(
          status: CurrencyStatus.error,
          errorMessage: 'Por favor ingresa un monto válido',
        ),
      );
      return;
    }

    if (fromCurrency == null || toCurrency == null) {
      emit(
        state.copyWith(
          status: CurrencyStatus.error,
          errorMessage: 'Por favor selecciona las monedas',
        ),
      );
      return;
    }

    emit(state.copyWith(status: CurrencyStatus.converting, clearError: true));

    try {
      final exchangeRate = await _convertCurrencyUseCase.execute(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        amount: amount,
      );

      emit(
        state.copyWith(
          status: CurrencyStatus.loaded,
          exchangeRate: exchangeRate,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CurrencyStatus.error,
          errorMessage: 'Error al obtener la tasa de cambio. Intenta más tarde',
        ),
      );
      log(e.toString());
    }
  }

  void _onSwapCurrencies(
    SwapCurrenciesEvent event,
    Emitter<CurrencyState> emit,
  ) {
    emit(
      state.copyWith(
        selectedFromCurrency: state.selectedToCurrency,
        selectedToCurrency: state.selectedFromCurrency,
        clearExchangeRate: true,
        clearError: true,
      ),
    );
  }
}
