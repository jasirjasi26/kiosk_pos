// @dart=2.9
import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiosk_pos_app/payment_options.dart';
import 'democlass/allData.dart';
import 'democontroller/cartController.dart';
import 'widgets/demoquantitybutton.dart';
import 'widgets/pageheadersection.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartController = Get.put(CartController());
  ReusableObjectClass reusableObjectClass = ReusableObjectClass();
  String _genderRadioBtnVal;
  int value1 = 1;
  List<AllData> listedItemList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff402521),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Column(children: [
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Review Your Order',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    height: MediaQuery.of(context).size.height * .5,
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Expanded(
                      //padding: EdgeInsets.only(top: 90.0,),
                      child: GetX<CartController>(builder: (controller) {
                        return Scrollbar(
                          child: Padding(
                            padding: EdgeInsets.only(right: 0.0),
                            child: ListView.builder(
                                itemCount: controller.cartItems.length,
                                itemBuilder: (context, index) {
                                  String image_url = controller
                                      .cartItems[index].image
                                      .toString();
                                  return Container(
                                    color: Colors.white,
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.25,
                                              height: 150,
                                              child: image_url != ""
                                                  ? ClipRRect(
                                                  child: Image.memory(
                                                      base64Decode(
                                                          image_url)))
                                                  : Container(
                                                height: 30,
                                                width: 30,
                                                child:
                                                CircularProgressIndicator(
                                                  strokeWidth: 1.5,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4.0,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 5, bottom: 5),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.3,
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      controller
                                                          .cartItems[index]
                                                          .itemName.toUpperCase(),
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'PoppinsLight',
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.w900)),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  // Text(
                                                  //     "Rs." +
                                                  //         "${controller.cartItems[index].itemPrice}",
                                                  //     style: TextStyle(
                                                  //         fontFamily:
                                                  //         'PoppinsBold',
                                                  //         fontSize: MediaQuery.of(
                                                  //             context)
                                                  //             .size
                                                  //             .width >
                                                  //             700
                                                  //             ? 19
                                                  //             : 16,
                                                  //         color: Colors.blue,
                                                  //         fontWeight:
                                                  //         FontWeight.w500)),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Container(
                                                    height: 50.0,
                                                    width: 100.0,
                                                    //padding: EdgeInsets.symmetric(horizontal:1,vertical: 0),
                                                    decoration:
                                                    BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          0.0),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 30.0,
                                                          height: 50,
                                                          child: Center(
                                                            child: IconButton(
                                                              onPressed: (controller
                                                                  .cartItems[index]
                                                                  .qty <=
                                                                  1)
                                                                  ? null
                                                                  : () {
                                                                setState(
                                                                        () {
                                                                      controller
                                                                          .cartItems[index]
                                                                          .qty--;
                                                                    });
                                                              },
                                                              icon: Icon(
                                                                Icons.remove_circle,
                                                                color: Colors
                                                                    .black,
                                                                size: 25,
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Container(
                                                          width: 35,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  0),
                                                              color: Colors
                                                                  .white),
                                                          child: Center(
                                                            child: Text(
                                                              controller
                                                                  .cartItems[
                                                              index]
                                                                  .qty
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                  16),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 30.0,
                                                          height: 50,
                                                          child: Center(
                                                            child: IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  controller
                                                                      .cartItems[
                                                                  index]
                                                                      .qty++;
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons.add_circle,
                                                                color: Colors
                                                                    .black,
                                                                size: 25,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),


                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              .15,
                                          height:25,
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    showCustomDialog(
                                                        context, cartController.cartItems[index],index,controller);

                                                  },
                                                  child: Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                      fontFamily: 'Arial',
                                                      fontSize: 20,
                                                      color: const Color(0xff402521),
                                                      decoration: TextDecoration.underline,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Spacer(),

                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      cartController
                                                          .removeFromCart(
                                                          controller
                                                              .cartItems[
                                                          index]);
                                                      reusableObjectClass.showToast(
                                                          context,
                                                          Icons
                                                              .dangerous_rounded,
                                                          Color(int.parse(
                                                              'FFa70a00',
                                                              radix: 16)),
                                                          "Item removed from cart..!");
                                                      // _showToast(context);
                                                    });
                                                  },
                                                  child: Text(
                                                    'Remove',
                                                    style: TextStyle(
                                                      fontFamily: 'Arial',
                                                      fontSize: 20,
                                                      color: const Color(0xff402521),
                                                      decoration: TextDecoration.underline,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        );
                      }),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width * .938,
                    padding: EdgeInsets.only(
                        top: 6.0, bottom: 6.0, left: 15.0, right: 6.0),
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sub Total   ",
                                style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize:
                                        MediaQuery.of(context).size.width > 700
                                            ? 18
                                            : 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width > 700
                                    ? 220
                                    : 150,
                                child: Center(
                                    child: Text(
                                  "Rs 5.00",
                                  style: TextStyle(
                                      fontFamily: 'PoppinsBold',
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  700
                                              ? 22
                                              : 19,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w700),
                                )),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tax     ",
                                style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize:
                                        MediaQuery.of(context).size.width > 700
                                            ? 18
                                            : 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width > 700
                                    ? 220
                                    : 150,
                                child: Center(
                                    child: Text(
                                  "Rs 5.00",
                                  style: TextStyle(
                                      fontFamily: 'PoppinsBold',
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  700
                                              ? 22
                                              : 19,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w700),
                                )),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Grand Total    ",
                                style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize:
                                        MediaQuery.of(context).size.width > 700
                                            ? 18
                                            : 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.width > 700
                                    ? 55
                                    : 50,
                                width: MediaQuery.of(context).size.width > 700
                                    ? 220
                                    : 150,
                                child: Center(
                                  child: GetX<CartController>(
                                      builder: (controller) {
                                    return Text(
                                      "\Rs ${controller.totalPrice}" + " /-",
                                      style: TextStyle(
                                          fontFamily: 'PoppinsBold',
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  700
                                              ? 22
                                              : 19,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w700),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 300,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            gradient: LinearGradient(
                              begin: Alignment(-1.0, 0.0),
                              end: Alignment(1.0, 0.0),
                              colors: [
                                const Color(0xffdd642a),
                                const Color(0xffe8982e)
                              ],
                              stops: [0.0, 1.0],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'MENU',
                              style: TextStyle(
                                fontFamily: 'Elephant',
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (cartController.cartItems.length >= 1) {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => PaymentOptionsPage()));
                          } else {
                            reusableObjectClass.showToast(
                                context,
                                Icons.shopping_cart,
                                Colors.cyan,
                                "No items in cart..!");
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                gradient: LinearGradient(
                                  begin: Alignment(-1.0, 0.0),
                                  end: Alignment(1.0, 0.0),
                                  colors: [
                                    const Color(0xffdd642a),
                                    const Color(0xffe8982e)
                                  ],
                                  stops: [0.0, 1.0],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'CHECKOUT',
                                  style: TextStyle(
                                    fontFamily: 'Elephant',
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Positioned(
                                top: 1,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: CircleAvatar(
                                    radius: 11,
                                    backgroundColor: Colors.cyan,
                                    foregroundColor: Colors.white,
                                    child: GetX<CartController>(builder: (controller) {
                                      return Container(
                                        height: 70,
                                        width: 70,
                                        child: Center(
                                          child: Text(
                                            controller.count.toString(),
                                            style: TextStyle(
                                                fontFamily: 'PoppinsLight',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      // SizedBox(
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width * .7,
                      //     height: 50.0,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(4.0),
                      //       gradient: LinearGradient(
                      //         begin: Alignment(-0.97, 0.0),
                      //         end: Alignment(0.97, 0.11),
                      //         colors: [
                      //           const Color(0xff005fb8),
                      //           const Color(0xff60cdff)
                      //         ],
                      //         stops: [0.0, 1.0],
                      //       ),
                      //     ),
                      //     child: GestureDetector(
                      //       //icon: Icon(Icons.save,color: Colors.white,),
                      //
                      //       child: Center(
                      //         child:
                      //             GetX<CartController>(builder: (controller) {
                      //           return Text(
                      //             "Pay  \Rs ${controller.totalPrice}" + " /-",
                      //             style: TextStyle(
                      //                 fontFamily: 'PoppinsBold',
                      //                 fontSize:
                      //                     MediaQuery.of(context).size.width >
                      //                             700
                      //                         ? 22
                      //                         : 19,
                      //                 color: Colors.white,
                      //                 fontWeight: FontWeight.w800),
                      //           );
                      //         }),
                      //       ),
                      //       // shape: RoundedRectangleBorder(
                      //       //   borderRadius: BorderRadius.circular(22.0),
                      //       // ),
                      //       onTap: () {
                      //         //Navigator.pushNamed(context, "/home");
                      //         Navigator.of(context).push(MaterialPageRoute(
                      //             builder: (context) => PaymentOptionsPage()));
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<int> getCounterValue(int counter) async {
    int value1 = counter;
    print('value is $value1');
    return value1;
  }

  void showCustomDialog(BuildContext context, AllData listedItemList, int index, CartController controller) {
    String image_url = listedItemList.image.toString();
    int val=0;
    void _handleGenderChange(String value) {
      setState(() {
        _genderRadioBtnVal = value;
      });
    }

    Future<int> getCounterValue2(int counter) async {
      int val = counter;
      print('value is $val');
      return val;
    }

    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(builder: (context, setState) {
          return Center(
            child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(children: [
                  Center(
                    child: Container(
                      // width: MediaQuery.of(context).size.width * 0.3,
                      height: 120,
                      child: image_url != ""
                          ? ClipRRect(
                          child: Image.memory(base64Decode(image_url)))
                          : Container(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(listedItemList.itemName,
                            style: TextStyle(
                                fontFamily: 'PoppinsLight',
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w900)),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Rs " + "${listedItemList.itemPrice}",
                            style: TextStyle(
                                fontFamily: 'PoppinsBold',
                                fontSize: 15,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QuantityButton(
                              initialQuantity: 1,
                              onQuantityChange: getCounterValue2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Material(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("    Add Ons (0 to 3)",
                            style: TextStyle(
                                fontFamily: 'PoppinsBold',
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w800)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Row(
                            children: <Widget>[
                              Radio<String>(
                                value: "Cheese",
                                activeColor: Colors.cyan,
                                groupValue: _genderRadioBtnVal,
                                onChanged: (val) {
                                  setState(() {
                                    _genderRadioBtnVal = val;
                                  });
                                },
                              ),
                              Text("Cheese"),
                              Radio<String>(
                                value: "Bacon",
                                activeColor: Colors.cyan,
                                groupValue: _genderRadioBtnVal,
                                onChanged: (val) {
                                  setState(() {
                                    _genderRadioBtnVal = val;
                                  });
                                },
                              ),
                              Text("Bacon"),
                              Radio<String>(
                                value: "Onion Rings",
                                activeColor: Colors.cyan,
                                groupValue: _genderRadioBtnVal,
                                onChanged: (val) {
                                  setState(() {
                                    _genderRadioBtnVal = val;
                                  });
                                },
                              ),
                              Text("Onion Rings"),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Row(
                            children: <Widget>[
                              Radio<String>(
                                value: "Tomato's",
                                activeColor: Colors.cyan,
                                groupValue: _genderRadioBtnVal,
                                onChanged: (val) {
                                  setState(() {
                                    _genderRadioBtnVal = val;
                                  });
                                },
                              ),
                              Text("Tomato's"),
                              Radio<String>(
                                value: "Cabbage",
                                activeColor: Colors.cyan,
                                groupValue: _genderRadioBtnVal,
                                onChanged: (val) {
                                  setState(() {
                                    _genderRadioBtnVal = val;
                                  });
                                },
                              ),
                              Text("Cabbage"),
                              Radio<String>(
                                value: "Capsicum",
                                activeColor: Colors.cyan,
                                groupValue: _genderRadioBtnVal,
                                onChanged: (val) {
                                  setState(() {
                                    _genderRadioBtnVal = val;
                                  });
                                },
                              ),
                              Text("Capsicum"),
                            ],
                          ),
                        ),
                        Text("    Souce Side (0 to 3)",
                            style: TextStyle(
                                fontFamily: 'PoppinsBold',
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w800)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Row(
                            children: <Widget>[
                              Radio<String>(
                                value: "Cheese",
                                activeColor: Colors.cyan,
                                groupValue: _genderRadioBtnVal,
                                onChanged: (val) {
                                  setState(() {
                                    _genderRadioBtnVal = val;
                                  });
                                },
                              ),
                              Text("Cheese"),
                              Radio<String>(
                                value: "Bacon",
                                activeColor: Colors.cyan,
                                groupValue: _genderRadioBtnVal,
                                onChanged: (val) {
                                  setState(() {
                                    _genderRadioBtnVal = val;
                                  });
                                },
                              ),
                              Text("Bacon"),
                              Radio<String>(
                                value: "Onion Rings",
                                activeColor: Colors.cyan,
                                groupValue: _genderRadioBtnVal,
                                onChanged: (val) {
                                  setState(() {
                                    _genderRadioBtnVal = val;
                                  });
                                },
                              ),
                              Text("Onion Rings"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 40,
                    width: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      gradient: LinearGradient(
                        begin: Alignment(-0.97, 0.0),
                        end: Alignment(0.97, 0.11),
                        colors: [
                          const Color(0xff005fb8),
                          const Color(0xff60cdff)
                        ],
                        stops: [0.0, 1.0],
                      ),
                    ),
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          cartController
                              .removeFromCart(
                              controller
                                  .cartItems[
                              index]);
                           listedItemList.qty = val;
                          cartController.addToCart(listedItemList);
                          controller
                              .cartItems[index]
                              .qty=val;

                          Navigator.pop(context);
                        });
                      },
                      color: Colors.transparent,
                      // textColor: Colors.white,
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ])),
          );
        });
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
