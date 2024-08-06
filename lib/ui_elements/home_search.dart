import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/screens/user/search.dart';
import 'package:flutter/material.dart';

class HomeSearch extends StatefulWidget {
  final Function onToggle;
  const HomeSearch({required this.onToggle, super.key});

  @override
  _HomeSearchState createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  bool _showMapWidget = false;
  void _toggleWidgets() {
    widget.onToggle();
    setState(() {
      _showMapWidget = !_showMapWidget;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Text('am hereeerere');

    return GestureDetector(
      child: Container(
          decoration: BoxDecoration(
              border:
                  Border.all(width: 0.6, color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(25)),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                      padding: EdgeInsetsDirectional.only(end: 10),
                      child: Icon(
                        Icons.search,
                        color: MyTheme.accent_color,
                      )),
                  Text(S.of(context).enter_shop_name)
                ],
              ),
              IconButton(
                style: IconButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    shape: const CircleBorder(),
                    backgroundColor: Colors.black),
                onPressed: _toggleWidgets,
                icon: Icon(_showMapWidget ? Icons.home : Icons.place),
                color: MyTheme.white,
              )
            ],
          )),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserSearch()));
      },
    );

    // return SizedBox(
    //     width: MediaQuery.of(context).size.width,
    //     child: Stack(
    //       children: [
    //         Container(
    //             alignment: AlignmentDirectional.center,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(25.0), // Rounded corners
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: Colors.grey.withOpacity(0.5), // Shadow color
    //                   spreadRadius: 0, // Spread radius
    //                   blurRadius: 3, // Blur radius
    //                   offset: const Offset(-1, 0), // Shadow offset
    //                 ),
    //               ],
    //             ),
    //             child: TextField(
    //               decoration: InputDecoration(
    //                 isDense: true,
    //                 contentPadding: const EdgeInsets.all(8),
    //                 prefixIcon: Icon(
    //                   Icons.search,
    //                   color: MyTheme.accent_color,
    //                 ),
    //                 border: OutlineInputBorder(
    //                   borderSide: BorderSide(width: 0.3, color: MyTheme.white),
    //                   borderRadius: BorderRadius.circular(100),
    //                 ),
    //                 enabledBorder: OutlineInputBorder(
    //                   borderSide: BorderSide(width: 0.3, color: MyTheme.white),
    //                   borderRadius: BorderRadius.circular(100),
    //                 ),
    //                 focusedBorder: OutlineInputBorder(
    //                   borderSide: BorderSide(
    //                       width: 0.5, color: MyTheme.accent_color_shadow),
    //                   borderRadius: BorderRadius.circular(100),
    //                 ),
    //                 filled: true,
    //                 hintStyle: TextStyle(color: Colors.grey[800]),
    //                 hintText: S.of(context).enter_shop_name,
    //               ),
    //             )),
    //         PositionedDirectional(
    //           end: 0,
    //           child: Container(
    //               alignment: AlignmentDirectional.centerEnd,
    //               padding: const EdgeInsets.symmetric(horizontal: 0),
    //               child: IconButton(
    //                 style: IconButton.styleFrom(
    //                     padding: const EdgeInsets.symmetric(horizontal: 0),
    //                     shape: const CircleBorder(),
    //                     backgroundColor: MyTheme.accent_color),
    //                 onPressed: _toggleWidgets,
    //                 icon: Icon(_showMapWidget ? Icons.home : Icons.place),
    //                 color: MyTheme.white,
    //               )),
    //         )
    //       ],
    //     ));
  }
}
