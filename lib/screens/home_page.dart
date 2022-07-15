import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_icons/line_icons.dart';
import 'package:neksio_cenovnik/generated/l10n.dart';
import 'package:neksio_cenovnik/helpers/bottom_navy_bar.dart';
import 'package:neksio_cenovnik/helpers/constant_data.dart';
import 'package:neksio_cenovnik/helpers/constant_widget.dart';
import 'package:neksio_cenovnik/models/models.dart';
import 'package:neksio_cenovnik/screens/detail_page.dart';
import 'package:neksio_cenovnik/screens/search_page.dart';
import 'package:neksio_cenovnik/screens/favorite_page.dart';
import 'package:neksio_cenovnik/screens/products_page.dart';
import 'package:neksio_cenovnik/util/pref_data.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomePage extends StatefulWidget {
  final int tabPosition;

  HomePage(this.tabPosition);

  @override
  _HomePage createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  int _currentIndex = 0;
  TextEditingController? textEditingController;
  final nameStorage = GetStorage();
  late String userName;
  String query = '';
  String _version = "";
  String _buildNumber = "";
  final databaseReference = FirebaseDatabase.instance.reference();
  String query1 = '';
  late List<CenovnikModel> filteredList = [];
  var _searchview = TextEditingController();
  @override
  void initState() {
    super.initState();
    getThemeMode();
    getAppVersion();
    ConstantData.setThemePosition();
    _currentIndex = widget.tabPosition;
    userName = nameStorage.read('name');
    setState(() {});

    _searchview.addListener(() {
      if (_searchview.text.isNotEmpty) {
        //Notify the framework that the internal state of this object has changed.
        setState(() {
          query1 = _searchview.text;
        });
      }
    });
  }

  int? themMode;

  getThemeMode() async {
    themMode = await PrefData.getThemeMode();
    ConstantData.setThemePosition();
    setState(() {});
  }

  void getAppVersion() async {
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _version = _packageInfo.version;
        _buildNumber = _packageInfo.buildNumber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ConstantData.setThemePosition();
    double bottomBarRadius = ConstantWidget.getScreenPercentSize(context, 5);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: bgColor,
          body: Stack(
            children: [
              getTabWidget(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                    ),
                    child: BottomNavyBar(
                      selectedIndex: _currentIndex,
                      showElevation: false,
                      itemCornerRadius: bottomBarRadius,
                      curve: Curves.easeIn,
                      backgroundColor: Colors.transparent,
                      onItemSelected: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      items: <BottomNavyBarItem>[
                        getBottomTextWidget(
                            S.of(context).home, LineIcons.icons),
                        getBottomTextWidget(
                            S.of(context).search, LineIcons.search),
                        getBottomTextWidget(
                            S.of(context).favorite, LineIcons.heartAlt),
                        getBottomTextWidget(
                            S.of(context).about, LineIcons.userTie),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        onWillPop: _requestPop);
  }

  getTabWidget() {
    if (_currentIndex == 0) {
      return mainWidget();
    } else if (_currentIndex == 1) {
      return searchWidget();
    } else if (_currentIndex == 2) {
      return favoriteWidget();
    } else {
      return aboutWidget();
    }
  }

  Widget mainWidget() {
    changeStatusColor(primaryColor);

    double height = ConstantWidget.getScreenPercentSize(context, 23);
    double searchHeight = ConstantWidget.getPercentSize(height, 29);
    double margin = ConstantWidget.getScreenPercentSize(context, 1.7);
    double cellHeight = ConstantWidget.getScreenPercentSize(context, 16);
    int _crossAxisSpacing = 1;
    double _screenWidth = MediaQuery.of(context).size.width;
    int _crossAxisCount = 2;
    double _width =
        (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
            _crossAxisCount;
    double _aspectRatio = _width / cellHeight;
    return SafeArea(
      child: Container(
        color: bgColor,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ConstantWidget.getScreenPercentSize(context, 2)),
              height: height,
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ConstantWidget.getTextWidget(
                          S.of(context).zdravo,
                          Colors.white,
                          TextAlign.start,
                          FontWeight.w600,
                          ConstantWidget.getPercentSize(
                              height - searchHeight, 15)),
                      const SizedBox(
                        width: 0.5,
                      ),
                      ConstantWidget.getTextWidget(
                          userName,
                          hightLightColor,
                          TextAlign.start,
                          FontWeight.w600,
                          ConstantWidget.getPercentSize(
                              height - searchHeight, 15)),
                      const Spacer(),
                      InkWell(
                        child: const Icon(
                          Icons.brightness_6_outlined,
                          color: Colors.white,
                        ),
                        onTap: () {
                          if (themMode == 1) {
                            PrefData.setThemeMode(0);
                          } else {
                            PrefData.setThemeMode(1);
                          }
                          getThemeMode();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: (margin / 2.5),
                  ),
                  ConstantWidget.getTextWidget(
                      S.of(context).listAllProduct,
                      Colors.white,
                      TextAlign.start,
                      FontWeight.w400,
                      ConstantWidget.getPercentSize(height - searchHeight, 12)),
                  SizedBox(
                    height: ((margin / 1.2)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical:
                            ConstantWidget.getScreenPercentSize(context, 2)),
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            ConstantWidget.getScreenPercentSize(context, 1)),
                    height: searchHeight,
                    decoration: BoxDecoration(
                        color: cellColor,
                        borderRadius: BorderRadius.all(Radius.circular(
                            ConstantWidget.getPercentSize(searchHeight, 18)))),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                                 Navigator.push(context,
                                     MaterialPageRoute(
                                        builder: (context) => SearchWidget(),
                                      ));
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                enabled: false,
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: ConstantWidget.getPercentSize(
                                        searchHeight, 30)),
                                controller: textEditingController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: ConstantWidget.getPercentSize(
                                            searchHeight, 30)),
                                    hintText:
                                        S.of(context).searchProductPlaceholder),
                              ),
                            ),
                          ),
                          flex: 1,
                        ),
                        Container(
                          height: (searchHeight / 1.3),
                          width: (searchHeight / 1.3),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  ConstantWidget.getPercentSize(
                                      searchHeight, 18)))),
                          child: Center(
                              child: Icon(Icons.search,
                                  color: Colors.white,
                                  size: ConstantWidget.getPercentSize(
                                      (searchHeight / 1.3), 50))),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: (margin)),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(bottom: (margin * 6)),
                children: [
                  getHeaderTitle(S.of(context).searchByCategories,
                      s1: S.of(context).searchBy),
                      SizedBox(height: (margin)),
                  getProductList(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchWidget() {
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    double height = ConstantWidget.getScreenPercentSize(context, 18);
    double searchHeight = ConstantWidget.getPercentSize(height, 38);
    double radius = ConstantWidget.getPercentSize(height, 18);

    return Scaffold(
      body:  SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: height,
                decoration: BoxDecoration(
                    color: primaryColor,
              ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.all(ConstantWidget.getScreenPercentSize(context, 2)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: (){
                                _requestPop();
                              },
                              child: const Icon(
                                LineIcons.angleLeft,
                                color: Colors.white,
                              ),
                            ),
                          )

                      ),


                      flex: 1,),
                    Container(
                      margin: EdgeInsets.all(
                          ConstantWidget.getScreenPercentSize(context, 2)),
                      padding: EdgeInsets.symmetric(
                          horizontal: ConstantWidget.getScreenPercentSize(
                              context, 1)),
                      height: searchHeight,
                      decoration: BoxDecoration(
                          color: cellColor,
                          borderRadius: BorderRadius.all(Radius.circular(
                              ConstantWidget.getPercentSize(
                                  searchHeight, 18)))),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.search,
                              color: textColor,
                              size: ConstantWidget.getPercentSize(
                                  (searchHeight / 1.3), 50)),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: (margin / 2)),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextField(
                                    style: TextStyle(
                                        color: textColor,
                                        fontSize:
                                        ConstantWidget.getPercentSize(
                                            searchHeight, 30)),
                                    controller: _searchview,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize:
                                            ConstantWidget.getPercentSize(
                                                searchHeight, 30)),
                                        hintText:  S.of(context).searchProductPlaceholder),
                                  ),
                                ),
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ),
              StreamBuilder(
                stream: databaseReference.onValue,
                builder: (context, snapshot) {
                  List<CenovnikModel> cenovnikList = [];
                  if (snapshot.hasData) {
                    final card = List<dynamic>.from((snapshot.data! as Event).snapshot.value);
                    for (var key in card) {
                      final next = Map<String, dynamic>.from(key);
                      CenovnikModel descriptionModel = CenovnikModel(
                        code: next['Code'].toString(),
                        group: next['Group'].toString(),
                        subgroup: next['Subgroup'].toString(),
                        brend: next['Brend'].toString(),
                        description: next['Description'].toString(),
                        warranty: next['warranty (days)'].toString(),
                        vat: next['Vat'].toString(),
                        stock: next['Stock'].toString(),
                        price: next['Price'].toString(),
                      );
                      cenovnikList.add(descriptionModel);
                    }
                  }
                  return query1.isNotEmpty ? _performSearch(cenovnikList) : Container();
                },
              ),
            ],
          ),
        ) ,
      ),
    );
  }

  Widget favoriteWidget() {
    changeStatusColor(bgColor);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cellColor,
        centerTitle: false,
        title: ConstantWidget.getTextWidget(
            S.of(context).favoriteProducts,
            textColor,
            TextAlign.left,
            FontWeight.bold,
            ConstantWidget.getScreenPercentSize(context, 2.5)),
        leading: IconButton(
          icon: Icon(
            LineIcons.angleLeft,
            color: textColor,
          ),
          onPressed: _requestPop,
        ),
      ),
      body: const FavoritePage(),
    );
  }

  Widget aboutWidget() {
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    double height = ConstantWidget.getScreenPercentSize(context, 16);
    double radius1 = ConstantWidget.getPercentSize(height, 8);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: cellColor,
            title: ConstantWidget.getTextWidget(
                S.of(context).aboutNeksio,
                textColor,
                TextAlign.left,
                FontWeight.bold,
                ConstantWidget.getScreenPercentSize(context, 2.5)),
            leading: IconButton(
              icon: Icon(
                LineIcons.angleLeft,
                color: textColor,
              ),
              onPressed: _requestPop,
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(top: margin),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: margin),
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ConstantWidget.getTextWidget(
                      S.of(context).neksioKompjuteri,
                      textColor,
                      TextAlign.left,
                      FontWeight.w600,
                      ConstantWidget.getScreenPercentSize(context, 2.2)),
                ),
                SizedBox(height: margin / 2),
                Align(
                  alignment: Alignment.topCenter,
                  child: ConstantWidget.getTextWidget(
                      S.of(context).aboutNeksioDesc,
                      Colors.grey.shade600,
                      TextAlign.left,
                      FontWeight.w700,
                      ConstantWidget.getScreenPercentSize(context, 1.6)),
                ),
                SizedBox(height: margin),
                Container(
                  height: height,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: margin),
                  decoration: BoxDecoration(
                    color: cellColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(radius1)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all((margin / 1.5)),
                      ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.symmetric(vertical: margin / 1.4),
                        margin: EdgeInsets.only(right: margin / 1.5),
                        child: Column(children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ConstantWidget.getTextWidget(
                                      S.of(context).contactInfo,
                                      textColor,
                                      TextAlign.left,
                                      FontWeight.bold,
                                      ConstantWidget.getScreenPercentSize(
                                          context, 1.7)),
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              getContactCell(LineIcons.phone, "02/ 614 25 99",
                                  Colors.black),
                              SizedBox(
                                height: (margin * 1.0),
                              ),
                              getContactCell(LineIcons.envelopeAlt,
                                  "sales@neksio.mk", hightLightColor),
                            ],
                          ),
                        ]),
                      ))
                    ],
                  ),
                ),
                ConstantWidget.getTextWidget(
                    S.of(context).version(_version, _buildNumber),
                    textColor,
                    TextAlign.center,
                    FontWeight.bold,
                    ConstantWidget.getScreenPercentSize(context, 1.6)),
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  getHeaderTitle(String s, {String? s1}) {
    double margin = ConstantWidget.getScreenPercentSize(context, 1.7);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: margin),
      child: Row(
        children: [
          (s1 != null && s1.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: ConstantWidget.getTextWidget(
                      s1,
                      subTextColor,
                      TextAlign.left,
                      FontWeight.bold,
                      ConstantWidget.getScreenPercentSize(context, 2.2)),
                )
              : Container(),
          Expanded(
            child: ConstantWidget.getCustomText(
                s,
                textColor,
                1,
                TextAlign.left,
                FontWeight.bold,
                ConstantWidget.getScreenPercentSize(context, 2.2)),
          ),
        ],
      ),
    );
  }

  getContactCell(var icon, String s, var color) {
    double size = ConstantWidget.getScreenPercentSize(context, 4);
    double margin = ConstantWidget.getScreenPercentSize(context, 1);

    return Row(
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 0.3)),
          child: Center(
            child: Icon(icon,
                color: color, size: ConstantWidget.getPercentSize(size, 50)),
          ),
        ),
        SizedBox(width: (margin)),
        ConstantWidget.getTextWidget(s, textColor, TextAlign.left,
            FontWeight.w600, ConstantWidget.getScreenPercentSize(context, 1.5)),
      ],
    );
  }

  getBottomTextWidget(String s, var icon) {
    return BottomNavyBarItem(
      icon: Icon(icon, size: 22.0),
      title: Text(s),
      textTitle: s,
      activeColor: cellColor,
      textAlign: TextAlign.center,
    );
  }

  getProductList(BuildContext context) {
    changeStatusColor(primaryColor);
    double height = ConstantWidget.getScreenPercentSize(context, 15);
    double margin = ConstantWidget.getScreenPercentSize(context, 1.7);

    var _crossAxisSpacing = 1;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    var cellHeight = ConstantWidget.getScreenPercentSize(context, 16);

    var _aspectRatio = _width / cellHeight;
    return StreamBuilder(
      stream: databaseReference.onValue,
      builder: (context, snapshot) {
        List<String> group = [];
        if (snapshot.hasData) {
          final card =
              List<dynamic>.from((snapshot.data! as Event).snapshot.value);
          for (var key in card) {
            final next = Map<String, dynamic>.from(key);
            group.add(next['Group']);
          }
        }
        ///product count in each category
        Map<String, int> count = {};
        group.forEach((i) => count[i] = (count[i] ?? 0) + 1);
        return group.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: margin),
                child: GridView.count(
                  crossAxisCount: _crossAxisCount,
                  shrinkWrap: true,
                  childAspectRatio: _aspectRatio,
                  mainAxisSpacing: margin,
                  crossAxisSpacing: margin,
                  primary: false,
                  children: count.entries
                      .map(
                        (g) => InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => ProductsPage(groupKey: g.key)
                                //  builder: (BuildContext context) =>DescriptionPage(groupKey: g)
                              )),
                          child: Container(
                            height: cellHeight,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    ConstantWidget.getPercentSize(
                                        cellHeight, 10))),
                                image: DecorationImage(
                                    image: ExactAssetImage(
                                        ConstantData.assetImagesPath +
                                            "tile_background.png"),
                                    fit: BoxFit.fill)),
                            child: Container(
                              padding: EdgeInsets.all(margin),
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.8),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    ConstantWidget.getPercentSize(
                                        cellHeight, 10))),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ConstantWidget.getCustomText(
                                      g.key,
                                      Colors.white,
                                      3,
                                      TextAlign.center,
                                      FontWeight.w600,
                                      ConstantWidget.getPercentSize(
                                          cellHeight, 11)),
                                  ConstantWidget.getCustomText(
                                    S.of(context).totalProducts(g.value),
                                      hightLightColor,
                                      1,
                                      TextAlign.center,
                                      FontWeight.w600,
                                      ConstantWidget.getPercentSize(
                                          cellHeight, 8)),       
                                ],
                               
                              ),
                            ),
                          ),
                          
                        ),
                      )
                      .toList(),
                       
                ),
              )
              
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
      
    );
  }

  Future<bool> _requestPop() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex = 0;
      });
    } else {
      Future.delayed(const Duration(milliseconds: 200), () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      });
    }
    return Future.value(false);
  }

  Widget _performSearch(List<CenovnikModel> allProducts) {
    filteredList.clear();
    for (int i = 0; i < allProducts.length; i++) {
      var item = allProducts[i];

      if (item.description.contains(query1.toUpperCase())) {
        filteredList.add(item);
      }
    }
    return _createFilteredList();
  }

  Widget _createFilteredList() {
    double height = ConstantWidget.getScreenPercentSize(context, 18);
    double radius = ConstantWidget.getPercentSize(height, 18);
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    double cellHeight = ConstantWidget.getWidthPercentSize(context, 35);
    return Flexible(
        child:ListView.builder(
          itemCount: filteredList.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => DetailScreen(filteredList[index]),));
              },
              child: Padding(
                padding:  EdgeInsets.only(top:margin,),
                child: Container(
                  height: cellHeight,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: margin,),
                  padding: EdgeInsets.symmetric(horizontal: (margin/1.7),),

                  decoration: BoxDecoration(
                      color: cellColor,
                      borderRadius:
                      BorderRadius.all(Radius.circular(radius)),
                      border: Border.all(color: Colors.grey, width: 0.3)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: (margin/0.7),horizontal: (margin/2)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: ConstantWidget.getCustomText(
                                      filteredList[index].description,
                                      textColor,2,
                                      TextAlign.left,
                                      FontWeight.bold,
                                      ConstantWidget.getPercentSize(
                                          cellHeight, 10)),
                                ),
                                Row(
                                  children: [
                                    getPriceCell(filteredList[index].price),
                                  ],
                                ),
                                SizedBox(
                                  height: ConstantWidget.getPercentSize(
                                      cellHeight,5),
                                ),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ) );
  }
  getPriceCell(String s) {
    double margin = ConstantWidget.getScreenPercentSize(context, 1);

    return Expanded(
      child: Row(
        children: [
          SizedBox(width: (margin)),
          Expanded(
            child: ConstantWidget.getCustomText(s, textColor,1, TextAlign.left,
                FontWeight.w500, ConstantWidget.getScreenPercentSize(context, 1.5)),
          ),
        ],
      ),
    );
  }
}
