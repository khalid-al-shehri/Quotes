import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quotes/colors.dart';
import 'package:quotes/model/quoteModel.dart';
import 'package:quotes/view/homeScreen.dart';
import 'package:quotes/view/widgets/customIcon.dart';

import 'helperMethods/quoteRequest.dart';
import 'helperMethods/quotesData.dart';
import 'helperMethods/DBHelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ChangeNotifierProvider(
      create: (context) => QuotesData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quotes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Splash().id,
        routes: {
          Splash().id : (context) => Splash(),
          Home().id : (context) => Home(),
        },
      ),
    );
  }
}

class Splash extends StatefulWidget{

  String id = "splash";

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  final DBHelper dbHelper = DBHelper();
  final QuoteRequest quoteRequest = QuoteRequest();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, Home().id);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: customGreen,
        child: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width - 125, top: 90),
                    child: Icon(
                      CustomIcon.iconmonstr_quote_3,
                      size: 160,
                      color: Colors.white.withOpacity(0.08),
                    ),
                  )
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: MediaQuery.of(context).size.height * 0.3),
                    child: Icon(
                      CustomIcon.iconmonstr_quote_3,
                      size: 40,
                      color: Colors.white.withOpacity(0.20),
                    ),
                  )
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15, top: MediaQuery.of(context).size.height * 0.01),
                    child: Icon(
                      CustomIcon.iconmonstr_quote_3,
                      size: 130,
                      color: Colors.white.withOpacity(0.05),
                    ),
                  )
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.60, top: MediaQuery.of(context).size.height * 0.70),
                    child: Icon(
                      CustomIcon.iconmonstr_quote_3,
                      size: 120,
                      color: Colors.white.withOpacity(0.20),
                    ),
                  )
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: MediaQuery.of(context).size.height * 0.67),
                    child: Icon(
                      CustomIcon.iconmonstr_quote_3,
                      size: 120,
                      color: Colors.white.withOpacity(0.07),
                    ),
                  )
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.30, top: MediaQuery.of(context).size.height * 0.52),
                    child: Icon(
                      CustomIcon.iconmonstr_quote_3,
                      size: 80,
                      color: Colors.white.withOpacity(0.12),
                    ),
                  )
                ],
              ),

              Column(
                children: [

                  SizedBox(height: MediaQuery.of(context).size.height * 0.30,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10.0,
                                    color: Colors.black.withOpacity(0.30),
                                    offset: Offset(4.0, 3.0),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(50),
                                child: Icon(
                                  CustomIcon.iconmonstr_quote_3,
                                  size: 80,
                                  color: customGreen,
                                ),
                              )
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Quotes",
                            textScaleFactor: 1.5,
                            style: TextStyle(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 6.0,
                                    color: Colors.black.withOpacity(0.30),
                                  ),
                                ],
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Nunito-Light"
                            ),
                          ),
                        ],
                      ),

                    ],
                  )

                ],
              )

            ],
          ),
        ),
      )
    );
  }
}
