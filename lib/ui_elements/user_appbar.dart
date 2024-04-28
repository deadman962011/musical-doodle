import 'package:csh_app/my_theme.dart';
import 'package:csh_app/providers/offer_provider.dart';
import 'package:csh_app/screens/merchant/offers/add_offer.dart';
import 'package:csh_app/ui_elements/dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAppBar {
  static PreferredSizeWidget buildUserAppBar(context, page) {
    late List<Widget> widgets = [];
    // debugPrint(page.toString());
    switch (page) {
      case 'home':
      case 'profile':
        widgets = [
          const Row(
            children: [
              Text(
                'Balance:  ',
                style: TextStyle(
                    fontSize: 18,
                    // height: 37.48,
                    fontWeight: FontWeight.w700),
              ),
              Text('50',
                  style: TextStyle(
                      fontSize: 20,
                      // height: 37.48,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          Image.asset(width: 54, height: 36, 'assets/splash_screen_logo.png')
        ];
        break;
      case 'offer_details':
        widgets = [
          Row(
            children: [
              _buildBackButton(context),
              Text(page.toString()),
            ],
          ),
          Row(
            children: [
              _buildFavoriteOfferButton(context),
              _buildLocationOfferButton(context)
            ],
          )
        ];
        break;
      case 'edit_profile':
      case 'favorite':
      case 'notifications':
        widgets = [
          _buildBackButton(context),
          Text(page.toString()),
          Container(
            width: 50,
          )
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //   ],
          // ),
        ];
        break;

      default:
    }

    return PreferredSize(
        preferredSize: const Size.fromHeight(46),
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 30, bottom: 10),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          // height: preferredSize.height,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widgets,
          ),
        ));
  }

  static Widget _buildBackButton(context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        icon: const Icon(Icons.chevron_right),
        onPressed: () {
          Navigator.pop(context);
          // RootScaffold.openDrawer(context);
          // Scaffold.of(context).openDrawer();
        },
      ),
    );
  }

  static Widget _buildFavoriteOfferButton(context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        color: MyTheme.accent_color,
        onPressed: () {},
        icon: Icon(Icons.favorite_border_outlined),
      ),
    );
  }

  static Widget _buildLocationOfferButton(context) {
    return Container(
      width: 40,
      height: 40,
      child: IconButton(
        color: MyTheme.accent_color,
        onPressed: () {},
        icon: Icon(Icons.place),
      ),
    );
  }
}
