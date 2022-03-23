import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neksio_cenovnik/pages/about.dart';
import 'package:neksio_cenovnik/pages/description_page.dart';
import 'package:neksio_cenovnik/pages/favorite_bottomsheet.dart';
import 'package:neksio_cenovnik/pages/search_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameStorage = GetStorage();
  late String userName;
  final controller = TextEditingController();
  String query = '';
    

  List<String> getDeleteDuplicate(List<String> l) {
    List<String> del = [];
    for (var e in l) {
      if (!del.contains(e)) del.add(e);
    }
    return del;
  }

  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    userName = nameStorage.read('name');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            AnimatedPositioned(
              top: 0,
              left: 0,
              width: size.width,
              height: size.height,
              duration: const Duration(microseconds: 500),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 0,
                    left: 0,
                    height: 70,
                    child: Container(
                      child: SafeArea(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const About(),
                                            ),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.info,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "Нексио Ценовник",
                                        style: GoogleFonts.openSans(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const FavoriteBottomSheet(),
                                            ),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.favorite,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ))),
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 80,
                    right: 0,
                    left: 0,
                    height: size.height,
                    child: SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Container(
                        color: Colors.white,
                        child: SafeArea(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 26.0),
                                  child: Row(
                                    children: [
                                      const Text("Здраво ",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20,
                                          )),
                                      Text(
                                        '$userName,',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 26.0),
                                  child: Text(
                                      "Дознај цени на повеќе од 1200 производи",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(.6),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      )),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SearchProduct()));
                                      },
                                      child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
                                                  child: Text(
                                                    "Пребарај производи...",
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(.6),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                const Icon(
                                                    CupertinoIcons.search,
                                                    color: Colors.black)
                                              ],
                                            ),
                                          ),
                                          color: Colors.black12),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 26.0),
                                  child: Text("Категории",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      )),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                StreamBuilder(
                                  stream: databaseReference.onValue,
                                  builder: (context, snapshot) {
                                    List<String> group = [];
                                    if (snapshot.hasData) {
                                      final card = List<dynamic>.from(
                                          (snapshot.data! as Event)
                                              .snapshot
                                              .value);
                                      for (var key in card) {
                                        final next =
                                            Map<String, dynamic>.from(key);
                                        group.add(next['Group']);
                                      }
                                    }
                                    List<String> groupDeleteDublicate =
                                        getDeleteDuplicate(group);
                                    return group.isNotEmpty
                                        ? ListView(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            children: groupDeleteDublicate
                                                .map(
                                                  (g) => InkWell(
                                                    onTap: () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                DescriptionPage(
                                                                    groupKey:
                                                                        g))),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 26,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: 6,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Flexible(
                                                                  child: Row(
                                                                    children: [
                                                                      Flexible(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(12.0),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                g,
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.clip,
                                                                                style: const TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Divider(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    .2),
                                                            thickness: 1.5,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          )
                                        : const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                  },
                                ),
                              ],
                            ),
                          ),
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
    );
  }
}
