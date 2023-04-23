import 'package:ecommerceriverpod/src/features/home/presentation/searchbar.dart';
import 'package:ecommerceriverpod/src/features/home/presentation/titles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../products/presentation/products_list/carousel_slider.dart';
import 'categoriesSlider.dart';
import 'mainTitle.dart';
import 'outlinedcard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MainTitleDart(),
          const SearchBar(),
          const SectionTitle(
            title: "Categories",
          ),
          const CategoriesSlider(),
          const SectionTitle(
            title: "Featured",
          ),
          CarouselSliderWidget(),
        ],
      ),
    );
  }
}
