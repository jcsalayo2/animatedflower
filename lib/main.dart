import 'package:animated_flower/hello_bloc/hello_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HelloBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flowers For You',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 2, 27, 27)),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'This Is For You'),
      ),
    );
  }
}
