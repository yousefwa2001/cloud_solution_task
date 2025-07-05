import 'package:cloud_solutions_task/features/items/models/item_model.dart';
import 'package:flutter/material.dart';

class Itemcard extends StatelessWidget {
  const Itemcard({super.key, required this.item, required this.isSelect});
  final ItemModel item;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isSelect
                ? const Color.fromARGB(255, 185, 82, 82)
                : Colors.black,
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white60,
        border: Border.all(width: 3, color: Colors.white),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          Center(
            child: Text(
              item.name,
              style: TextStyle(
                color: const Color.fromARGB(255, 178, 21, 31),
                fontSize: 35,
                fontFamily: "Arslan",
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fetureTitle(title: "id : "),
                    fetureTitle(title: "Barcode : "),
                    fetureTitle(title: "Name: "),
                    fetureTitle(title: "Pric : "),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    featureSub(sub: item.id.toString()),
                    featureSub(sub: item.barcode),
                    featureSub(sub: item.name),
                    featureSub(sub: item.price.toString()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text featureSub({required String sub}) {
    return Text(
      sub,
      style: const TextStyle(fontSize: 20, color: Colors.blueGrey),
    );
  }

  Text fetureTitle({required String title}) {
    return Text(
      title,
      style: TextStyle(
        color: const Color.fromARGB(255, 178, 21, 31),
        fontSize: 20,
        fontFamily: "archivetempDay",
      ),
    );
  }
}
