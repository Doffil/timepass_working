import 'package:flutter/material.dart';
import 'package:grocery/pages/profile_page.dart';
import 'package:grocery/pages/shopping_cart.dart';
import 'package:provider/provider.dart';
import 'package:grocery/stores/login_store.dart';
import 'package:grocery/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(
        builder: (_, loginStore, __) {
          return new Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: RaisedButton(
                        onPressed: () {
                          loginStore.signOut(context);
                        },
                        color: MyColors.primaryColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14))
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Sign Out', style: TextStyle(color: Colors
                                  .white),),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  color: MyColors.primaryColorLight,
                                ),
                                child: Icon(Icons.arrow_forward_ios,
                                  color: Colors.white, size: 16,),
                              )
                            ],
                          ),
                        ),
                      )
                  )
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: onTappedBar,
                currentIndex: _currentIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text('Home'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    title: Text('Shopping-Cart'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    title: Text('Profile'),
                  ),
                ],

                selectedItemColor: MyColors.primaryColor,
              )
          );
        });
  }
}