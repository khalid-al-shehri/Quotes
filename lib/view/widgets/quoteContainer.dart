import 'package:flutter/material.dart';
import 'package:quotes/helperMethods/FavoriteHelper.dart';
import 'package:quotes/helperMethods/DBHelper.dart';
import 'package:quotes/view/widgets/customIcon.dart';

import '../../colors.dart';

class QuoteContainer extends StatefulWidget {

  final String id;
  final String author;
  final String quote;

  const QuoteContainer({
    Key key,
    this.id,
    this.author,
    this.quote}) : super(key: key);

  @override
  _QuoteContainerState createState() => _QuoteContainerState();
}

class _QuoteContainerState extends State<QuoteContainer> {

  final FavoriteHelper favoriteHelper = FavoriteHelper();
  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              color: customGreen.withOpacity(0.40),
              offset: Offset(2.0, 3.0),
            ),
          ],
        ),
        child: Stack(
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width - 125, top: 5),
                  child: Icon(
                    CustomIcon.iconmonstr_quote_3,
                    size: 70,
                    color: customGreen.withOpacity(0.04),
                  ),
                )
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 100),
                  child: Icon(
                    CustomIcon.iconmonstr_quote_3,
                    size: 40,
                    color: customGreen.withOpacity(0.11),
                  ),
                )
              ],
            ),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.id,
                      textScaleFactor: 0.8,
                      style: TextStyle(
                          color: Colors.grey.withOpacity(0.65)
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10,),

                Text(
                  widget.quote,
                  textScaleFactor: 1.1,
                  style: TextStyle(
                    fontFamily: "Nunito-Light",
                    height: 1.5
                  ),
                ),

                SizedBox(height: 20,),

                Text(
                  "- "+widget.author,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.75),
                    fontFamily: "IndieFlower-Regular"
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    FutureBuilder(
                      future: favoriteHelper.addedToFavorite(id: widget.id),
                      builder: (context, addedToFavorite){
                        return IconButton(
                          icon: Icon(
                            addedToFavorite.data == false ? Icons.favorite_border : Icons.favorite,
                            color: addedToFavorite.data == false ? customGreen : customGreen,
                          ),
                          onPressed: () async {
                            if(addedToFavorite.data == false){
                              await dbHelper.insertFavorite(
                                  idFetched: widget.id,
                                  author: widget.author,
                                  quote: widget.quote
                              );
                            }
                            else{
                              await dbHelper.deleteFavorite(
                                  idFetched: widget.id
                              );
                            }
                            setState(() {});
                          },
                        );
                      },
                    )

                  ],
                )
              ],
            )

          ],
        )
    );
  }
}
