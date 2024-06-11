import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/providers/offer_provider.dart';
import 'package:com.mybill.app/screens/merchant/offers/add_offer.dart';
import 'package:com.mybill.app/ui_elements/dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MerchantAppBar {
  static PreferredSizeWidget buildMerchantAppBar(
    context,
    page,
    GlobalKey<ScaffoldState> scaffoldKey,
    title,
  ) {
    late List<Widget> widgets = [];
    // debugPrint(page.toString());
    switch (page) {
      case 'main':
        widgets = [
          _buildToggleDrawerButton(context, scaffoldKey),
          Text(title),
          Container()
        ];
        break;
      case 'list_offers':
        widgets = [
          _buildToggleDrawerButton(context, scaffoldKey),
          Text(title),
          _buildAddOfferButton(context),
        ];
        break;
      case 'add_offer':
        widgets = [
          _buildBackButton(context),
          Text(title),
          Container(),
        ];
        break;
      case 'offer_details':
        widgets = [
          _buildToggleDrawerButton(context, scaffoldKey),
          Text(title),
          Container()
        ];
        break;

      case 'profile_edit':
        widgets = [
          _buildToggleDrawerButton(context, scaffoldKey),
          Text(title),
          Container()
        ];
        break;
      case 'statistics':
        widgets = [
          _buildToggleDrawerButton(context, scaffoldKey),
          Text(title),
          Container()
        ];
        break;

      case 'commission_payment':
        widgets = [
          _buildToggleDrawerButton(context, scaffoldKey),
          Text(title),
          Container()
        ];
        break;

      default:
        widgets = [
          _buildBackButton(context),
          Text(title),
          Container(),
        ];
        break;
    }

    return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.only(top: 12, right: 14, left: 14),
          // height: preferredSize.height,
          color: Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widgets,
          ),
        ));
  }

  static Widget _buildToggleDrawerButton(context, scaffoldKey) {
    return SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        icon: Image.asset('assets/switch_bar.png'),
        onPressed: () {
          // Scaffold.of(context).openDrawer();
          // debugPrint(scaffoldKey.currentState.openDrawer());
          scaffoldKey.currentState?.openDrawer();
        },
      ),
    );
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

  static Widget _buildAddOfferButton(context) {
    return SizedBox(
      width: 46,
      height: 46,
      child: IconButton(
        color: MyTheme.accent_color,
        onPressed: () {
          final offerProvider =
              Provider.of<OfferProvider>(context, listen: false);
          final firstOffer = offerProvider.firstOffer;

          if (firstOffer != null && firstOffer.state == 'active') {
            _showModalPopup(context);
          } else if (firstOffer != null && firstOffer.state == 'pending') {
            _showModalPopup(context);
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddOffer();
            }));
          }
        },
        icon: Image.asset(
          'assets/add.png',
          color: MyTheme.accent_color,
        ),
      ),
    );
  }

  static void _showModalPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => const AddOfferErrorDialog());
  }
}
