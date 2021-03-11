import 'package:flutter/material.dart';
import 'package:quotes/view/widgets/customIcon.dart';

class LoadingIcon extends StatefulWidget {
  @override
  _LoadingIconState createState() => _LoadingIconState();
}

class _LoadingIconState extends State<LoadingIcon> with SingleTickerProviderStateMixin{

  AnimationController controllerLoading;
  Animation flip_anim_out;
  Animation flip_anim_in;

  void initState() {
    super.initState();
    controllerLoading = AnimationController(duration: Duration(seconds: 3), vsync: this);

    flip_anim_out = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controllerLoading,
        curve: Interval(0.0, 0.5, curve: Curves.linear)
    ));

    flip_anim_in = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: controllerLoading,
        curve: Interval(0.1, 0.6, curve: Curves.linear)
    ));

    controllerLoading.repeat();

  }

  void dispose() {
    controllerLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controllerLoading,
      builder: (BuildContext context, Widget child){
        return Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.25,
            child: Stack(
              children: <Widget>[

                Transform(
                  transform: Matrix4.identity()
                    ..rotateY(2 * 3.14 * flip_anim_out.value),
                  alignment: Alignment.center,
                  child: Center(
                      child: Icon(
                        CustomIcon.iconmonstr_quote_3,
                        size: 85,
                        color: Colors.white,
                      )
                  ),
                ),

              ],
            )
        );
      },
    );
  }
}
