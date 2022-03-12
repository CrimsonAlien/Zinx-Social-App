
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:zinx/app/app.router.dart';
import 'package:zinx/enums/connectivity_status.dart';
import 'package:zinx/services/connectivity_service.dart';
import 'package:zinx/ui/shared/app_colors.dart';
import 'locator.dart';



void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      initialData: ConnectivityStatus.offline,
      create: (context) => ConnectivityService().connectionStatusController.stream,
      child: ScreenUtilInit(

        builder: () =>  MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
   textTheme: TextTheme(subtitle1: TextStyle(color: AppColor.tintedWhite)),
            primarySwatch: Colors.blue,
          ),
navigatorKey: StackedService.navigatorKey,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorObservers: [StackedService.routeObserver],
        ),
 designSize: const Size(360, 640),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
   final size = MediaQuery.of(context).size;

    return ResponsiveBuilder(
       builder: (context, sizingInformation) {

     if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
       return Container(color:Colors.blue);
     }

     if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
       return Container(color:Colors.red);
     }

     if (sizingInformation.deviceScreenType == DeviceScreenType.watch) {
       return Container(color:Colors.yellow);
     }

     return SafeArea(
       child: Scaffold(



           body: Container(
padding: EdgeInsets.only(left: 20,right: 20,top: 70,bottom: 100),
             color: const Color(0xff09090B),

             width: size.width,

             height: size.height,

             child: Column(

               crossAxisAlignment: CrossAxisAlignment.center,

               mainAxisAlignment: MainAxisAlignment.end,

               children: <Widget>[
                 Container(

                   width: 70,
                   height: 70,
                   child: Center(
                     child:   Image.asset(
                       'assets/images/zinx.png',



                     ),
                   ),

                 ),


                 Padding(

                   padding: const EdgeInsets.all(40.0),

                   child:   Text("We bring you closer to the things you love",style: TextStyle(fontFamily: 'Poppins',fontSize: 37.0,fontWeight:FontWeight.bold ,height: 1.1,color: AppColor.textWhite) ,),

                 ),

                 SizedBox(height: 50,),



                 Padding(

                   padding: const EdgeInsets.only(left: 30,right: 30),

                   child: Row(

                     mainAxisAlignment: MainAxisAlignment.center,

                     children: <Widget>[

                       Text('Already have an account?',style: TextStyle(color: AppColor.textWhite),),

                       SizedBox(width: 5.0),

                       InkWell(

                         onTap: (){},

                         child: Text("Login",style: TextStyle(color: AppColor.textWhite),),



                       ),
                     ],


                   ),

                 ),

                 SizedBox(height: 30.0,),



                 Padding(

                   padding: const EdgeInsets.only(left: 40,right: 40),

                   child:   InkWell(
                     onTap: (){},

                     child: Container(

                       height: 55,

                       decoration: BoxDecoration(

                         border: Border.all(

                           color: AppColor.tintedWhite,

                           style: BorderStyle.solid,

                           width: 1.0,

                         ),

                         borderRadius: BorderRadius.circular(50),
                         color: Colors.transparent,

                       ),


                       child: Row(

                         mainAxisAlignment: MainAxisAlignment.center,

                         children: <Widget>[


                           Text("Sign up with Number",style: TextStyle(color: AppColor.textWhite),)



                         ],




                       ),



                     ),







                   ),

                 ),

                 SizedBox(height: 23,),

                 Padding(

                   padding: const EdgeInsets.only(left: 40,right: 40,bottom: 40),

                   child:   InkWell(



                     onTap: (){},







                     child: Container(



                       height: 55,



                       decoration: BoxDecoration(



                         borderRadius: BorderRadius.circular(50),



                         color:AppColor.purpleBrush,











                       ),



                       child: Row(



                         mainAxisAlignment: MainAxisAlignment.center,



                         children: <Widget>[



                           Text("Sign up with Number",style: TextStyle(color: AppColor.textWhite),)















                         ],











                       ),



                     ),







                   ),

                 ),





               ],





             ),



           ),



         ),


     );
   },


  );
}
}
