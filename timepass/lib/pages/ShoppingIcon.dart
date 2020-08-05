import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timepass/pages/shopping-copy.dart';

class ShoppingIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(right: 8,top: 7),
      decoration:
      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      child: Stack(
        children: <Widget>[
          IconButton(
            icon: FaIcon(FontAwesomeIcons.shoppingBag, size: 20),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(milliseconds: 500),
                      child: ShoppingCartCopy()));
            },
          ),
        ],
      ),
    );
  }
}
