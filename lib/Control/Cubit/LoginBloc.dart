 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Control/Consistent/Variables.dart';
import 'package:shop_app/Control/Consistent/Widgets.dart';
import 'package:shop_app/Control/Network/Local/CacheHelper.dart';
import 'package:shop_app/Control/Network/Remote/dio_helaper.dart';
import 'package:shop_app/Control/Statuts/LoginStates.dart';
 import 'package:bloc/bloc.dart';
import 'package:shop_app/Models/LoginModel.dart';
import 'package:shop_app/Modules/layout.dart';
class Login_cubit extends Cubit<LoginStatus>{
Login_cubit():super(Login_initial_State());
static Login_cubit Get_login_cubit(context)=>BlocProvider.of(context);

void Change_password_icon(){
  print(scure);
  scure?{passwordIcon=Icons.remove_red_eye_outlined,scure=false}:
  {passwordIcon=Icons.visibility_off_outlined,scure=true};
  emit(Change_password_icon_State());
}
late LoginModel Login_model;
void Login_user(email,password,context){
  emit(Login_Loding_State());
  DioHelper.postDate(url: 'login',data: {'email':'$email','password':'$password'}).then((value){
    Login_model=LoginModel.fromJson(value.data);
    if(Login_model.status) {
      Cache_helper.setdata(key: 'token', value: Login_model.data!.token).then((value){
       token=Login_model.data!.token;
        if(value) {
          Show_toast(message: '${Login_model.message}', color: Colors.blue);
           navigatorTOAndRemove(context, LayoutPage());
        }
      });
    }
    else {
      Show_toast(message: '${Login_model.message}',color: Colors.red);}
    emit(Login_success_State(Login_model));
  }).catchError((error){
    Show_toast(message: '${error.message}',color: Colors.red);
    emit(Login_error_State());

  });


}

late LoginModel Register_model;
void Register_user({name,email,phone,password,context}){
  emit(Register_Loding_State());
  DioHelper.postDate(
      url: 'register',
      data: {
        'email':'$email',
        'name':'$name',
        'password':'$password',
        'phone':'$phone',
      }).then((value){
    Register_model=LoginModel.fromJson(value.data);
    if(Register_model.status) {
      Cache_helper.setdata(key: 'token', value: Register_model.data!.token).then((value){
        token=Register_model.data!.token;
        if(value) {
          Show_toast(message: '${Register_model.message}', color: Colors.blue);
          navigatorTOAndRemove(context, LayoutPage());
        }
      });
    }
    else {
      Show_toast(message: '${Register_model.message}',color: Colors.red);}
    emit(Register_success_State(Register_model));
  }).catchError((error){
    Show_toast(message: '${error.message}',color: Colors.red);
    emit(Register_error_State());

  });


}
}