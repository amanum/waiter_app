import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waiter_app/ui/screen/order/order.screen.dart';

class SelectTableScreen extends StatelessWidget {
  const SelectTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор столика'),
      ),
      body: GridView.count(
        childAspectRatio: 4 / 3,
        crossAxisCount: 2,
        children: [
          _buildTable(context, 1),
          _buildTable(context, 2),
          _buildTable(context, 3),
          _buildTable(context, 4),
        ],
      ),
    );
  }

  Widget _buildTable(BuildContext context, int tableId) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (_) => OrderScreen(tableId)));
      },
      child: Text(tableId.toString()),
    );
  }
}
