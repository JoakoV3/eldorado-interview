import 'package:flutter/material.dart';
import 'package:interview/core/theme/app_theme.dart';

/// Widget para ingresar la cantidad de una moneda
class CurrencyInput extends StatelessWidget {
  const CurrencyInput({
    super.key,
    required this.selectedCurrency,
    required this.onCurrencyChanged,
    this.controller,
    this.enabled = true,
  });

  final String selectedCurrency;
  final Function(String) onCurrencyChanged;
  final TextEditingController? controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            selectedCurrency,
            style: TextStyle(color: AppTheme.primaryColor, fontSize: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enabled,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '0.00',
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurrencyOption {
  final String code;
  final Widget? icon;

  CurrencyOption({required this.code, this.icon});
}
