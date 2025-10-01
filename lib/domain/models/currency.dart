import 'package:equatable/equatable.dart';

enum CurrencyType { crypto, fiat }

class Currency extends Equatable {
  final String id;
  final String code;
  final String assetPath;
  final CurrencyType type;

  const Currency({
    required this.id,
    required this.code,
    required this.assetPath,
    required this.type,
  });

  @override
  List<Object?> get props => [id, code, assetPath, type];
}
