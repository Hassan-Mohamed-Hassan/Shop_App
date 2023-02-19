import 'package:shared_preferences/shared_preferences.dart';
class Cache_helper{
 static late SharedPreferences prefernce;

 static init()async{
  prefernce=await SharedPreferences.getInstance();
 }

static Future<bool>setdata({ required String key,required dynamic value})async{
  if(value is String)
  return await prefernce.setString(key, value);
  else if(value is int)
   return await prefernce.setInt(key, value);
  else if(value is bool)
   return await prefernce.setBool(key, value);
  else return await prefernce.setDouble(key, value);;
 }
static Future<bool> deletedata(key)async{
   return await prefernce.remove(key);
}
 static dynamic getdata({required String key}){
  return  prefernce.get(key);
 }
}
