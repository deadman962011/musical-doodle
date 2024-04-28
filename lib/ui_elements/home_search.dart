import 'package:csh_app/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeSearch extends StatefulWidget {
  final Function onToggle;
  const HomeSearch({required this.onToggle, Key? key}) : super(key: key);

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
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 0, // Spread radius
                      blurRadius: 3, // Blur radius
                      offset: Offset(-1, 0), // Shadow offset
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(8),
                    prefixIcon: Icon(
                      Icons.search,
                      color: MyTheme.accent_color,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.3, color: MyTheme.white),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.3, color: MyTheme.white),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5, color: MyTheme.accent_color_shadow),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Type in your text",
                  ),
                )),
            PositionedDirectional(
              end: 0,
              child: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: IconButton(
                    style: IconButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        shape: CircleBorder(),
                        backgroundColor: MyTheme.accent_color),
                    onPressed: _toggleWidgets,
                    icon: Icon(
                      _showMapWidget ? Icons.home : Icons.place
                      
                      ),
                    color: MyTheme.white,
                  )),

      
            )
          ],
        ));

  }

}
