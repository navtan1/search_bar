import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final products = [
    "Book",
    "Pen",
    "Pencil",
    "Bag",
    "Compass Box",
    "Class 1",
    "Class 2",
    "Class 3",
    "Class 4",
    "Class 5",
    "Stationery",
    "Crafts and Material",
    "Office Stationery",
  ];

  final recentProducts = [
    "Book",
    "Pen",
    "Pencil",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 250,
        color: Colors.grey,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var suggestion = query.isEmpty
        ? recentProducts
        : products.where((element) => element.startsWith(query)).toList();

    return Text('');
  }
}
