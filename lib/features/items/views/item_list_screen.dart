import 'package:cloud_solutions_task/core/widgets/custom_button.dart';
import 'package:cloud_solutions_task/features/items/widgets/item_card.dart';
import 'package:cloud_solutions_task/features/transactions/views/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/item_controller.dart';
import '../models/item_model.dart';
import '../../transactions/controllers/transaction_controller.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Provider.of<ItemController>(context, listen: false);
      controller.fetchItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemController = Provider.of<ItemController>(context);
    final transactionController = Provider.of<TransactionController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TransactionsScreen()),
              );
            },
          ),
        ],
      ),
      body: itemController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : itemController.error != null
          ? Center(child: Text('Error: ${itemController.error}'))
          : Column(
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  height: MediaQuery.sizeOf(context).height * .6,
                  decoration: BoxDecoration(border: Border.all()),
                  child: ListView.builder(
                    itemCount: itemController.items.length,
                    itemBuilder: (context, index) {
                      final ItemModel item = itemController.items[index];
                      return InkWell(
                        onTap: () {
                          itemController.toggleItemSelection(item);
                        },
                        child: Itemcard(
                          item: item,
                          isSelect: itemController.selectedItems.contains(item),
                        ),
                      );
                    },
                  ),
                ),
                CustomButton(
                  text: "Add Transaction",
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);

                    await transactionController
                        .createAndSaveTransactionFromItems(
                          itemController.selectedItems,
                        );

                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text("Transaction saved successfully"),
                      ),
                    );
                  },
                ),
                SizedBox(height: 6),
                CustomButton(
                  backgroundColor: Colors.black,
                  text: "Clear Selected Items",
                  onPressed: () {
                    itemController.clearSelectedItems();
                  },
                ),
              ],
            ),
    );
  }
}
