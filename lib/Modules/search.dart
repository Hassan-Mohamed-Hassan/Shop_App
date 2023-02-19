import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Control/Consistent/Variables.dart';
import 'package:shop_app/Control/Consistent/Widgets.dart';
import 'package:shop_app/Control/Cubit/HomeCubit.dart';
import 'package:shop_app/Control/Statuts/HomeStates.dart';
class SearchPage extends StatelessWidget {
  var searchController=TextEditingController();
   @override
  Widget build(BuildContext context) {
    return  BlocConsumer<Home_cubit,HomeStatus>(
        builder: (context,state) {
          Home_cubit c=Home_cubit.home_cubit(context);
          return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                defaultTextFormField(
                  keybord: TextInputType.text,
                  prefix: Icons.search,
                  context: context,
                  onFieldSubmitted: (value){
                    c.Product_search(text: value.toString());
                  },
                  controller: searchController,
                  field_name: 'search',
                  Validator_funcation: (value){
                    if(value)
                      return 'must be fill this filed ';
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                if(state is Search_Loding_State)LinearProgressIndicator(),
                if(c.searchModel!=null) Expanded(
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(10),
                        itemBuilder:(context,index)=>
                            Row(children: [
                              Image(image: NetworkImage('${c.searchModel!.data!.data[index].image}'),
                          width: 100,height: 100,),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Container(
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${c.searchModel!.data!.data[index].name}',
                                  overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(),),
                                Spacer(),
                                Row(children: [
                                  Text('${c.searchModel!.data!.data[index].price}',
                                    style: TextStyle(color: Colors.blue),),
                                ],),
                                SizedBox(height: 10,)
                              ],
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){
                          c.Change_Favorites_Products(c.searchModel!.data!.data[index].id);
                        },
                          icon: Icon(Icons.favorite,
                            color: c.Favorites[c.searchModel!.data!.data[index].id]!?Colors.red:Colors.grey[500],
                          ),
                        ),
                      ]),
                        separatorBuilder: (context,index)=>Container(width: width(context, 1),height: 2,color: Colors.grey,),
                        itemCount:c.searchModel!.data!.data.length
                  ),
                ),
              ],
            ),
          ),
        );
        },
      listener: (context,state){},
    );
  }
}
