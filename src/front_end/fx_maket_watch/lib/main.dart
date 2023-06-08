import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_maket_watch/cubits/interest_select_cubit/interest_select_cubit.dart';
import 'package:fx_maket_watch/screens/home_screen/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<InterestSelectCubit>(
      create: (_) => InterestSelectCubit(),
      child: MaterialApp(
        title: 'FX Market Watch',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 79, 75, 191)),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,

        //TODO check api if user session is stil open before loaing home or login

        home: const MyHomePage(),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}