import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'outlinedcard.dart';

class CategoriesSlider extends StatelessWidget {
  const CategoriesSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: const [
            OutlinedCard(
                categoryImg: "assets/images/burgersmainpage.png",
                categoryTitle: "Burger"),
            OutlinedCard(
                categoryImg: "assets/images/pizza-sliceMainPage.png",
                categoryTitle: "Pizza"),
            OutlinedCard(
                categoryImg: "assets/images/chicken.png",
                categoryTitle: "Chicken"),
          ],
        ));
  }
}
