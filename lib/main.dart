import 'package:cloud_solutions_task/features/transactions/services/transaction_local_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/items/controllers/item_controller.dart';
import 'features/items/views/item_list_screen.dart';
import 'features/transactions/controllers/transaction_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemController()),
        ChangeNotifierProvider(
          create: (_) => TransactionController(TransactionLocalDataSource()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'POS Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ItemListScreen(),
      ),
    );
  }
}
