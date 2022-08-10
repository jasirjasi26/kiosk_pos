// @dart=2.9
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiosk_pos_app/democontroller/allDataController.dart';
import 'package:kiosk_pos_app/democontroller/sunCategoryController.dart';
import 'package:kiosk_pos_app/democlass/selectCategory.dart';
import 'package:kiosk_pos_app/widgets/demoquantitybutton.dart';
import 'package:kiosk_pos_app/widgets/pageheadersection.dart';
import 'cartpage.dart';
import 'democlass/allData.dart';
import 'democontroller/cartController.dart';

class ItemChooseScreen extends StatefulWidget {
  const ItemChooseScreen({Key key}) : super(key: key);

  @override
  _ItemChooseScreenState createState() => _ItemChooseScreenState();
}

class _ItemChooseScreenState extends State<ItemChooseScreen> {
  //final CategoryController categoryController = Get.put(CategoryController());
  final SubCategoryController subCategoryController =
      Get.put(SubCategoryController());
  final AllDataController allDataController = Get.put(AllDataController());
  ReusableObjectClass reusableObjectClass = ReusableObjectClass();
  final cartController = Get.put(CartController());
  var scrollController = ScrollController();
  var _searchcontroller = TextEditingController();

  int value1 = 1;
  int selectedCategoryIndex;
  int selectedSubCategoryIndex;
  static int offset = 0;
  List<AllData> listedItemList = [];
  List<AllData> _searchFoundedItem = [];
  bool isLoading = false;
  String _genderRadioBtnVal;

  void _runFilter(String enteredKeyword) {
    List<AllData> results = [];
    if (enteredKeyword.isEmpty) {
      results = listedItemList;
    } else {
      results = listedItemList
          .where((user) => user.itemName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _searchFoundedItem = results;
    });
  }

  @override
  Future<void> initState() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          setState(() {
            offset = offset + 1;
          });
          selectCategory.offset = offset;
          getList();
        } else {
          print('ListView scroll at top');
          // Load next documents
        }
      }
    });
    //getList();
    clickSubCategory(0, 1);
    super.initState();
  }

  getList() async {
    isLoading = true;
    allDataController.fetchAllData().then((value) {
      setState(() {
        listedItemList.addAll(value);
        isLoading = false;
      });
    });
  }

  clickCategory(int index, int id) {
    listedItemList.clear();
    _searchFoundedItem.clear();
    _searchcontroller.clear();
    offset = 0;
    selectCategory.offset = offset;
    selectCategory.selectedSubCategory = id;
    setState(() {
      selectedCategoryIndex = index;
      selectedSubCategoryIndex = null;
    });
    subCategoryController.fetchSubCategory();
  }

  clickSubCategory(int index, int id) {
    listedItemList.clear();
    _searchFoundedItem.clear();
    _searchcontroller.clear();
    offset = 0;
    selectCategory.offset = offset;
    selectCategory.selectedSubCategory = id;
    setState(() {
      selectedSubCategoryIndex = index;
    });
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            color: Color(0xfff6e3d5),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subCategoryController.subCategoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        clickSubCategory(
                            index,
                            subCategoryController
                                .subCategoryList[index].menuGroupId);
                      },
                      child: Container(
                        width: 200,
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Image.asset("assets/burger.png",
                                    height: 100, width: 100, fit: BoxFit.cover),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 30,
                                width: 100,
                                child: Center(
                                  child: Text(
                                    subCategoryController
                                        .subCategoryList[index].menuGroupName
                                        .toUpperCase()
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: selectedSubCategoryIndex ==
                                            index
                                            ? Colors.black : Colors.grey,
                                        fontWeight:
                                        selectedSubCategoryIndex ==
                                            index
                                            ? FontWeight.bold
                                            : FontWeight
                                            .w300
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 1,
                      color: Colors.white,
                    )
                  ],
                );
              },
            ),
          ),
          Container(
            child: Stack(
              children: [
                SafeArea(
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 300,
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 1.5),
                              itemCount: listedItemList.length,
                              itemBuilder: (BuildContext ctx, index) {
                                String image_url =
                                    listedItemList[index].image.toString();
                                return GestureDetector(
                                  onTap: () {
                                    showCustomDialog(
                                        context, listedItemList[index]);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      gradient: LinearGradient(
                                        begin: Alignment(0.0, -1.0),
                                        end: Alignment(0.0, 1.0),
                                        colors: [
                                          const Color(0xffffffff),
                                          const Color(0xfff6e3d5)
                                        ],
                                        stops: [0.0, 1.0],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0x42000000),
                                          offset: Offset(6, 3),
                                          blurRadius: 12,
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 200,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Center(
                                                child: Container(
                                                  // width: MediaQuery.of(context).size.width * 0.3,
                                                  height: 90,
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
                                                            strokeWidth: 1,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        listedItemList[index]
                                                            .itemName,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'PoppinsLight',
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900)),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                        "Rs " +
                                                            "${listedItemList[index].itemPrice}",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'PoppinsBold',
                                                            fontSize: 15,
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Positioned(
                                        //   right: 3.0,
                                        //   top: 1.0,
                                        //   child: Container(
                                        //     decoration: BoxDecoration(
                                        //       borderRadius: BorderRadius.circular(0.0),
                                        //       gradient: LinearGradient(
                                        //         begin: Alignment(0.0, -1.0),
                                        //         end: Alignment(0.0, 1.0),
                                        //         colors: [const Color(0xffdd642a), const Color(0xffe8982e)],
                                        //         stops: [0.0, 1.0],
                                        //       ),
                                        //       boxShadow: [
                                        //         BoxShadow(
                                        //           color: const Color(0x29000000),
                                        //           offset: Offset(0, 3),
                                        //           blurRadius: 6,
                                        //         ),
                                        //       ],
                                        //     ),
                                        //     child: Center(
                                        //       child: Icon(
                                        //         (!cartController.cartItems.contains(
                                        //             listedItemList[index]))
                                        //             ? null
                                        //             : Icons.check,
                                        //         color: Colors.white,
                                        //       ),
                                        //     ),
                                        //   )
                                        // ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                    ],
                  ),
                ),
              ],
            ),
            //  ],
            //),
          ),
          isLoading
              ? Positioned(
                  bottom: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Container(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: Colors.red[900],
                            strokeWidth: 1.5,
                          )),
                    ),
                  ),
                )
              : SizedBox(),
          Positioned(
            bottom: 10,
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (cartController.cartItems.length >= 1) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CartPage()));
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
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<int> getCounterValue(int counter) async {
    value1 = await counter;
    print('value is $value1');
    return value1;
  }

  void showCustomDialog(BuildContext context, AllData listedItemList) {
    String image_url = listedItemList.image.toString();

    void _handleGenderChange(String value) {
      setState(() {
        _genderRadioBtnVal = value;
      });
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
                              onQuantityChange: getCounterValue,
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
                    height: 30,
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
                          listedItemList.qty = value1;
                          cartController.addToCart(listedItemList);
                          Navigator.pop(context);
                          reusableObjectClass.showToast(
                              context,
                              Icons.shopping_cart,
                              Colors.cyan,
                              "Item added to cart..!");
                        });
                      },
                      color: Colors.transparent,
                      // textColor: Colors.white,
                      child: Text(
                        'Add to Cart',
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
