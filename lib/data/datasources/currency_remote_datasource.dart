import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:interview/data/models/api_response.dart';

/// Interfaz para el datasource remoto
abstract class CurrencyRemoteDataSource {
  /// Obtiene la tasa de cambio desde la API
  Future<double> getExchangeRate({
    required int type,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required double amount,
    required String amountCurrencyId,
  });
}

/// Implementación del datasource remoto
class CurrencyRemoteDataSourceImpl implements CurrencyRemoteDataSource {
  final http.Client client;
  // Hardcodeado solo a fines del challenge
  static const String _baseUrl =
      'https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage/orderbook/public/recommendations';

  CurrencyRemoteDataSourceImpl({http.Client? client})
    : client = client ?? http.Client();

  @override
  Future<double> getExchangeRate({
    required int type,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required double amount,
    required String amountCurrencyId,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'type': type.toString(),
        'cryptoCurrencyId': cryptoCurrencyId,
        'fiatCurrencyId': fiatCurrencyId,
        'amount': amount.toString(),
        'amountCurrencyId': amountCurrencyId,
      },
    );

    final response = await client.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Error al obtener la tasa de cambio: ${response.statusCode}. Body: ${response.body}',
      );
    }

    try {
      final jsonResponse = json.decode(response.body);
      final exchangeRate = ApiResponseModel.fromJson(
        jsonResponse,
      ).fiatToCryptoExchangeRate;

      if (exchangeRate == 0) {
        throw Exception('Error: tasa de cambio es 0');
      }

      return exchangeRate;
    } catch (e) {
      throw Exception(
        'Error procesando respuesta de la API: $e. Response body: ${response.body}',
      );
    }
  }
}
