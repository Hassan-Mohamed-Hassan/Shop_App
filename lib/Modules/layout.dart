import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Control/Consistent/Variables.dart';
import 'package:shop_app/Control/Consistent/Widgets.dart';
import 'package:shop_app/Control/Cubit/HomeCubit.dart';
import 'package:shop_app/Control/Statuts/HomeStates.dart';
import 'package:shop_app/Models/CategoriesModel.dart';
import 'package:shop_app/Models/HomePageModel.dart';
import 'package:shop_app/Modules/search.dart';

class LayoutPage extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return BlocConsumer<Home_cubit,HomeStatus>(
        builder: (context,state){
          Home_cubit c=Home_cubit.home_cubit(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              titleSpacing: 20,
              title: Text('Salla',style: TextStyle(fontSize: 25,color: Colors.blue,)),
              actions: [IconButton(onPressed: (){
                navigatorTO(context, SearchPage());
              }, icon: Icon(Icons.search,size: 35,fill: 1,))],
            ),

            body: c.Screens[c.currentindx],

            // bottom navigation bar on scaffold
            bottomNavigationBar:ConvexAppBar(
              style: TabStyle.react,
              height: 64,
              items: [
                TabItem(icon: Icons.home,title: 'Home',),
                TabItem(icon: Icons.apps,title: 'Categories',),
                TabItem(icon: Icons.favorite,title: 'Favorites',),
                TabItem(icon: Icons.settings,title: 'Settings',),
              ],
              initialActiveIndex: c.currentindx,
              backgroundColor: Colors.white,
              color: Colors.black,
              activeColor: Colors.blue,
              onTap: (int i) => c.Change_nav_bar(i),
            ),
          );
        },
        listener: (context,state){});
  }
}

