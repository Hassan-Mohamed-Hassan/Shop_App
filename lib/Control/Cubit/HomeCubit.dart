import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Control/Consistent/Variables.dart';
import 'package:shop_app/Control/Consistent/Widgets.dart';
import 'package:shop_app/Control/Network/Local/CacheHelper.dart';
import 'package:shop_app/Control/Network/Remote/dio_helaper.dart';
import 'package:shop_app/Control/Statuts/HomeStates.dart';
import 'package:shop_app/Models/CategoriesDetailsModel.dart';
import 'package:shop_app/Models/CategoriesModel.dart';
import 'package:shop_app/Models/FavoritesModel.dart';
import 'package:shop_app/Models/FavoritesProductsModel.dart';
import 'package:shop_app/Models/HomePageModel.dart';
import 'package:shop_app/Models/LoginModel.dart';
import 'package:shop_app/Models/search_Model.dart';
import 'package:shop_app/Modules/CategorieDetails.dart';
import 'package:shop_app/Modules/HomePage.dart';
import 'package:shop_app/Modules/catagories.dart';
import 'package:shop_app/Modules/favorites.dart';
import 'package:shop_app/Modules/layout.dart';
import 'package:shop_app/Modules/settings.dart';
import 'package:shop_app/View/LoginPage.dart';
class Home_cubit extends Cubit<HomeStatus> {
  Home_cubit() :super(Home_initial_State());
  static Home_cubit home_cubit(context) => BlocProvider.of(context);
   List<Widget>Screens=[
      HomePage(),
     CategoriesPage(),
     FavoritesPage(),
     SettingsPage(),
   ];

   int currentindx=0;
  void Change_nav_bar(index){
    currentindx=index;
    Screens[index];
    emit(Change_nav_bar_State());
  }

 Map<int,bool> Favorites={};
   HomeModel ?Home_model;
  void Get_home_data() {
    emit(Home_Loding_State());
    DioHelper.GetData(
     url: 'home',
    //BOf28l1nBuUpzhUGOsaVKlaeL7R0w4lSCm9ayafvacuEGcmpYuJqSRNQjLzTi2JY6NJV4A
    token:token,
    ).then((value){
      Home_model=HomeModel.fromJson(value.data);
      Favorites={};
      Home_model!.data!.products.forEach((element) {
        Favorites.addAll({element.id!: element.inFavorites!});
      });
      emit(Home_success_State());
    }).catchError((error){
      print(error);
      Show_toast(message:'${error.message}', color: Colors.red);
      emit(Home_error_State());
    });
  }

  late CategoriesModel Categories_model;
  void Get_Categories_data() {
    emit(Home_Loding_State());
    DioHelper.GetData(
      url: 'categories',
    ).then((value){
      Categories_model=CategoriesModel.fromJson(value.data);
      emit(Categories_success_State());
    }).catchError((error){
      print(error);
      Show_toast(message:'${error.message}', color: Colors.red);
      emit(Categories_error_State());
    });
  }

  FavoritesProductModel ?favoritesProductModel;
  void Change_Favorites_Products(int? Product_Id){
    Favorites[Product_Id??0]=!Favorites[Product_Id]!;
    emit(Change_Favorites_State());
    DioHelper.postDate(url: 'favorites',data: {'product_id':Product_Id},token: token).then((value) {
      favoritesProductModel = FavoritesProductModel.fromJson(value.data);
      if (!favoritesProductModel!.status!){
        Favorites[Product_Id ?? 0] = !Favorites[Product_Id]!;
        Show_toast(message: '${favoritesProductModel!.message}', color: Colors.red);
        emit(Change_Favorites_success_State());
      }
      Get_Favorites();
      Show_toast(message: '${favoritesProductModel!.message}', color: Colors.blue);
      emit(Change_Favorites_success_State());
    }).catchError((error){
      Favorites[Product_Id??0]=!Favorites[Product_Id]!;
      print(favoritesProductModel!.message);
      Change_Favorites_error_State();
      Show_toast(message: '${favoritesProductModel!.message}', color: Colors.red);
      print(error);
    });
  }

  FavoritesModel ?favoritesModel;
  void Get_Favorites(){
    emit(Favorites_Loding_State());
    DioHelper.GetData(url:'favorites',token: token).then((value){
     favoritesModel=FavoritesModel.fromJson(value.data);
     print(favoritesModel!.data!.data[0].product!.name);

     emit(Favorites_success_State());
    }).catchError(
            (error){
              emit(Favorites_error_State());
              print('$error');
            });
  }

  LoginModel ?usermodel;
  Get_user_model(){
   DioHelper.GetData(url: 'profile', token: token).then((value){
     usermodel=LoginModel.fromJson(value.data);
     emit(User_success_State());
   }).catchError((error){
      print(error);
      emit(User_error_State());
   });
  }
  Logout(context){
    DioHelper.postDate(url: 'logout',
        token: token
    ).then((value){
      Cache_helper.setdata(key: 'token',value: null);
      emit(Logout_success_State());
      navigatorTOAndRemove(context, LoginPage());
    }).catchError((error){
      emit(Logout_error_State());
      print(error);
    });
  }
  late LoginModel Update_model;
  void UpdateProfile({name,email,phone,context}){
    emit(Update_profile_Loding_State());
    DioHelper.putDate(
        url: 'update-profile',
        token: token,
        data: {
          'email':'$email',
          'name':'$name',
          'phone':'$phone',
        }).then((value){
        Update_model=LoginModel.fromJson(value.data);
        if(Update_model.status) {
        Cache_helper.setdata(
            key: 'token',
            value:Update_model.data!.token).then((value){
          token=Update_model.data!.token;
          if(value) {
            Show_toast(
                message:'${Update_model.message}',
                color: Colors.blue);
                 }
            }).then((value){
              Get_user_model();
        });
             emit(Update_profile_success_State());
        }
          else {
        Show_toast(message: '${Update_model.message}',color: Colors.red);}
      emit(Update_profile_success_State());
    }).catchError((error){
      Show_toast(message: '${error.message}',color: Colors.red);
      emit(Update_profile_error_State());
      
      });
     }

     SearchModel? searchModel ;
  void Product_search({
    required String text}){
    emit(Search_Loding_State());
    DioHelper.postDate(
      url: 'products/search',
      lang: 'en',
      token: token,
      data: {'text':'$text'}).then((value){
      searchModel = SearchModel.fromJson(value.data);
        emit(Search_success_State());
      }).catchError((error){
      print(error);
        emit(Search_error_State(searchModel!));
    });
  }


  void Add__Or_Remove_To_Cart(String text){
    emit(Search_Loding_State());
    DioHelper.postDate(
        url: 'carts',
        lang: 'en',
        token: token,
       ).then((value){
      searchModel=SearchModel.fromJson(value.data);
      // print(searchModel!.data!.data[1].name);
      emit(Search_success_State());
    }).catchError((error){
      print(error);
      emit(Search_error_State(searchModel!));
    });
  }


   CategoriesDetailsModel? categories_details_model;
  Future<void> Get_categories_details(int Categorey_id,context)async{
   DioHelper.GetData(
     url: 'categories/$Categorey_id',
     token: token,
   ).then((value)async {
 categories_details_model= await CategoriesDetailsModel.fromJson(value.data);
 navigatorTO(context, CategoriesDetails());
   emit(Categories_details_success_State());
   }).catchError((error){
     Show_toast(message: '${error.message}', color: Colors.red);
     emit(Categories_details_error_State());

   });
  }

     }
