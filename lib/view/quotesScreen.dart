import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/colors.dart';
import 'package:quotes/helperMethods/favoriteHelper.dart';
import 'package:quotes/helperMethods/UIcontroller.dart';
import 'package:quotes/helperMethods/quoteRequest.dart';
import 'package:quotes/helperMethods/quotesData.dart';
import 'package:quotes/helperMethods/DBHelper.dart';
import 'package:quotes/model/quoteModel.dart';
import 'package:quotes/view/widgets/loadIcon.dart';
import 'package:quotes/view/widgets/quoteContainer.dart';

class QuotesScreen extends StatefulWidget {

  final GlobalKey<ScaffoldState> homeScaffoldKey;

  const QuotesScreen({Key key, this.homeScaffoldKey}) : super(key: key);
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {

  final QuoteRequest quoteRequest = QuoteRequest();
  final DBHelper dbHelper = DBHelper();
  final FavoriteHelper favoriteHelper = FavoriteHelper();
  bool loading = false;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  startLoading(){
    setState(() {
      loading = true;
    });
  }

  stopLoading(){
    setState(() {
      loading = false;
    });
  }

  checkOfSQFLite() async {

    // Read Local database to check if there are old quotes
    List quotesSaved = await dbHelper.getAllListQuotes();

    // If there are quotes saved in database, sho them and add 3 new quotes
    if(quotesSaved.length > 0){

      // Get all old quotes
      List<QuoteModel> oldQuotes = List.generate(quotesSaved.length, (index) {
        QuoteModel quoteModel = QuoteModel();
        quoteModel.id = quotesSaved[index]['IdFetched'];
        quoteModel.author = quotesSaved[index]['Author'];
        quoteModel.quote = quotesSaved[index]['Quote'];

        return quoteModel;
      });

      // Save them in Quote provider to show them to user
      Provider.of<QuotesData>(context, listen: false).updateQuote(
          listQuote: oldQuotes
      );

      // Add new quotes to old ones, 3 quotes
      var connectivityResult = await Connectivity().checkConnectivity();
      if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
        showInSnackBar("No Internet, please check your connection");
      }
      else{
        List.generate(3, (index){
          quoteRequest.getNewQuote(context: context, startLoading: startLoading, stopLoading: stopLoading);
        });
      }
    }

    // If there are quotes saved in database, sho them and add 3 new quotes
    else{
      // Add new quotes as initial quotes, 8 quotes
      var connectivityResult = await Connectivity().checkConnectivity();
      if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
        showInSnackBar("No Internet, please check your connection");
      }
      else{
        List.generate(6, (index){
          quoteRequest.getNewQuote(context: context, startLoading: startLoading, stopLoading: stopLoading);
        });
      }
    }
  }

  refresh() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
      showInSnackBar("No Internet, please check your connection");
    }
    else{
      List.generate(3, (index){
        quoteRequest.getNewQuote(context: context, startLoading: startLoading, stopLoading: stopLoading);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkOfSQFLite();
  }

  @override
  Widget build(BuildContext context) {

    int lengthOfListQuote = Provider.of<QuotesData>(context).quote == null ? 0 : Provider.of<QuotesData>(context).quote.length;

    return Container(
      child: Stack(
        children: [
          
          Center(
              child: lengthOfListQuote != 0 ?
              RefreshIndicator(
                onRefresh: () async {
                  // When user pull down to refresh, add new quotes to old ones, 3 quotes
                  refresh();
                },
                child: ListView.builder(
                  itemCount: lengthOfListQuote,
                  itemBuilder: (context, index){
                    return Column(
                      children: [

                        QuoteContainer(
                          id: Provider.of<QuotesData>(context).quote[(lengthOfListQuote - 1) - index].id.toString(),
                          quote: Provider.of<QuotesData>(context).quote[(lengthOfListQuote - 1) - index].quote.toString(),
                          author: Provider.of<QuotesData>(context).quote[(lengthOfListQuote - 1) - index].author.toString(),
                        ),

                        ((lengthOfListQuote - 1) - index) == 0
                            ?
                        Container(
                          height: 90,
                        )
                            :
                        Container()

                      ],
                    );
                  },
                )
              )
                  :
              RefreshIndicator(
                  onRefresh: () async {
                    // When user pull down to refresh, add new quotes to old ones, 3 quotes
                    refresh();
                  },
                  child: ListView(
                    shrinkWrap: true,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No Quotes",
                            textScaleFactor: 1.5,
                            style: TextStyle(
                                color: customGreen,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Nunito-Light"
                            ),
                          ),
                        ],
                      )

                    ],
                  )
              )
          ),

          Padding(
            padding: EdgeInsets.only(top: 35, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: customGreen,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2.0,
                        color: customGreen.withOpacity(0.30),
                        offset: Offset(3.0, 3.0),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    onPressed: (){
                      refresh();
                    },
                  ),
                )
              ],
            ),
          ),

          IgnorePointer(
            ignoring: !loading,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: loading == true ? 1 : 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: customGreen.withOpacity(0.30),
                child: Center(
                  child: LoadingIcon(),
                ),
              ),
            ),
          )
          
        ],
      )
    );
  }
}
