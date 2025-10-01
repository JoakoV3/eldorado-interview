import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/core/theme/app_theme.dart';
import 'package:interview/domain/models/currency.dart';
import 'package:interview/presentation/bloc/currency_bloc.dart';
import 'package:interview/presentation/widgets/currency_bottom_sheet.dart';

class CurrencySelector extends StatelessWidget {
  final Currency fromCurrency;
  final Currency toCurrency;
  final VoidCallback invertCurrencies;

  const CurrencySelector({
    super.key,
    required this.fromCurrency,
    required this.toCurrency,
    required this.invertCurrencies,
  });

  @override
  Widget build(BuildContext context) {
    final currencyBloc = context.read<CurrencyBloc>();
    final fiatCurrencies = currencyBloc.state.fiatCurrencies;
    final cryptoCurrencies = currencyBloc.state.cryptoCurrencies;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CurrencyItem(
                currency: fromCurrency,
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => CurrencyBottomSheet(
                    currencies: fromCurrency.type == CurrencyType.fiat
                        ? fiatCurrencies
                        : cryptoCurrencies,
                    currencyType: fromCurrency.type,
                    selectedCurrency: fromCurrency,
                    onCurrencySelected: (currency) =>
                        currencyBloc.add(SelectFromCurrencyEvent(currency)),
                  ),
                ),
              ),
              SizedBox(width: 60), // Espacio para el botón central
              _CurrencyItem(
                currency: toCurrency,
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => CurrencyBottomSheet(
                    currencies: toCurrency.type == CurrencyType.fiat
                        ? fiatCurrencies
                        : cryptoCurrencies,
                    currencyType: toCurrency.type,
                    selectedCurrency: toCurrency,
                    onCurrencySelected: (currency) =>
                        currencyBloc.add(SelectToCurrencyEvent(currency)),
                  ),
                ),
              ),
            ],
          ),
        ),

        Positioned(top: -10, left: 40, child: _LabelItem(label: "TENGO")),
        Positioned(top: -10, right: 40, child: _LabelItem(label: "QUIERO")),

        // Botón de swap en el centro
        Positioned(
          top: -5,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: invertCurrencies,
                icon: Icon(Icons.swap_horiz, color: Colors.white),
                iconSize: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LabelItem extends StatelessWidget {
  final String label;
  const _LabelItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      color: Colors.white,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

class _CurrencyItem extends StatelessWidget {
  const _CurrencyItem({required this.currency, required this.onPressed});
  final Currency currency;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Image.asset(currency.assetPath, width: 24, height: 24),
          SizedBox(width: 4),
          Text(currency.code),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
