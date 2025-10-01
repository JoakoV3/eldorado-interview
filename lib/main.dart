import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/presentation/bloc/currency_bloc.dart';
import 'package:interview/presentation/home_page.dart';
import 'package:interview/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: BlocProvider(
        create: (context) => CurrencyBloc()..add(LoadCurrenciesEvent()),
        child: HomePage(),
      ),
    );
  }
}
