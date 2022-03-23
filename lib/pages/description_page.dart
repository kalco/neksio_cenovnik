import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:neksio_cenovnik/widget/group_card.dart';
import 'package:neksio_cenovnik/models/models.dart';
import 'package:neksio_cenovnik/widget/search_widget.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({Key? key, required this.groupKey}) : super(key: key);
  final String groupKey;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  List<CenovnikModel> getDeleteDuplicate(List<CenovnikModel> l) {
    List<CenovnikModel> del = [];
    for (var e in l) {
      if (e.group == widget.groupKey && e.description.contains(query.toUpperCase())) {
        del.add(e);
      }
    }
    return del;
  }

  String query = '';
  late List<CenovnikModel> groupDeleteDublicate;
  Widget buildSearch() => SearchWidget(
        text: query,
        onChanged: searchDescription,
      );

  Future searchDescription(String q) async {
    final getDescription =
        groupDeleteDublicate.where((element) => element.description.contains(q.toUpperCase())).toList();
    if (!mounted) return;
    setState(() {
      query = q;
      groupDeleteDublicate = getDescription;
    });
  }

  final databaseReference = FirebaseDatabase.instance.reference();
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                "https://source.unsplash.com/1600x900/?hardware",
              ),
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(.8),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: size.height,
                  child: StreamBuilder(
                    stream: databaseReference.onValue,
                    builder: (context, snapshot) {
                      List<CenovnikModel> group = [];
                      if (snapshot.hasData) {
                        final card = List<dynamic>.from((snapshot.data! as Event).snapshot.value);
                        for (var key in card) {
                          final json = Map<String, dynamic>.from(key);
                          CenovnikModel descriptionModel = CenovnikModel(
                            code: json['Code'].toString(),
                            group: json['Group'].toString(),
                            subgroup: json['Subgroup'].toString(),
                            brend: json['Brend'].toString(),
                            description: json['Description'].toString(),
                            warranty: json['warranty (days)'].toString(),
                            vat: json['Vat'].toString(),
                            stock: json['Stock'].toString(),
                            price: json['Price'].toString(),
                          );
                          group.add(descriptionModel);
                        }
                      }
                      groupDeleteDublicate = getDeleteDuplicate(group);
                      return group.isNotEmpty
                          ? CustomScrollView(
                              physics: const BouncingScrollPhysics(),
                              slivers: [
                                SliverAppBar(
                                  backgroundColor: Colors.black.withOpacity(.8),
                                  expandedHeight: 200,
                                  pinned: true,
                                  stretch: true,
                                  flexibleSpace: FlexibleSpaceBar(
                                      stretchModes: const [StretchMode.fadeTitle, StretchMode.zoomBackground],
                                      title: Text(
                                        widget.groupKey,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      centerTitle: true,
                                      collapseMode: CollapseMode.pin,
                                      background: SizedBox(
                                        width: size.width,
                                        height: 200,
                                        child: Center(
                                          child: buildSearch(),
                                        ),
                                      )),
                                ),
                                const SliverToBoxAdapter(
                                  child: SizedBox(height: 20),
                                ),
                                const SliverToBoxAdapter(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 26),
                                    child: Text(
                                      "Производи",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, g) {
                                      return Column(
                                        //shrinkWrap: true,
                                        children: groupDeleteDublicate
                                            .map(
                                              (g) => InkWell(
                                                onTap: () {
                                                  showBottomSheet(
                                                    context: context,
                                                    builder: (BuildContext context) => GroupCard(
                                                      brend: g.brend,
                                                      code: g.code,
                                                      description: g.description,
                                                      group: g.group,
                                                      price: g.price,
                                                      stock: g.stock,
                                                      subgroup: g.subgroup,
                                                      vat: g.vat,
                                                      warranty: g.warranty,
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 26,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                          vertical: 6,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Flexible(
                                                              child: Row(
                                                                children: [
                                                                  Flexible(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(12.0),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            g.description,
                                                                            maxLines: 1,
                                                                            overflow: TextOverflow.clip,
                                                                            style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height: 5,
                                                                          ),
                                                                          Text(
                                                                            g.price,
                                                                            style: TextStyle(
                                                                              color: Colors.white.withOpacity(.4),
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          )
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
                                                        color: Colors.white.withOpacity(.2),
                                                        thickness: 1.5,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      );
                                    },
                                    childCount: groupDeleteDublicate.length > 1 ? 1 : groupDeleteDublicate.length,
                                  ),
                                ),
                                const SliverToBoxAdapter(
                                  child: SizedBox(height: 120),
                                ),
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
