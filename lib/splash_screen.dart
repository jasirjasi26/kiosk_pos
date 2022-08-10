// @dart=2.9
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:kiosk_pos_app/services/loginservice.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kiosk_pos_app/democontroller/allDataController.dart';
import 'package:kiosk_pos_app/democontroller/sunCategoryController.dart';
import 'package:kiosk_pos_app/democlass/selectCategory.dart';
import 'package:kiosk_pos_app/widgets/demoquantitybutton.dart';
import 'package:kiosk_pos_app/widgets/pageheadersection.dart';
import 'cartpage.dart';
import 'democlass/allData.dart';
import 'democontroller/cartController.dart';
import 'democontroller/sunCategoryController.dart';
class LogoScreen extends StatefulWidget {
  const LogoScreen({Key key}) : super(key: key);

  @override
  LogoScreenState createState() => LogoScreenState();
}

class LogoScreenState extends State<LogoScreen> {
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


  void checkLoginAndVanigate(BuildContext context) async {
    try {
      LoginService service = LoginService();
      Token token = await service.login();
      if (token != null && token.isValid()) {
        Navigator.of(context).pushReplacementNamed("/home");
      }
    } catch (e) {
      Navigator.of(context).pushReplacementNamed("/home");
     // Navigator.of(context).pushReplacementNamed("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Timer(
    //     Duration(seconds: 0),
    //         () => checkLoginAndVanigate(context));
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height ,
      decoration: BoxDecoration(
        color: Colors.white,
        // image: DecorationImage(
        //   image: AssetImage("assets/back.png"), // <-- BACKGROUND IMAGE
        //   fit: BoxFit.cover,
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
             child: Image.asset("assets/orderhere.png", height: 200, width: 300, fit: BoxFit.contain),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
              subCategoryController.subCategoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // clickSubCategory(
                    //     index,
                    //     subCategoryController
                    //         .subCategoryList[index].menuGroupId);
                  },
                  child: Container(
                    width: 280,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, 1.0),
                        colors: [const Color(0xffffffff), const Color(0xfff6e3d5)],
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
                    child: Column(
                      children: [
                        Center(
                          child: Image.asset("assets/burger.png", height: 150, width: 150, fit: BoxFit.contain),
                        ),
                        Center(
                          child: Container(
                            height: 50,
                            width: 100,
                            child: Center(
                              child: Text(
                                subCategoryController
                                    .subCategoryList[index]
                                    .menuGroupName.toUpperCase()
                                    .toString(),
                                overflow:
                                TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  //fontWeight:
                                  // selectedSubCategoryIndex ==
                                  //     index
                                  //     ? FontWeight.w900
                                  //     : FontWeight
                                  //     .w400
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ) ,
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: (){
              //Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, "/chooseitems");
            },
            child: Container(
              width: 300,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                gradient: LinearGradient(
                  begin: Alignment(-1.0, 0.0),
                  end: Alignment(1.0, 0.0),
                  colors: [const Color(0xffdd642a), const Color(0xffe8982e)],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Center(
                child: Text(
                  'ORDER HERE',
                  style: TextStyle(
                    fontFamily: 'Elephant',
                    fontSize: 28,
                    color:  Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}