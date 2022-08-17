import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_search_bar.dart';

class CustomAppBarWithSearch extends StatelessWidget with PreferredSizeWidget {
  CustomAppBarWithSearch({
    required this.title,
    this.colorAB = Colors.black,
    this.withFilter = false,
  });

  final String title;
  Color colorAB;
  final bool withFilter;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
      child: AppBar(
        elevation: 0,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        title: Text(
          title,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.grey[500],
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                withFilter
                    ? Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey[500],
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          CupertinoIcons.line_horizontal_3_decrease,
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  width: withFilter ? 10 : 0,
                ),
                Expanded(
                    child: CustomSearchBar(
                  onPressed: () {},
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(140);
}
