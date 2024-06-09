import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:res_sub01/utilities/Constants.dart';
import 'package:res_sub01/utilities/Drawer.dart';
import 'package:res_sub01/utilities/Shimmer.dart';

import '../helper/SizeHelper.dart';
import '../models/RestaurantModel.dart';

class home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<home> {
  double rating = 3.5;
  bool isLoaded = false;
  List<Restaurant> restaurantItems = [];
  List<Restaurant>? restaurant = [];
  var items = <Restaurant>[];
  final controller = TextEditingController();

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        isLoaded = true;
      });
    });
  }

  void filterSearchResults(String query) {
    items.clear();
    setState(() {
      for (int i = 0; i < restaurant!.length; i++) {
        if (restaurant![i].name.toLowerCase().contains(query.toLowerCase())) {
          items.add(restaurant![i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.text.isNotEmpty) {
      restaurantItems
          .where((element) => element.name
              .toLowerCase()
              .contains(controller.text.toLowerCase()))
          .toList();
    } else {
      restaurantItems;
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text('Mal Restaurant'),
            backgroundColor: primaryColor,
            foregroundColor: white,
            elevation: 4,
            leading: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset('assets/images/sendok_garpu.png'))),
        endDrawer: DrawerCustom(),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  controller: controller,
                  decoration: InputDecoration(
                      labelText: "Cari",
                      hintText: "Pencarian",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: FutureBuilder<String>(
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/data/local_restaurant.json'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        restaurant = controller.text.isNotEmpty
                            ? List.from(items)
                            : parseRestaurants(snapshot.data);
                        return Padding(
                          padding: EdgeInsets.all(9.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: restaurant!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: white,
                                elevation: 2,
                                child: Column(
                                  children: [
                                    if ((restaurant?[index].pictureId)!.isEmpty)
                                      _buildErrorImage()
                                    else
                                      isLoaded
                                          ? _buildRestaurantItem(
                                              context, restaurant![index])
                                          : ShimmerWidget(),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return _buildErrorWidget(snapshot.error as String);
                      } else {
                        return _buildLoadingWidget();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: restaurant.pictureId,
        child: Image.network(
          restaurant.pictureId,
          fit: BoxFit.fitHeight,
          width: displayWidth(context) * 0.2,
        ),
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              Text(
                restaurant.name,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: displayWidth(context) * 0.05,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Helvetica'),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: black,
              ),
              const SizedBox(width: 8),
              Text(
                restaurant.city,
                style: TextStyle(
                    fontSize: displayWidth(context) * 0.04, color: black),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              RatingBar.builder(
                ignoreGestures: true,
                itemSize: displayWidth(context) * 0.05,
                initialRating: restaurant.rating,
                glowColor: Colors.transparent,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: primaryColor,
                ),
                onRatingUpdate: (rating) {},
              ),
              SizedBox(width: 50),
              Row(
                children: [
                  Text(
                    restaurant.rating.toString(),
                    style: const TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: restaurant);
      },
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text("Error: $error"),
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorImage() {
    return Stack(
      children: [
        Container(
          width: 80.0,
          height: 120.0,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            shape: BoxShape.rectangle,
          ),
        ),
        const Positioned(
          bottom: 0.0,
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: Icon(
            Icons.broken_image_rounded,
            color: red,
          ),
        ),
      ],
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
