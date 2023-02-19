import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Control/Consistent/Variables.dart';
import 'package:shop_app/Control/Consistent/Widgets.dart';
import 'package:shop_app/Control/Cubit/LoginBloc.dart';
import 'package:shop_app/Control/Statuts/LoginStates.dart';
import 'package:shop_app/Modules/layout.dart';
import 'package:shop_app/View/RegisterPage.dart';
class Registerpage extends StatelessWidget {
  var phonecontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  var emailcontroller=TextEditingController();
  var namecontroller=TextEditingController();
  var formkay=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>Login_cubit(),
      child:BlocConsumer<Login_cubit,LoginStatus>(
        builder: (context,state){
          Login_cubit c=Login_cubit.Get_login_cubit(context);
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkay,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Register',style:TextStyle(fontSize: 25),),
                        SizedBox(height: 10,),
                        Text('Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey),),
                        SizedBox(height: 20,),
                        defaultTextFormField(context: context,
                            controller: namecontroller,
                            keybord: TextInputType.name,
                            field_name: 'User Name',
                            prefix: Icons.person,

                        ),
                        SizedBox(height: 30,),
                        defaultTextFormField(
                            context: context,
                            controller: emailcontroller,
                            keybord: TextInputType.emailAddress,
                            field_name: 'Email',
                            prefix: Icons.email_outlined,
                        ),
                        SizedBox(height: 20,),
                        defaultTextFormField(
                            context: context,
                            controller: passwordcontroller,
                            keybord: TextInputType.text,
                            field_name: 'password',
                            prefix: Icons.lock,
                            suffix: passwordIcon,
                            sucre: scure,
                            suffixfunction: (){c.Change_password_icon();},

                        ),
                        SizedBox(height: 20,),
                        defaultTextFormField(context: context,
                            controller: phonecontroller,
                            keybord: TextInputType.phone,
                            field_name: 'Phone',
                            prefix: Icons.phone,

                        ),
                        SizedBox(height: 20,),
                        ConditionalBuilder(
                          condition: state!=Login_Loding_State,
                          builder:(context)=>defaultButton(
                              context:context,
                              function:(){
                                if(formkay.currentState!.validate()){
                                c.Register_user(
                                      email:  emailcontroller.text,
                                      name: namecontroller.text,
                                      phone: phonecontroller.text,
                                      password: passwordcontroller.text,
                                      context: context);
                              };
                              },
                              widget:Text('Register',style: TextStyle(
                                  fontSize: 20,color: Colors.white,),),
                              color: Colors.blue),

                              fallback:(context)=>Center(child: CircularProgressIndicator()),
                        ),

                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          );
        },
        listener: (context,state){
          if(state is Register_success_State){
            bool status= state.model!.status;
            status?print(state.model!.status):print(state.model!.message);

          }
        },
      ),
    );
  }

}

