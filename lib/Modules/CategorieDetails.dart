import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Control/Consistent/Variables.dart';
import 'package:shop_app/Control/Consistent/Widgets.dart';
import 'package:shop_app/Control/Cubit/HomeCubit.dart';
import 'package:shop_app/Control/Statuts/HomeStates.dart';
import 'package:shop_app/Modules/ProductDetails.dart';

class CategoriesDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<Home_cubit,HomeStatus>(
        builder:(context,state){
          Home_cubit c=Home_cubit.home_cubit(context);
         List model=c.categories_details_model!.data.data;
          return Scaffold(
            appBar: AppBar(),
            body: ListView.separated(
                itemBuilder:(context,index)=> InkWell(
                  onTap: ((){
                    navigatorTO(context,ProductDetails(
                      '${model[index].image}',
                      '${model[index].name}',
                      '${model[index].price}',
                      '${model[index].oldPrice}',
                      '${model[index].description}',
                    )
                    );
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
                                  image:NetworkImage('${model[index].image}'),
                                  height: height(context,.2),
                                  width: width(context, .4),
                                ),
                                if(model[index].discount !=0)
                                  Container(color: Colors.red,width:80,height:20,
                                    child: Text('DISCOUNT'),
                                  )
                              ],
                            ),
                            SizedBox(height: 5,),
                            Text(
                              '${model[index].name}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,

                            ),

                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('${model[index].price}',
                                      style: TextStyle(color: Colors.blue,height: 1.5),),
                                    if(model[index].discount !=0)
                                      Text('${model[index].oldPrice}',
                                        style: TextStyle(fontSize: 11,height: 1.5,color: Colors.blue,decoration: TextDecoration.lineThrough),)
                                  ],
                                ),
                                Spacer(),
                                IconButton(onPressed: (){
                                  Home_cubit.home_cubit(context).Change_Favorites_Products(model[index].id);
                                }, icon: Icon(Icons.favorite,
                                  color: Home_cubit.home_cubit(context).Favorites[model[index].id]!?Colors.red:Colors.grey[500],
                                )
                                ) ],
                            ),
                          ]),
                    ),
                  ),
                ),
                separatorBuilder:(context,index)=>SizedBox(height: 20,) ,
                itemCount: c.categories_details_model!.data.data.length),
          );},
           listener: (context,state){},
    );
  }
}
