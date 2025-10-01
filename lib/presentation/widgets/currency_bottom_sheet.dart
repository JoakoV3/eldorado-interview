import 'package:flutter/material.dart';
import 'package:interview/domain/models/currency.dart';

class CurrencyBottomSheet extends StatelessWidget {
  final CurrencyType currencyType;
  final List<Currency> currencies;
  final Currency selectedCurrency;
  final Function(Currency) onCurrencySelected;

  const CurrencyBottomSheet({
    super.key,
    required this.currencies,
    required this.currencyType,
    required this.selectedCurrency,
    required this.onCurrencySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 4,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 20),
          Text(currencyType.name.toUpperCase(), style: TextStyle(fontSize: 18)),
          RadioGroup<String>(
            groupValue: selectedCurrency.code,
            onChanged: (value) {
              final selected = currencies.firstWhere((c) => c.code == value);
              onCurrencySelected(selected);
              Navigator.pop(context);
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                final currency = currencies[index];
                return ListTile(
                  title: Text(currency.code),
                  leading: Image.asset(currency.assetPath, width: 24),
                  onTap: () {
                    onCurrencySelected(currency);
                    Navigator.pop(context);
                  },
                  trailing: Radio<String>(value: currency.code),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
