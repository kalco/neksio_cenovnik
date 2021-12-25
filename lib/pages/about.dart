import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.arrow_back, color: Colors.black)),
                        const Text(
                          "За нексио компјутери",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox()
                      ],
                    ),
                  ),
                ),
                bannerImg(context),
              ],
            ),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget bannerImg(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 30.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      " НЕКСИО",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      " КОМПЈУТЕРИ".toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.grey.shade600),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  indent: 5.0,
                  endIndent: 20.0,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 10.0, 20.0, 0.0),
                  child: Text(
                    "Оваа апликиација е неофицијална и не е поддржана од Нексио компјутер.\nСите податоци во оваа апликација се од јавен карактер и не сносувам никаква одговорност за веродостојноста на истите.",
                    style: TextStyle(fontSize: 13.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        "Контакт ",
                        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w400),
                      ),
                      SelectableText(
                        "sales@neksio.mk",
                        style: TextStyle(color: Colors.black, fontSize: 11.0, fontWeight: FontWeight.w600),
                      ),
                      SelectableText(
                        "02/ 614 25 99",
                        style: TextStyle(color: Colors.black, fontSize: 11.0, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "v 1.0.0",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
