import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Control/Consistent/Variables.dart';
import 'package:shop_app/Control/Consistent/Widgets.dart';
import 'package:shop_app/Control/Cubit/HomeCubit.dart';
import 'package:shop_app/Control/Statuts/HomeStates.dart';
import 'package:shop_app/Models/CategoriesModel.dart';
import 'package:shop_app/Models/HomePageModel.dart';
import 'package:shop_app/Modules/ProductDetails.dart';

class HomePage extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
   return BlocConsumer<Home_cubit,HomeStatus>(
        builder: (context,state){
          Home_cubit c=Home_cubit.home_cubit(context);

          return  ConditionalBuilder(
                condition:c.Home_model!=null&&c.Categories_model!=null,
                builder:(context)=>Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShowCarousel(context,c.Home_model),
                        SizedBox(height: 20,),
                        Text('Categories',style: TextStyle(fontFamily: 'BrandinkSans',fontSize: 20,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Container(
                          height: 100,
                          child: ListView.separated(
                            itemBuilder: (context,index)=>CategoriesItem(c.Categories_model.data!.data[index]),
                            separatorBuilder: (context,index)=>SizedBox(width: 15,),
                            itemCount: c.Categories_model.data!.data.length,
                            scrollDirection: Axis.horizontal,

                          ),
                        ),
                        SizedBox(height: 30,),
                        Text('New Products',style: TextStyle(fontFamily: 'BrandinkSans',fontSize: 15,fontWeight: FontWeight.bold)),
                        SizedBox(height: 15,),
                        ShowGridView(c.Home_model!.data!,context),
                      ],),
                  ),
                ) ,

                fallback: (context)=>Center(child: CircularProgressIndicator(),)
            );
        },
        listener: (context,state){}
        );
 }
 List<Widget> CarselItems(HomeModel model){
   return model.data!.banners.map((e){
     return Image(image: NetworkImage('${e.image}'),fit: BoxFit.cover,);}).toList();
 }

 Widget ShowCarousel(context,model)=> CarouselSlider(
   items:CarselItems(model),
   options:CarouselOptions(
       height: height(context, .3),
       autoPlay: true,
       reverse: false,
       autoPlayAnimationDuration: Duration(seconds: 1),
       initialPage: 0,
       scrollDirection: Axis.horizontal,
       viewportFraction: 1.3,
       autoPlayInterval: Duration(seconds: 3),
       autoPlayCurve: Curves.fastOutSlowIn
   ) ,
 );

 Widget ShowGridView(DataModel model,context)=>GridView.count(
     crossAxisCount: 2,
     physics: NeverScrollableScrollPhysics(),
     mainAxisSpacing: 2,
     crossAxisSpacing: 2,
     shrinkWrap: true,
     childAspectRatio: 1/1.5,
     children: List.generate(model.products.length, (index) =>
         InkWell(
           onTap: ((){
             navigatorTO(context,ProductDetails(
               '${model.products[index].image}',
               '${model.products[index].name}',
               '${model.products[index].price}',
               '${model.products[index].oldPrice}',
               '${model.products[index].description}',

             ));
           }),
           child: Card(
             child: Container(
               padding: EdgeInsets.all(7),
               child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Stack(
                       alignment: AlignmentDirectional.bottomStart,
                       children: [
                         Image(
                           image:NetworkImage('${model.products[index].image}'),
                           height: height(context,.2),
                           width: height(context, .4),
                         ),
                         if(model.products[index].discount !=0)
                           Container(color: Colors.red,width:80,height:20,
                             child: Text('DISCOUNT'),
                           )
                       ],
                     ),
                     SizedBox(height: 5,),
                     Text(
                       '${model.products[index].name}',
                       maxLines: 2,
                       overflow: TextOverflow.ellipsis,

                     ),

                     Row(
                       children: [
                         Column(
                           children: [
                             Text('${model.products[index].price}',
                               style: TextStyle(color: Colors.blue,height: 1.5),),
                             if(model.products[index].discount !=0)
                               Text('${model.products[index].oldPrice}',
                                 style: TextStyle(fontSize: 11,height: 1.5,color: Colors.blue,decoration: TextDecoration.lineThrough),)
                           ],
                         ),
                         Spacer(),
                         IconButton(onPressed: (){
                           Home_cubit.home_cubit(context).Change_Favorites_Products(model.products[index].id);
                         }, icon: Icon(Icons.favorite,
                           color: Home_cubit.home_cubit(context).Favorites[model.products[index].id]!?Colors.red:Colors.grey[500],
                         )
                         ) ],
                     ),
                   ]),
             ),
           ),
         ),
     )
 );
 Widget CategoriesItem(Datum model)=>Stack(
   alignment: AlignmentDirectional.bottomStart,
   children: [
     Image(image: NetworkImage('${model.image}'),width: 100,height: 100,fit: BoxFit.cover,),
     Container(
       width: 100,
       color: Colors.black.withOpacity(.4),
       child: Text('${model.name}',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,),
     )
   ],
 );

}
