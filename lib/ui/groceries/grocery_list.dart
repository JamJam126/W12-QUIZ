import 'package:flutter/material.dart';
import 'package:w12_quiz/ui/groceries/grocery_form.dart';

import '../../data/mock_grocery_repository.dart';
import '../../models/grocery.dart';

class GroceryList extends StatefulWidget {
  final List<Grocery> groceries = dummyGroceryItems;
  GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  void onCreate() async {
    final newGrocery = await Navigator.of(context).push<Grocery>(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );

    if (newGrocery != null) {
      setState(() {
        widget.groceries.add(newGrocery);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (widget.groceries.isNotEmpty) {
      //  Display groceries with an Item builder and  LIst Tile
      content = ListView.builder(
        itemCount: widget.groceries.length,
        itemBuilder: (context, index) => GroceryItem(grocery: widget.groceries[index]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: onCreate, 
            icon: const Icon(Icons.add)
          )
        ],
      ),
      body: content,
    );
  }
}

class GroceryItem extends StatelessWidget {
  const GroceryItem({super.key, required this.grocery});

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(color: grocery.category.color, width: 15, height: 15,),
      title: Text(grocery.name),
      trailing: Text(grocery.quantity.toString()),
    );
  }
}
