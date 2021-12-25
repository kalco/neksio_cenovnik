import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:neksio_cenovnik/pages/home_page.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset('assets/images/neksio-logo.png', height: 200.0, width: 200.0, scale: 2.5),
                    ),
                    const SizedBox(height: 60),
                    Text(
                      "Внесете го вашето име за до го видите ценовникот.",
                      style: TextStyle(
                        color: Colors.black.withOpacity(.7),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.black.withOpacity(.5)),
                              hintText: "Вашето име",
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (v) {
                              setState(() {
                                query = v;
                              });
                            },
                          ),
                        ),
                        color: Colors.black12,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ButtonTheme(
                      minWidth: double.infinity,
                      child: ElevatedButton(
                        onPressed: query.isNotEmpty
                            ? () {
                                final box = Hive.box('Name');
                                box.put(1, query);
                                FocusScope.of(context).unfocus();

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(name: query),
                                  ),
                                );
                              }
                            : null,
                        child: const Text("Влези"),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
