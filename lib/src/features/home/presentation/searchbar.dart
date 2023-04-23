import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        // backgroundColor: Colors.white10,
        width: 350,
        height: 45,
        padding: const EdgeInsets.only(left: 15),
        alignment: Alignment.centerLeft,
        // color: Col,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: Colors.white,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(30, 0, 0, 0),
              spreadRadius: 0.01,
              blurRadius: 9,
              offset: const Offset(0, 3), // changes position of shadow
            )
          ],
        ),
        child: const Text("Search for a food Item",
            style: TextStyle(color: Colors.black26),
            textAlign: TextAlign.start),
      ),
    );
  }
}
