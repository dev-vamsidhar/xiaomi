import 'package:flutter/material.dart';
import 'package:frontend/views/cart.view.dart';
import 'package:frontend/views/ordercheckout.view.dart';
import 'package:frontend/views/previousorder.view.dart';
import 'package:frontend/views/products.view.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          final isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            backgroundColor: Colors.grey[50],
            floatingActionButton:
                isSmallScreen && _controller.selectedIndex == 0
                    ? FloatingActionButton(
                        tooltip: "Create Order",
                        onPressed: () {
                          Get.to(ProductSelection(
                            sidebarcontroller: _controller,
                          ));
                        },
                        backgroundColor: Colors.orange,
                        child: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                      )
                    : null,
            key: _key,
            appBar: isSmallScreen && _controller.selectedIndex == 0
                ? AppBar(
                    elevation: 0,
                    backgroundColor: Colors.grey[50],
                    centerTitle: true,
                    title: const Text(
                      "HomePage",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    iconTheme: IconThemeData(color: Colors.black),
                  )
                : null,
            // drawer: SideBar(controller: _controller),
            body: Row(
              children: [
                if (!isSmallScreen) SideBar(controller: _controller),
                Expanded(
                  child: Center(
                    child: _Screens(
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  const SideBar({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: Colors.grey[300],
        textStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
        selectedTextStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        selectedItemDecoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.grey[600],
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.black,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/logo.png'),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            debugPrint('Home');
          },
        ),
        const SidebarXItem(
          icon: Icons.add,
          label: 'Create Order',
        ),
        const SidebarXItem(
          icon: Icons.shopping_bag_outlined,
          label: 'Shopping Cart',
        ),
        const SidebarXItem(
          icon: Icons.person,
          label: 'Profile',
        ),
        const SidebarXItem(
          icon: Icons.settings,
          label: 'Settings',
        ),
      ],
    );
  }
}

class _Screens extends StatelessWidget {
  const _Screens({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return PreviousOrder();
          case 1:
            return ProductSelection(
              sidebarcontroller: controller,
            );
          case 2:
            return Cart();
          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headline5,
            );
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Create Order';
    case 2:
      return 'Shopping Cart';
    case 3:
      return 'Profile';
    case 4:
      return 'Settings';

    default:
      return 'Not found page';
  }
}

const canvasColor = Color.fromARGB(255, 255, 255, 255);
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: Colors.white.withOpacity(0.3), height: 1);
