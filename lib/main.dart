import 'package:flutter/material.dart';
import 'package:waiter_app/data/database/cart.database.dart';
import 'package:waiter_app/data/repository/catalog.repository.dart';
import 'package:waiter_app/ui/screen/select_table/select_table.screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogRepository()),
        Provider(create: (context) => CartDatabase()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SelectTableScreen(),
      ),
    );
  }
}
