import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/colors.dart';
import 'package:quotes/helperMethods/quotesData.dart';
import 'package:quotes/helperMethods/DBHelper.dart';
import 'package:quotes/model/quoteModel.dart';
import 'package:quotes/view/widgets/quoteContainer.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  final DBHelper dbHelper = DBHelper();

  checkOfFavoriteSQFLite() async {

    // Read Local database to check if there are old Favorite
    List favoriteSaved = await dbHelper.getAllListFavorite();

    // Get all old Favorite
    List<QuoteModel> oldFavorite = List.generate(favoriteSaved.length, (index) {
      QuoteModel quoteModel = QuoteModel();
      quoteModel.id = favoriteSaved[index]['IdFetched'];
      quoteModel.author = favoriteSaved[index]['Author'];
      quoteModel.quote = favoriteSaved[index]['Quote'];

      return quoteModel;
    });

    // Save them in Favorite provider to show them to user
    Provider.of<QuotesData>(context, listen: false).updateFavorite(
        listFavorite: oldFavorite
    );
  }

  @override
  void initState() {
    checkOfFavoriteSQFLite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    int lengthOfListFavorite = Provider.of<QuotesData>(context).favorite == null ? 0 : Provider.of<QuotesData>(context).favorite.length;

    return Container(
      child: Center(
        child: lengthOfListFavorite != 0 ?
        ListView.builder(
          itemCount: lengthOfListFavorite,
          itemBuilder: (context, index){
            return Column(
              children: [

                QuoteContainer(
                  id: Provider.of<QuotesData>(context).favorite[(lengthOfListFavorite - 1) - index].id.toString(),
                  quote: Provider.of<QuotesData>(context).favorite[(lengthOfListFavorite - 1) - index].quote.toString(),
                  author: Provider.of<QuotesData>(context).favorite[(lengthOfListFavorite - 1) - index].author.toString(),
                  ableToDelete: false,
                ),

                ((lengthOfListFavorite - 1) - index) == 0
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
            :
        Text(
          "No Favorite Quote Added",
          textScaleFactor: 1.5,
          style: TextStyle(
            color: customGreen,
            fontWeight: FontWeight.bold,
            fontFamily: "Nunito-Light"
          ),
        ),
      ),
    );
  }
}
