import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key, required this.text, required this.onChanged}) : super(key: key);
  final String text;
  final ValueChanged<String> onChanged;
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: CupertinoTextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            onChanged: widget.onChanged,
            placeholder: "Пребарај производи...",
            placeholderStyle: const TextStyle(
              color: Colors.white,
            ),
            suffix: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Icon(
                CupertinoIcons.search,
                color: Colors.white,
                size: 20,
              ),
            ),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.black26),
              color: Colors.white12,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
