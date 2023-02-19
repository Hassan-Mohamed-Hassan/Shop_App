import 'package:shop_app/Models/search_Model.dart';

abstract class HomeStatus{}
class Home_initial_State extends HomeStatus{}
class Change_nav_bar_State extends HomeStatus{}

class Home_success_State extends HomeStatus{}
class Home_Loding_State extends HomeStatus{}
class Home_error_State extends HomeStatus{}

class Categories_success_State extends HomeStatus{}
class Categories_error_State extends HomeStatus{}

class Change_Favorites_success_State extends HomeStatus{}
class Change_Favorites_State extends HomeStatus{}
class Change_Favorites_error_State extends HomeStatus{}

class Favorites_success_State extends HomeStatus{}
class Favorites_Loding_State extends HomeStatus{}
class Favorites_error_State extends HomeStatus{}

class User_success_State extends HomeStatus{}
class User_error_State extends HomeStatus{}

class Logout_success_State extends HomeStatus{}
class Logout_error_State extends HomeStatus{}

class Update_profile_success_State extends HomeStatus{}
class Update_profile_Loding_State extends HomeStatus{}
class Update_profile_error_State extends HomeStatus{}

class Categories_details_success_State extends HomeStatus{}
class Categories_details_Loding_State extends HomeStatus{}
class Categories_details_error_State extends HomeStatus{}

class Search_success_State extends HomeStatus{}
class Search_Loding_State extends HomeStatus{}
class Search_error_State extends HomeStatus{
  final SearchModel error;

  Search_error_State(this.error);
}
