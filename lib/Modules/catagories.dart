import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Control/Consistent/Variables.dart';
import 'package:shop_app/Control/Cubit/HomeCubit.dart';
import 'package:shop_app/Control/Statuts/HomeStates.dart';

class CategoriesPage extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return BlocConsumer<Home_cubit,HomeStatus>(
      builder: (context,state){
        Home_cubit c=Home_cubit.home_cubit(context);
        return ListView.separated(
          physics: BouncingScrollPhysics(),
           padding: EdgeInsets.all(10),
            itemBuilder: (context,index)=>Row(children: [
          Image(image: NetworkImage('${c.Categories_model.data!.data[index].image}'),width: 100,height: 100,fit: BoxFit.cover,),
          SizedBox(width: 15,),
          Text('${c.Categories_model.data!.data[index].name}',style: TextStyle(fontFamily: 'BrandinkSans'),),
          Spacer(),
          IconButton(onPressed: (){
            c.Get_categories_details(c.Categories_model.data!.data[index].id!,context);
            print(c.Categories_model.data!.data[index].id!);
          }, icon: Icon(Icons.arrow_forward_ios,color: Colors.blue,)),
      ]),
          separatorBuilder: (context,index)=>Container(width: width(context, 1),height: 2,color: Colors.grey,),
          itemCount: c.Categories_model.data!.data.length);
      },
    listener: (context,state){},
    );
  }

}
