import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/Detail.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: const <Widget>[
            MenuTile(title: 'Home'),
            MenuTile(title: 'Tentang Kami'),
            MenuTile(title: 'Menu'),
            MenuTile(title: 'Delivery Order'),
            MenuTile(title: 'Hubungi Kami'),
          ],
        ),
      ),
    );
  }
}
