import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Control/Consistent/Variables.dart';
import 'package:shop_app/Control/Cubit/HomeCubit.dart';
import 'package:shop_app/Control/Network/Local/CacheHelper.dart';
import 'package:shop_app/Control/Network/Remote/dio_helaper.dart';
import 'package:shop_app/Modules/HomePage.dart';
import 'package:shop_app/Modules/credit.dart';
import 'package:shop_app/Modules/layout.dart';
import 'package:shop_app/View/LoginPage.dart';
import 'package:shop_app/View/OnBordingPage.dart';
import 'package:shop_app/View/RegisterPage.dart';
import 'package:shop_app/credit_card.dart';


import 'Control/Styles/Themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initDio();
  await Cache_helper.init();
  Widget startWidget;
 var onbording=Cache_helper.getdata(key: 'onbording');
 token=Cache_helper.getdata(key: 'token');
 print(token);
   if(onbording!=null){
     if(token!=null){
       startWidget=LayoutPage();
     }
     else
    startWidget=LoginPage();
   }
   else
   startWidget=OnBordingPage();
  runApp( MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  late Widget startWidget;
  MyApp(this.startWidget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>Home_cubit()..Get_home_data()..Get_Categories_data()..Get_Favorites()..Get_user_model()

        ),
      ],
      child: MaterialApp(
        title: 'Shop App',
        debugShowCheckedModeBanner: false,
        theme: LightMode,

        themeMode: ThemeMode.light,
        home:startWidget,
      ),
    );
  }
}
