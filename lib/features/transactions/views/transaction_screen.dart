import 'package:cloud_solutions_task/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../transactions/controllers/transaction_controller.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionController>(
        context,
        listen: false,
      ).loadTransactionsFromDb();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TransactionController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unsent Transactions'),
        centerTitle: true,
      ),
      body: controller.transactions.isEmpty
          ? const Center(child: Text('No Unsent transactions found'))
          : Column(
              children: [
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    itemCount: controller.transactions.length,
                    itemBuilder: (context, index) {
                      final txn = controller.transactions[index];
                      final isSelected = controller.selectedTransactions
                          .contains(txn);

                      return CheckboxListTile(
                        value: isSelected,
                        onChanged: (_) {
                          controller.toggleTransactionSelection(txn);
                        },
                        title: Text('Id: ${txn.id}'),
                        subtitle: Text('Date: ${txn.trDate.split("T").first}'),
                      );
                    },
                  ),
                ),
                CustomButton(
                  text: "Upload Transactions",
                  onPressed: () async {
                    if (controller.selectedTransactions.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("No transaction selected"),
                        ),
                      );
                      return;
                    }
                    final messenger = ScaffoldMessenger.of(context);
                    print(controller.selectedTransactions[0].toJson());

                    await controller.uploadSelectedTransactions();

                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Selected transactions have been uploaded ✅",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
