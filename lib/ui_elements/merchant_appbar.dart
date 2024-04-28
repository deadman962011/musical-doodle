import 'package:csh_app/my_theme.dart';
import 'package:csh_app/providers/offer_provider.dart';
import 'package:csh_app/screens/merchant/offers/add_offer.dart';
import 'package:csh_app/ui_elements/dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MerchantAppBar {
  static PreferredSizeWidget buildMerchantAppBar(
      context, page, GlobalKey<ScaffoldState> scaffoldKey) {
    late List<Widget> widgets = [];
    // debugPrint(page.toString());
    switch (page) {
      case 'main':
        widgets = [
          _buildToggleDrawerButton(context, scaffoldKey),
          Text(page),
          Container()
        ];
        break;
      case 'list_offers':
        widgets = [
          _buildToggleDrawerButton(context, scaffoldKey),
          Text(page.toString()),
          _buildAddOfferButton(context),
        ];
        break;
      case 'add_offer':
        widgets = [
          _buildBackButton(context),
          Text(page.toString()),
          Container(),
        ];
        break;

      default:
    }

    return PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          padding: const EdgeInsets.only(top: 16),
          // height: preferredSize.height,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
      width: 60,
      height: 60,
      child: IconButton(
        color: MyTheme.accent_color,
        onPressed: () {
          final offerProvider =Provider.of<OfferProvider>(context, listen: false);
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
        icon: Image.asset('assets/add.svg'),
      ),
    );
  }

  static void _showModalPopup(BuildContext context) {
    showDialog(
        context: context, builder: (BuildContext context) => AddOfferErrorDialog());
  }
}