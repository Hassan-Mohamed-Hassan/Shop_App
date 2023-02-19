import 'package:shop_app/Models/LoginModel.dart';

abstract class LoginStatus{}
class Login_initial_State extends LoginStatus{}
class Change_password_icon_State extends LoginStatus{}

class Login_success_State extends LoginStatus{
  late final LoginModel?model;
  Login_success_State(this.model);
}
class Login_Loding_State extends LoginStatus{}
class Login_error_State extends LoginStatus{}

class Register_success_State extends LoginStatus{
  late final LoginModel?model;
  Register_success_State(this.model);
}
class Register_Loding_State extends LoginStatus{}
class Register_error_State extends LoginStatus{}