import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/fake_products_repository.dart';

class CarouselSliderWidget extends StatelessWidget {
  CarouselSliderWidget({super.key});
  final urlImages = [
    'https://res.cloudinary.com/l4ume/image/upload/v1678403231/burgersPhoto/chickwnBurger-removebg-preview_kte8ms.png',
    'https://res.cloudinary.com/l4ume/image/upload/v1678403231/burgersPhoto/chickwnBurger-removebg-preview_kte8ms.png',
    'https://res.cloudinary.com/l4ume/image/upload/v1678403231/burgersPhoto/chickwnBurger-removebg-preview_kte8ms.png',
    // 'assets/images/allim/chickwnBurger-removebg-preview.png',
    // 'assets/images/allim/chickwnBurger-removebg-preview.png',
  ];

  final titles = [
    "Zingen Burger",
    "Chicken Burger",
    "Flexer Burger",
  ];

  final prices = [
    12,
    23,
    24,
  ];
  final paddings = [
    20.0,
    0.0,
    0.0,
  ];
  final ids = [
    "1",
    '2',
    '3',
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final productsListValue = ref.watch(productsListProvider);
      return productsListValue.when(
          data: (products) => CarouselSlider.builder(
                itemCount: paddings.length,
                itemBuilder: (context, index, realIndex) {
                  final id = ids[index];
                  final urlImage = urlImages[index];
                  final title = titles[index];
                  final price = prices[index];
                  final padding = paddings[index];

                  return buildImage(
                      urlImage, title, price, padding, index, id, context);
                },
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  height: 200,
                  viewportFraction: 0.50,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  padEnds: false,
                  enlargeFactor: 0.2,
                  // autoPlay: true,
                ),
              ),
          error: (error, stackTrace) => const Center(
                child: Text("error"),
              ),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              ));
      // return
    });
  }
}

Widget buildImage(String urlImage, String title, int price, double padding,
        int index, String id, BuildContext context) =>
    GestureDetector(
      onTap: () {
        // context.pushNamed("product", params: {'id1': "dsadklaskld"});
        // context.pushNamed("product", params: {'id1': "id"});
        // context.push("/product/$id");
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Container(
          // color: hexStringToColor(cardColor),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 255, 0, 54),
                Color.fromARGB(200, 255, 0, 54),
              ],
            ),
            boxShadow: [
              const BoxShadow(
                color: Color.fromARGB(60, 0, 7, 165),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),

          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: DropShadow(
                      blurRadius: 4.0,
                      borderRadius: 40,
                      offset: const Offset(0, 3),
                      color: Color.fromARGB(161, 49, 49, 49),
                      spread: 1,
                      child: Image.network(urlImage, width: 150),
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      // color: hexStringToColor(fontColor),
                      color: Colors.white,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.star,
                  //       color: Colors.amber[300],
                  //       size: 14,
                  //     ),
                  //     Icon(
                  //       Icons.star,
                  //       color: Colors.amber[300],
                  //       size: 14,
                  //     ),
                  //     Icon(
                  //       Icons.star,
                  //       color: Colors.amber[300],
                  //       size: 14,
                  //     ),
                  //     Icon(
                  //       Icons.star_border_outlined,
                  //       color: Colors.amber[300],
                  //       size: 14,
                  //     ),
                  //     Icon(
                  //       Icons.star_border_outlined,
                  //       color: Colors.amber[300],
                  //       size: 14,
                  //     ),
                  //   ],
                  // ),
                  Text("\$$price",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        // color: hexStringToColor(fontColor)
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
