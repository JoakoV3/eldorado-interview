// Modelo minificado solo a fines del challenge
class ApiResponseModel {
  final double fiatToCryptoExchangeRate;

  ApiResponseModel({required this.fiatToCryptoExchangeRate});

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      final data = json['data'];
      if (data == null) {
        throw Exception('Response data is null');
      }

      final byPrice = data['byPrice'];
      if (byPrice == null) {
        throw Exception('Response byPrice is null');
      }

      final rate = byPrice['fiatToCryptoExchangeRate'];
      if (rate == null) {
        throw Exception('fiatToCryptoExchangeRate is null');
      }

      return ApiResponseModel(fiatToCryptoExchangeRate: double.parse(rate));
    } catch (e) {
      throw Exception('Error parsing API response: $e. JSON: $json');
    }
  }
}
