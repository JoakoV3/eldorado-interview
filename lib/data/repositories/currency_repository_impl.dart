import 'package:interview/data/datasources/currency_remote_datasource.dart';
import 'package:interview/domain/models/currency.dart';

abstract class ICurrencyRepository {
  List<Currency> getCryptoCurrencies();
  List<Currency> getFiatCurrencies();
  Future<double> getExchangeRate({
    required int type,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required double amount,
    required String amountCurrencyId,
  });
}

class CurrencyRepository implements ICurrencyRepository {
  final CurrencyRemoteDataSource _remoteDataSource;

  CurrencyRepository({CurrencyRemoteDataSource? remoteDataSource})
    : _remoteDataSource = remoteDataSource ?? CurrencyRemoteDataSourceImpl();

  @override
  List<Currency> getCryptoCurrencies() {
    return const [
      Currency(
        id: 'TATUM-TRON-USDT',
        code: 'USDT',
        assetPath: 'assets/cripto_currencies/TATUM-TRON-USDT.png',
        type: CurrencyType.crypto,
      ),
    ];
  }

  @override
  List<Currency> getFiatCurrencies() {
    return const [
      Currency(
        id: 'VES',
        code: 'VES',
        assetPath: 'assets/fiat_currencies/VES.png',
        type: CurrencyType.fiat,
      ),
      Currency(
        id: 'COP',
        code: 'COP',
        assetPath: 'assets/fiat_currencies/COP.png',
        type: CurrencyType.fiat,
      ),
      Currency(
        id: 'BRL',
        code: 'BRL',
        assetPath: 'assets/fiat_currencies/BRL.png',
        type: CurrencyType.fiat,
      ),
      Currency(
        id: 'PEN',
        code: 'PEN',
        assetPath: 'assets/fiat_currencies/PEN.png',
        type: CurrencyType.fiat,
      ),
    ];
  }

  @override
  Future<double> getExchangeRate({
    required int type,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required double amount,
    required String amountCurrencyId,
  }) async {
    try {
      return await _remoteDataSource.getExchangeRate(
        type: type,
        cryptoCurrencyId: cryptoCurrencyId,
        fiatCurrencyId: fiatCurrencyId,
        amount: amount,
        amountCurrencyId: amountCurrencyId,
      );
    } catch (e) {
      throw Exception('Error al conectar con la API: $e');
    }
  }
}
