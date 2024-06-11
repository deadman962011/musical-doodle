import 'package:com.mybill.app/screens/user/main.dart';
import 'package:com.mybill.app/screens/user/redeem_points_history.dart';
import 'package:com.mybill.app/screens/user/withdraw_balance_history.dart';
import 'package:flutter/material.dart';
import 'package:com.mybill.app/my_theme.dart';

import 'package:com.mybill.app/generated/l10n.dart';
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
                S.of(context).balance,
                style: const TextStyle(
                    fontSize: 18,
                    // height: 37.48,
                    fontWeight: FontWeight.w700),
              ),
              const Text(' : 0',
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
      case 'scan':
        widgets = [
          _buildBackButton(context),
          _buildTitle(title),
          Container(
            width: 50,
          )
        ];
        break;

      case 'wallet':
        widgets = [
          Container(
            width: 50,
          ),
          _buildTitle(title),
          Container(
            width: 50,
          )
        ];
        break;
      case 'redeem_points':
        widgets = [
          _buildBackButton(context),
          _buildTitle(title),
          _buildPreviousRedeemsButton(context)
        ];
        break;

      case 'withdraw_balance':
        widgets = [
          _buildBackButton(context),
          _buildTitle(title),
          _buildWithdrawHistoryButton(context)
        ];
        break;

      default:
        widgets = [
          _buildBackButton(context),
          _buildTitle(title),
          Container(
            width: 50,
          )
        ];
    }

    return PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
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
      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
    );
  }

// app_language_rtl.$ ?  : Icons.chevron_left
  static Widget _buildBackButton(context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          final hasHistory = Navigator.of(context).canPop();
          debugPrint(
              'back clicjedasdasljkfdsklfjkldsjflsdjflksdf, ${hasHistory}');
          if (hasHistory) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return UserMain();
              }),
            );
          }
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
    return SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        color: MyTheme.accent_color,
        onPressed: () {},
        icon: const Icon(Icons.place),
      ),
    );
  }

  static Widget _buildPreviousRedeemsButton(context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return RedeemPointsHistory();
            }),
          );
        },
        icon: const Icon(Icons.history),
      ),
    );
  }

  static Widget _buildWithdrawHistoryButton(context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return WithdrawBalanceHistory();
            }),
          );
        },
        icon: const Icon(Icons.history),
      ),
    );
  }
}
