import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Control/Consistent/Variables.dart';
import 'package:shop_app/Control/Cubit/HomeCubit.dart';
import 'package:shop_app/Control/Statuts/HomeStates.dart';
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Home_cubit,HomeStatus>(
      builder: (context,state){
        Home_cubit c=Home_cubit.home_cubit(context);
        return ConditionalBuilder(
           condition: state is !Favorites_Loding_State,
           builder: (context)=> ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(10),
              itemBuilder: (context,index)=>Row(children: [
                Image(image: NetworkImage('${c.favoritesModel!.data!.data[index].product!.image}'),
                  width: 100,height: 100,),
                SizedBox(width: 15,),
                Expanded(
                  child: Container(
                    height: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${c.favoritesModel!.data!.data[index].product!.name}',
                          overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(),),
                        Spacer(),
                        Row(children: [
                          Text('${c.favoritesModel!.data!.data[index].product!.price}',style: TextStyle(color: Colors.blue),),
                          SizedBox(width: 10,),
                          if(c.favoritesModel!.data!.data[index].product!.discount!=0)
                          Text('${c.favoritesModel!.data!.data[index].product!.oldPrice}',
                          style: TextStyle(decoration: TextDecoration.lineThrough),
                          ),
                        ],),
                        SizedBox(height: 10,)
                      ],
                    ),
                  ),
                ),
                 IconButton(onPressed: (){
          c.Change_Favorites_Products(c.favoritesModel!.data!.data[index].product!.id);
          },
                     icon: Icon(Icons.favorite,
                  color: c.Favorites[c.favoritesModel!.data!.data[index].product!.id]!?Colors.red:Colors.grey[500],
          ))
          ]),
              separatorBuilder: (context,index)=>Container(width: width(context, 1),height: 2,color: Colors.grey,),
              itemCount: c.favoritesModel!.data!.data.length),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
        );
      },
      listener: (context,state){},
    );
  }

}
