import 'package:flutter/material.dart';


class CustomSearchBar extends StatefulWidget {
  void Function()? onPressed;
  CustomSearchBar({required this.onPressed});
  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Center(
        child: TextFormField(
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
              prefixIcon: IconButton(
                onPressed:widget.onPressed,
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              contentPadding: EdgeInsets.all(10)),
        ),
      ),
    );
  }
}
