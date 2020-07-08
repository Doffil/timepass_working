import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<bool>isSelected = [true, false, false,false];

  final heroTag = "assets/images/vegetables.jpeg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color(0xFF7A9BEE),
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Colors.transparent
          ),
          Positioned(
            child:Hero(
                  tag: heroTag,
                  child: Container(
                    height: 250.0,
                    width: 400.0,
                    child: Carousel(
                      images: [
                        AssetImage(heroTag),
                        AssetImage("assets/images/shopping.jpeg"),
                        AssetImage("assets/images/profileuser.png")
                      ],
                      showIndicator: false,
                    ),
                  )
              )
          ),
          Positioned(
            top: 200.0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.0),
                    topRight: Radius.circular(45.0),
                  ),
                  color: Colors.white),
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Cabbage',
                          style: TextStyle(
                              fontSize: 30.0
                          ),
                        ),
                        Text(
                          'Rs.20/g',
                          style: TextStyle(
                              fontSize: 30.0
                          ),
                        ),

                      ],

                    ),
                  ),
                  SizedBox(height: 10,),
                  _availableSize(),
                  SizedBox(height: 20,),
                  _quantity(),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Total Price : Rs.$sum',
                      style: TextStyle(
                          fontSize: 25.0
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Description : ',
                      style: TextStyle(
                          fontSize: 25.0
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 23.0,left: 20.0),
                        child: ButtonTheme(
                          minWidth:20.0,
                          height: 45,
                          child: OutlineButton(
                            child: Icon(Icons.favorite_border),
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child:ButtonTheme(
                          height: 45,
                          child: RaisedButton.icon(
                            onPressed: (){},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            ),
                            color: Colors.green,
                            textColor: Colors.white,
                            icon: Icon(Icons.shopping_cart),
                            label: Text(
                                'ADD TO CART',
                              style: TextStyle(
                                fontSize: 16
                              ),
                            ),
                          ),
                        ) ,
                      ),
                    ],
                  )

                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.shopping_cart),
      ),
    );
  }

  var sum = 10000;
  int _n=1;
  var value1=500,value2=750,value3=1000,value4=1500;

  Widget _quantity(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              'Qty : ',
            style: TextStyle(
              fontSize: 25
            ),
          ),
        ),
        SizedBox(
          height: 36,
          width: 36,
          child: FloatingActionButton(
            heroTag: "btn1",
            onPressed: add,
            child: Icon(Icons.add),
          ),
        ),
        Text(
          '$_n',
          style: TextStyle(
            fontSize: 25
          ),
        ),
        SizedBox(
          height: 36,
          width: 36,
          child: FloatingActionButton(
            heroTag: "btn2",
            onPressed: minus,
            child: Icon(
              IconData(
                  0xe15b, fontFamily: 'MaterialIcons'
              ),
                ),
          ),
        ),
      ],
    );
  }

  void add(){
    setState(() {
      _n++;
      sum=sum+sum;
    });
  }
  void minus() {
    setState(() {
      if (_n != 1)
        _n--;
    });
  }

  Widget _availableSize() {
    return Center(
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(10.0),
          children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$value1 g',
                style:TextStyle(
                  fontSize: 18.0
                ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    '$value2 g',
                  style: TextStyle(
                    fontSize: 18.0
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    '$value3 g',
                  style: TextStyle(
                    fontSize: 18.0
                  ),
                ),
              ),

             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(
                   '$value4 g',
                  style: TextStyle(
                    fontSize: 18.0
                  ),
               ),
             ),
          ],
          isSelected: isSelected,
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = true;
                  if(index==0){
                    sum=20*value1*_n;
                  }
                  if(index==1){
                    sum=20*value2*_n;
                  }
                  if(index==2){
                    sum=20*value3*_n;
                  }
                  if(index==3){
                    sum=20*value4*_n;
                  }
                } else {
                  isSelected[buttonIndex] = false;
                }
              }
            });
          }
      ),
    );
  }

}