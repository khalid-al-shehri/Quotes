import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/colors.dart';
import 'package:quotes/helperMethods/UIcontroller.dart';
import 'package:quotes/helperMethods/quotesData.dart';
import 'package:quotes/view/quotesScreen.dart';
import 'package:quotes/view/widgets/bottomBar.dart';

import 'favoriteScreen.dart';

class Home extends StatefulWidget {

  String id = "home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  // screens[0] => QuotesScreen
  // screens[1] => FavoriteScreen
  List<Widget> screens;
  Widget currentScreen;
  int screenController = 0;

  @override
  void initState() {
    setState(() {
      screens = [QuotesScreen(homeScaffoldKey: scaffoldKey), FavoriteScreen()];
    });

    setState(() {
      currentScreen = screens[screenController];
    });

    super.initState();
  }

  moveToQuotes(){
    setState(() {
      screenController = 0;
      currentScreen = screens[screenController];
    });
  }

  moveToFavorite(){
    setState(() {
      screenController = 1;
      currentScreen = screens[screenController];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: customGreen.withOpacity(0.15),
        child: Stack(
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: currentScreen,
                )
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 120,
                  child: FancyTabBar(
                    actionButton1: moveToQuotes,
                    actionButton2: moveToFavorite,
                  ),
                )
              ],
            ),

          ],
        ),
      )
    );
  }
}
