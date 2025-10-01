// Modelo minificado solo a fines del challenge
class ApiResponseModel {
  final double fiatToCryptoExchangeRate;

  ApiResponseModel({required this.fiatToCryptoExchangeRate});

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(
      fiatToCryptoExchangeRate:
          json['data']['byPrice']['fiatToCryptoExchangeRate'] ?? 0,
    );
  }
}
