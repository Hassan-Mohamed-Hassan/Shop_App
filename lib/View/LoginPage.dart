import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Control/Consistent/Variables.dart';
import 'package:shop_app/Control/Consistent/Widgets.dart';
import 'package:shop_app/Control/Cubit/LoginBloc.dart';
import 'package:shop_app/Control/Statuts/LoginStates.dart';
import 'package:shop_app/View/RegisterPage.dart';

class LoginPage extends StatelessWidget {
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Login',style:TextStyle(fontFamily:'BrandinkSans',fontSize: 25),),
                        SizedBox(height: 10,),
                        Text('Login now to browse our hot offers',style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey),),
                        SizedBox(height: 30,),
                        defaultTextFormField(context: context, controller: emailcontroller,keybord: TextInputType.emailAddress, field_name: 'Email', prefix: Icons.email_outlined),
                        SizedBox(height: 20,),
                        defaultTextFormField(context: context, controller: passwordcontroller,keybord: TextInputType.text,field_name: 'password',
                            prefix: Icons.lock,
                            suffix: passwordIcon,
                            sucre: scure,
                            suffixfunction: (){c.Change_password_icon();}
                        ),
                        SizedBox(height: 20,),
                        ConditionalBuilder(
                             condition: state!=Login_Loding_State,
                            builder:(context)=>defaultButton(
                                context:context,
                                function:(){
                                 c.Login_user(emailcontroller.text,passwordcontroller.text,context);
                                },
                                widget:Text('LOGIN',style: TextStyle(
                                    fontSize: 20,color: Colors.white,fontFamily: 'Brat'),),
                                color: Colors.blue),
                          fallback:(context)=>Center(child: CircularProgressIndicator()),
                        ),

                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Text('don\'t have acount ?'),
                            SizedBox(width:5),
                            defaultTextButton(function: (){navigatorTO(context, Registerpage());},
                                widget: Text('Register',style: TextStyle(fontSize:15,),))

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

            );
          },
          listener: (context,state){
            if(state is Login_success_State){
              bool status= state.model!.status;
              status?print(state.model!.status):print(state.model!.message);


            }
          },
        ),
    );
  }
}
