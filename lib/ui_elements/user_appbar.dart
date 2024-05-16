import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/items/Offer.dart';
import 'package:com.mybill.app/repositories/user/user_favorite_offers_repository.dart';
import 'package:flutter/material.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toast/toast.dart';
// import 'package:com.mybill.app/providers/offer_provider.dart';
// import 'package:com.mybill.app/screens/merchant/offers/add_offer.dart';
// import 'package:com.mybill.app/ui_elements/dialog.dart';
// import 'package:provider/provider.dart';

class UserAppBar {
  static PreferredSizeWidget buildUserAppBar(
      context, page, title, Map<String, dynamic> methods) {
    late List<Widget> widgets = [];
    // debugPrint(page.toString());
    switch (page) {
      case 'home':
      case 'profile':
        widgets = [
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.balance,
                style: TextStyle(
                    fontSize: 18,
                    // height: 37.48,
                    fontWeight: FontWeight.w700),
              ),
              Text(' : 0',
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
              Text(title),
            ],
          ),
          Row(
            children: [
              _buildFavoriteOfferButton(context, methods),
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
          _buildTitle(title),
          Container(
            width: 50,
          )
        ];
        break;

      default:
    }

    return PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 30, bottom: 10),
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          // height: preferredSize.height,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widgets,
          ),
        ));
  }

  static Widget _buildTitle(title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
    );
  }

// app_language_rtl.$ ?  : Icons.chevron_left
  static Widget _buildBackButton(context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  static Widget _buildFavoriteOfferButton(context, methods) {
    return SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        color: MyTheme.accent_color,
        onPressed: () {
          methods['addToFavorite']();
        },
        icon: Icon(
            methods['isFavorite'] ? Icons.favorite : Icons.favorite_outline),
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
