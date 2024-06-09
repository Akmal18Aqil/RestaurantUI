import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:res_sub01/utilities/Constants.dart';
import 'package:res_sub01/utilities/Drawer.dart';

import '../helper/SizeHelper.dart';
import '../models/RestaurantModel.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';

  final Restaurant restaurant;

  const DetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Detail Restaurant'),
        backgroundColor: primaryColor,
        foregroundColor: white,
        elevation: 4,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      endDrawer: DrawerCustom(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(restaurant.pictureId),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      restaurant.name,
                      style: TextStyle(
                          color: black,
                          fontSize: displayWidth(context) * 0.08,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Helvetica'),
                    ),
                  ),
                  Row(
                    children: [
                      Center(
                        child: Icon(
                          Icons.location_on_outlined,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: displayWidth(context) * 0.008),
                      Center(
                        child: Text(
                          restaurant.city,
                          style: TextStyle(
                              fontSize: displayWidth(context) * 0.06,
                              color: black),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                      Container(
                          height: 30, child: VerticalDivider(color: black)),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 3.0)),
                      RatingBar.builder(
                        ignoreGestures: true,
                        itemSize: displayWidth(context) * 0.045,
                        initialRating: restaurant.rating,
                        glowColor: Colors.transparent,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (_, __) => Icon(
                          Icons.star,
                          color: primaryColor,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      SizedBox(width: displayWidth(context) * 0.085),
                      Row(
                        children: [
                          Text(
                            restaurant.rating.toString(),
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: displayWidth(context) * 0.05),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: black,
                    thickness: 3,
                  ),
                  Padding(padding: EdgeInsets.all(3)),
                  Text(
                    'Deskripsi',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: black,
                        fontSize: displayWidth(context) * 0.05,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Helvetica'),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Text(
                    restaurant.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: black,
                        fontSize: displayWidth(context) * 0.05,
                        fontWeight: FontWeight.normal),
                  ),
                  Divider(
                    color: black,
                    thickness: 1.5,
                  ),
                  Padding(padding: EdgeInsets.all(3)),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Menu',
                      style: TextStyle(
                          color: black,
                          fontSize: displayWidth(context) * 0.06,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Helvetica'),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Column(
                    children: [
                      Container(
                        color: primaryColor,
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        height: displayHeight(context) * 0.085,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text("Menu Makanan",
                                    style: TextStyle(
                                        color: white,
                                        fontSize: displayWidth(context) * 0.05,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Helvetica'))),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.0)),
                            Container(
                                height: 40,
                                child: VerticalDivider(color: white)),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.0)),
                            Expanded(
                                child: Text("Menu Minuman",
                                    style: TextStyle(
                                        color: white,
                                        fontSize: displayWidth(context) * 0.05,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Helvetica')))
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: restaurant.menu.foods.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: primaryColor,
                                elevation: 4,
                                margin: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Text(
                                      '- ' + restaurant.menu.foods[index].name,
                                      style: TextStyle(
                                        color: white,
                                        fontSize: displayWidth(context) * 0.05,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                          Expanded(
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: restaurant.menu.drinks.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  color: primaryColor,
                                  elevation: 5,
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Text(
                                        textAlign: TextAlign.left,
                                        '> ' +
                                            restaurant.menu.drinks[index].name,
                                        style: TextStyle(
                                            color: white,
                                            fontSize:
                                                displayWidth(context) * 0.05,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final String title;

  const MenuTile({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(
        Icons.navigate_next,
        color: black,
      ),
    );
  }
}
