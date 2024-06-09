import 'package:flutter/cupertino.dart';
import 'package:res_sub01/ui/Detail.dart';

import '../models/RestaurantModel.dart';
import '../ui/home.dart';

Map<String, WidgetBuilder> get route {
  return <String, WidgetBuilder>{
    "/home": (BuildContext context) => home(),
    "/detail": (BuildContext context) => DetailPage(
        restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant)
  };
}
