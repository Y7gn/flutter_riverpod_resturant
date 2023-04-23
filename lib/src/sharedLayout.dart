import 'package:ecommerceriverpod/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import 'features/home/presentation/homepage.dart';
import 'features/products/presentation/products_list/carousel_slider.dart';
import 'features/products/presentation/products_list/product_grid.dart';

class SharedLayout extends StatefulWidget {
  const SharedLayout({super.key});

  @override
  State<SharedLayout> createState() => _SharedLayoutState();
}

class _SharedLayoutState extends State<SharedLayout> {
  int _currentIndex = 0;
  List<Widget> tabs = const [
    HomePage(),
    ProductsGrid(),
    Text(""),
    Text("data"),
    Text("data"),
  ];
  List<IconData> icons = const [
    Icons.home,
    Icons.search,
    Icons.settings,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          // title: Text('hi mohammed'),
          leading: const Icon(Icons.list, color: Colors.black),
          actions: [
            Theme(
                data: Theme.of(context).copyWith(
                  cardColor: Colors.white,
                ),
                child: PopupMenuButton<MenuAction>(
                  // color: Colors.black,
                  onSelected: (value) async {
                    switch (value) {
                      case MenuAction.logout:
                        final shouldLogout = await showLogOutDialog(context);
                        // devtools.log(value.toString());
                        if (shouldLogout) {
                          // await FirebaseAuth.instance.signOut();
                          // context.pushReplacement("/login");
                        }
                        break;
                    }
                  },
                  itemBuilder: (context) {
                    return const [
                      PopupMenuItem<MenuAction>(
                        value: MenuAction.logout,
                        child: Text('Log out'),
                      )
                    ];
                  },
                )),
          ],
        ),
        body: SafeArea(child: tabs[_currentIndex]),
        // body: SafeArea(child: Container(child: ProductsGrid())),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Get.toNamed(AppRoute.cart);
          },
          child: Icon(Icons.shopping_basket),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Row(
            children: [
              ...List.generate(
                tabs.length,
                (index) {
                  int i = index > 2 ? index - 1 : index;
                  return index == 2
                      ? const Spacer()
                      : Expanded(
                          child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          child: Icon(
                            icons[i],
                            color: _currentIndex == index
                                ? Colors.red
                                : Colors.black,
                          ),
                        ));
                },
              )
            ],
          ),
        ));
    // );
  }
}

enum MenuAction { logout }

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Sign Out"),
        content: const Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancle")),
          TextButton(
              onPressed: () async {
                final box = Hive.box(Constants.authStorageKey);
                await box.delete('token');
                context.push("/login");
              },
              child: const Text("Log out"))
        ],
      );
    },
  ).then((value) => value ?? false);
}
