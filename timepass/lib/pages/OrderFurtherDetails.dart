import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:timepass/pages/MyDrawer.dart';
import 'package:timepass/pages/OrderDetails.dart';
import 'package:timepass/services/Service.dart';
import 'Categories.dart';

class OrderFurtherDetails extends StatefulWidget {
  final details;
  const OrderFurtherDetails({Key key, this.details}) : super(key: key);
  @override
  _OrderFurtherDetailsState createState() => _OrderFurtherDetailsState();
}

class _OrderFurtherDetailsState extends State<OrderFurtherDetails> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController subjectContoller = new TextEditingController();
  TextEditingController messageContoller = new TextEditingController();
  TextEditingController categoryContoller = new TextEditingController();
  String dropdownValue = 'Defective Product';
  final _formKey = GlobalKey<FormState>();
  bool isLoading=false;

  showToast(){
    Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      backgroundColor: Colors.green,
      flushbarPosition: FlushbarPosition.TOP,
      message: "Ticked is created successfully!!!",
      duration: Duration(seconds: 4),
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: MyDrawer(),
      body: LoadingOverlay(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.alignLeft),
                          color: Colors.black,
                          onPressed: () => scaffoldKey.currentState.openDrawer(),
                        ),
                        Text(
                          widget.details["Invoice_No"],
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ]),
              Card(
                elevation: 4,
                color: Colors.white,
                margin: EdgeInsets.only(left: 9, right: 9, top: 5, bottom: 5),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Order No.',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black),
                            ),
                            Text(
                              'Order Creation Date',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              widget.details["Invoice_No"],
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          Text(
                            widget.details["created_at"],
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(widget.details["order_status"]["status_name"],
                            style: TextStyle(color: Colors.orange)),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.details["order_details"].length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2.0,
                    margin: EdgeInsets.only(left: 9, right: 9, bottom: 7, top: 5),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Product Name : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.details["order_details"][index]
                                    ["product_variable"]["product"]["name"],
                              )
                            ],
                          ),
                          Divider(
                            height: 25,
                            color: Colors.grey,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Qty : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.details["order_details"][index]
                                    ["quantity"],
                              )
                            ],
                          ),
                          Divider(
                            height: 25,
                            color: Colors.grey,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Variable Size : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.details["order_details"][index]
                                        ["product_variable"]
                                    ["product_variable_options_name"],
                              )
                            ],
                          ),
                          Divider(
                            height: 25,
                            color: Colors.grey,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Price : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Rs.' +
                                    (double.parse(widget.details["order_details"]
                                                [index]["quantity"]) *
                                            widget.details["order_details"][index]
                                                ["variable_selling_price"])
                                        .toString(),
                              )
                            ],
                          ),
                          Divider(
                            height: 25,
                            color: Colors.teal[400],
                            thickness: 2,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Card(
                elevation: 2.0,
                margin: EdgeInsets.only(left: 9, right: 9, bottom: 7, top: 5),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Price Details',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Divider(
                        height: 25,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Subtotal:'),
                          Text(widget.details["sub_total"].toString())
                        ],
                      ),
                      Divider(
                        height: 25,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Tax :'),
                          Text(widget.details["tax"].toString())
                        ],
                      ),
                      Divider(
                        height: 25,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Discount :'),
                          Text(widget.details["discount"].toString())
                        ],
                      ),
                      Divider(
                        height: 25,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Delivery Charges :'),
                          Text(widget.details["delivery_charge"].toString())
                        ],
                      ),
                      Divider(
                        height: 25,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total Amount :',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Rs.' + widget.details["total_amount"].toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Divider(
                        height: 25,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 2.0,
                margin: EdgeInsets.only(left: 9, right: 9, bottom: 7, top: 5),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Address Details',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Divider(
                        height: 25,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Address:'),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(widget.details["address"]
                                      ["address_line_1"] +
                                  ',' +
                                  widget.details["address"]["address_line_2"] +
                                  ',' +
                                  widget.details["address"]["pincode"]
                                      .toString()),
                            ),
                          )
                        ],
                      ),
                      Divider(
                        height: 25,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Mobile No.:'),
                          Text(widget.details["customer"]["mobile_no"].toString())
                        ],
                      ),
                      Divider(
                        height: 25,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Alternate Mobile No.:'),
                          Text(widget.details["alternate_no"].length > 0
                              ? widget.details["alternate_no"].toString()
                              : "none")
                        ],
                      ),
                      Divider(
                        height: 25,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              widget.details["order_status"]["status_name"] == "Pending"
                  ? Text("")
                  : Container(
                      height: 40,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () {

                        },
                        icon: Icon(
                          Icons.file_download,
                          size: 18,
                        ),
                        label: Text(
                          'Download Invoice',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
              widget.details["order_status"]["status_name"] == "Pending"
                  ? Text("")
                  : SizedBox(
                      height: 10,
                    ),
              Container(
                height: 40,
                margin: EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          title: const Text(
                            "Support Ticket",
                          ),
                          content: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return GestureDetector(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                },
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Subject : '),
                                        SizedBox(
                                          height: 9,
                                        ),
                                        Container(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                              ),
                                              fillColor: Colors.white,
//                                              labelText: ' Enter Subject here'
                                            ),
                                            controller: subjectContoller,
                                            validator: (value) {
                                              if(value.length==0){
                                                return 'Enter atleast one character';
                                              }
                                              return null;
                                            },
                                          ),
                                          height: 36,
                                        ),
                                        SizedBox(
                                          height: 18,
                                        ),
                                        Text('Select ticket Category : '),
                                        SizedBox(
                                          height: 9,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 36,
                                          padding: EdgeInsets.all(9),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: DropdownButton(
                                            icon: Icon(Icons.arrow_downward),
                                            isExpanded: true,
                                            iconSize: 24,
                                            elevation: 16,
                                            style: TextStyle(color: Colors.blue),
                                            underline: Container(
                                              height: 0,
                                              color: Colors.black,
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                this.dropdownValue = newValue;
                                                print('value changed is :' +
                                                    dropdownValue);
                                              });
                                            },
                                            items: [
                                              'Defective Product',
                                              'Payment Issue',
                                              'Wrong Product Delivered',
                                              'Deliver Issue',
                                              'Other'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            value: dropdownValue,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 18,
                                        ),
                                        Text('Message : '),
                                        SizedBox(
                                          height: 9,
                                        ),
                                        TextFormField(
                                          maxLines: 8,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                            ),
                                            fillColor: Colors.white,
                                          ),
                                          controller: messageContoller,
                                          validator: (value) {
                                            if(value.length==0){
                                              return 'Enter atleast one character';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 3,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      isLoading=true;
                                    });
                                    Navigator.of(context).pop(false);
                                    String subject=subjectContoller.text.toString();
                                    String message=subjectContoller.text.toString();
                                    print('customer_id is : '+widget.details["customer"]["id"].toString());
                                    print('order_id is : '+widget.details["id"].toString());
                                    Service.createTicket(subject,dropdownValue,
                                    message,widget.details["customer"]["id"],
                                        widget.details["id"]).then((value){
                                      if(value["success"]){
                                        setState(() {
                                          isLoading=false;
                                        });
                                        print(value);
                                        showToast();
                                      }
                                    });
                                  }
                                },
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.blue),
                                )),
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.ticketAlt,
                    size: 18,
                  ),
                  label: Text(
                    'Support',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              )
            ],
          ),
        ),
        isLoading: isLoading,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
      ),
    );
  }
}
