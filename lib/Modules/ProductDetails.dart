import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Control/Consistent/Variables.dart';
import 'package:shop_app/Control/Consistent/Widgets.dart';
import 'package:shop_app/Control/Cubit/HomeCubit.dart';
import 'package:shop_app/Control/Statuts/HomeStates.dart';
class ProductDetails extends StatelessWidget{
  String ?image;
  String ?price;
  String ?oldprice;
  String ?name;
  String ?dedcraption;
  ProductDetails(this.image,this.name,this.price, this.oldprice,this.dedcraption);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Home_cubit,HomeStatus>(
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Image(image: NetworkImage('$image'),width:width(context, .9),height:height(context,.3),),
                    SizedBox(height: 20,),
                    Text(
                      '$name',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 20,),
                      Text('$price',
                        style: TextStyle(color: Colors.blue,),),
                    SizedBox(height: 10,),
                      Text('$oldprice',
                        style: TextStyle(color: Colors.blue,decoration:TextDecoration.lineThrough),),
                    SizedBox(height: 20,),
                    Text('$dedcraption',style: TextStyle(fontSize: 15),),
                    SizedBox(height: 20,),
                    defaultButton(
                        context: context,
                        function: (){},
                        widget: Text('Add To Carts',style: TextStyle(color: Colors.white)),
                        color: Colors.blue)
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context,state){}
    );
  }
}
