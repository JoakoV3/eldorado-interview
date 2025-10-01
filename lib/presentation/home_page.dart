import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/core/theme/app_theme.dart';
import 'package:interview/core/widgets/app_button.dart';
import 'package:interview/domain/models/currency.dart';
import 'package:interview/presentation/bloc/currency_bloc.dart';

import 'widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.secondaryColor,
      body: Stack(
        children: [
          Positioned(
            top: -size.width * 0.5,
            right: -size.width * 1.6,
            child: ClipOval(
              child: Container(
                width: size.height,
                height: size.height * 1.2,
                decoration: BoxDecoration(color: AppTheme.primaryColor),
              ),
            ),
          ),
          _Currencycontainer(),
        ],
      ),
    );
  }
}

class _Currencycontainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currencyBloc = context.read<CurrencyBloc>();

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        height: size.height,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: BlocBuilder<CurrencyBloc, CurrencyState>(
              builder: (context, state) {
                final selectedFromCurrency = state.selectedFromCurrency;
                final selectedToCurrency = state.selectedToCurrency;

                if (state.status == CurrencyStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (selectedFromCurrency == null ||
                    selectedToCurrency == null) {
                  return const SizedBox.expand(
                    child: Center(child: Text('No se han cargado las monedas')),
                  );
                }

                final isCryptoToFiat =
                    selectedFromCurrency.type == CurrencyType.crypto;

                final fiatCurrencyId = isCryptoToFiat
                    ? selectedToCurrency.id
                    : selectedFromCurrency.id;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    CurrencySelector(
                      fromCurrency: selectedFromCurrency,
                      toCurrency: selectedToCurrency,
                      invertCurrencies: () =>
                          currencyBloc.add(SwapCurrenciesEvent()),
                    ),

                    CurrencyInput(
                      selectedCurrency: selectedFromCurrency.code,
                      onCurrencyChanged: (value) =>
                          currencyBloc.add(UpdateAmountEvent(value)),
                    ),

                    SizedBox(height: 10),

                    if (state.exchangeRate != null) ...{
                      _BuildInfoRow(
                        label: 'Tasa estimada',
                        value: fiatCurrencyId,
                        amount:
                            state.exchangeRate?.rate.toStringAsFixed(2) ?? '',
                      ),
                      _BuildInfoRow(
                        label: 'Recibirás',
                        value: selectedToCurrency.code,
                        amount:
                            state.exchangeRate?.amountToReceive.toStringAsFixed(
                              2,
                            ) ??
                            '',
                      ),
                      _BuildInfoRow(
                        label: 'Tiempo estimado',
                        value: 'Min',
                        amount: '10',
                      ),
                    },

                    AppButton(
                      text: 'Cambiar',
                      isLoading:
                          state.status == CurrencyStatus.converting ||
                          state.status == CurrencyStatus.loading,
                      onPressed: () => currencyBloc.add(ConvertCurrencyEvent()),
                    ),

                    if (state.status == CurrencyStatus.error)
                      Text(
                        state.errorMessage ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildInfoRow extends StatelessWidget {
  const _BuildInfoRow({
    required this.label,
    required this.value,
    this.amount = '',
  });

  final String label;
  final String value;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        Text(
          '= $amount $value',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
