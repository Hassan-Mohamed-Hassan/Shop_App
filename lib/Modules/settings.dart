import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Control/Consistent/Widgets.dart';
import 'package:shop_app/Control/Cubit/HomeCubit.dart';
import 'package:shop_app/Control/Statuts/HomeStates.dart';

class SettingsPage extends StatelessWidget {
  TextEditingController Controller_name=TextEditingController();
  TextEditingController Controller_email=TextEditingController();
  TextEditingController  Controller_phone=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Home_cubit,HomeStatus>(
      builder: (context,state){
        var model =Home_cubit.home_cubit(context).usermodel;
        Controller_name.text='${model!.data!.name!}';
        Controller_email.text='${model.data!.email!}';
        Controller_phone.text='${model.data!.phone!}';
        return  Padding(
          padding: EdgeInsets.all(20),
          child: ConditionalBuilder(
            condition: model!=null,
            builder: (context)=>SingleChildScrollView(
              child: Column(children: [
                defaultTextFormField(
                  keybord: TextInputType.name,
                  prefix: Icons.person,
                  context: context,
                  controller: Controller_name,
                  field_name: 'name',
                  Validator_funcation: (value){
                    if(value)
                      return 'must be fill this filed ';
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                defaultTextFormField(
                  keybord: TextInputType.emailAddress,
                  prefix: Icons.email,
                  context: context,
                  controller: Controller_email,
                  field_name: 'name',
                  Validator_funcation: (value){
                    if(value)
                      return 'must be fill this filed ';
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                defaultTextFormField(
                  keybord: TextInputType.phone,
                  prefix: Icons.phone,
                  context: context,
                  controller: Controller_phone,
                  field_name: 'name',
                  Validator_funcation: (value){
                    if(value)
                      return 'must be fill this filed ';
                    return null;
                  },
                ),
                SizedBox(height: 30,),
                defaultButton(context: context,
                    function: (){
                  Home_cubit.home_cubit(context).Logout(context);
                    },
                    widget:Text('LOGOUT',style: TextStyle(fontSize: 20,color: Colors.white,),),
                    color: Colors.blue),
                SizedBox(height: 30,),
                defaultButton(context: context,
                    function: (){
                      Home_cubit.home_cubit(context).UpdateProfile(
                        context: context,
                        email:Controller_email.text,
                        name: Controller_name.text,
                        phone: Controller_phone.text,
                      );
                    },
                    widget:Text('UPDATE',style: TextStyle(fontSize: 20,color: Colors.white,),),
                    color: Colors.blue),
              ],

              ),
            ),
            fallback:(context)=>Center(child: CircularProgressIndicator(),) ,
          ),
        );
      },
      listener:(context,state){}
    );
  }
}
