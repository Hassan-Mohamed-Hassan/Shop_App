

import 'package:shop_app/Control/Consistent/Widgets.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Control/Network/Local/CacheHelper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'LoginPage.dart';


class BordingModel{
late final String image;
late final String HeadText;
late final String bodyText;
BordingModel(this.image, this.HeadText, this.bodyText);
}
class  OnBordingPage extends StatefulWidget {
  @override
  State<OnBordingPage> createState() => _OnBordingPageState();
}

class _OnBordingPageState extends State<OnBordingPage> {
  PageController _pageController=PageController();

 List<BordingModel>bording=[
   BordingModel('Assets/images/shop0.png', 'On Bording1', 'Body 1'),
   BordingModel('Assets/images/shop1.png', 'On Bording2', 'Body 2'),
   BordingModel('Assets/images/shop4.png', 'On Bording3', 'Body 3'),
 ];

  bool _islast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: (){
                Cache_helper.setdata(key: 'onbording', value: true).then((value){
                  if(value)
                  navigatorTOAndRemove(context,LoginPage());
                 });
                },
              child: Text('Skip'))
        ],),

      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: _pageController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder:(context,index)=>ItemOnBording(bording[index]),
                  itemCount: 3,
              onPageChanged: (index){

                if(index==2)
                  setState(() {
                    _islast=true;
                  });
                else
                 setState(() {
                   _islast=false;
                 });
                print(index);
                print(_islast);
              },
              ),
            ),

            SizedBox(height: 30,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  effect: WormEffect(
                      dotHeight: 16,
                      dotWidth: 30,
                      activeDotColor: Colors.blue,
                      type: WormType.thin,
                      // stroke
                ),
                  count: bording.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    print(_islast);
                    if(_islast)
                      navigatorTOAndRemove(context, LoginPage());
                    else
                      _pageController.nextPage(duration: Duration(milliseconds: 700), curve: Curves.fastLinearToSlowEaseIn);
                    },
                  child: Icon(Icons.arrow_forward_ios),),
              ],
            )
          ],
        ),
      ),

    );
  }

  Widget ItemOnBording(BordingModel model){
    return Column(
      children: [
        Expanded(child: Image.asset("${model.image}",),),
        SizedBox(height: 30,),
        Text('${model.HeadText}',style: TextStyle(fontSize: 24,fontFamily: 'BrandinkSans'),),
        SizedBox(height: 30,),
        Text('${model.bodyText}',style:TextStyle(fontSize: 16,fontFamily: 'BrandinkSans'),),
      ],
    );
  }
}
