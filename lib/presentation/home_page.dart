import 'package:flutter/material.dart';
import 'package:interview/core/theme/app_theme.dart';
import 'package:interview/core/widgets/app_button.dart';
import 'package:interview/presentation/widgets/currency_input.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
  const _Currencycontainer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String selectedFromCurrency = 'USDT';
    String selectedToCurrency = 'VES';

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                CurrencySelector(),
                CurrencyInput(
                  selectedCurrency: selectedFromCurrency,
                  onCurrencyChanged: (value) {
                    //TODO: Implementar la lógica para cambiar la moneda
                  },
                ),
                SizedBox(height: 10),
                _BuildInfoRow(label: 'Tasa estimada', value: '= 25.00 VES'),
                _BuildInfoRow(label: 'Recibirás', value: '= 125.00 VES'),
                _BuildInfoRow(label: 'Tiempo estimado', value: '= 10 Min'),
                // Botón de cambiar
                AppButton(
                  text: 'Cambiar',
                  onPressed: () {
                    // Lógica para cambiar
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurrencySelector extends StatelessWidget {
  const CurrencySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primaryColor),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/cripto_currencies/TATUM-TRON-USDT.png',
            width: 24,
            height: 24,
          ),
          Text('USDT'),
        ],
      ),
    );
  }
}

class _BuildInfoRow extends StatelessWidget {
  const _BuildInfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
