import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          hintText: 'Search',
          hintStyle: const TextStyle(fontSize: 18),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          suffixIcon: Icon(Icons.search)),
    );
  }
}
