import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FullscreenImageView extends StatefulWidget {
  final String imageUrl;

  FullscreenImageView({required this.imageUrl});

  @override
  _FullscreenImageViewState createState() => _FullscreenImageViewState();
}

class _FullscreenImageViewState extends State<FullscreenImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.black.withOpacity(0.5), // Semi-transparent background
      body: Stack(
        children: <Widget>[
          PositionedDirectional(
              top: 30,
              end: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close the full-screen view
                },
                child: Container(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              )),
          Center(
            child: Hero(
              tag: 'fullscreen-image',
              child: Image.network(
                widget.imageUrl, // Use the passed image URL
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
