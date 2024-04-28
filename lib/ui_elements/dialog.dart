import 'package:csh_app/custom/box_decorations.dart';
import 'package:csh_app/models/items/Offer.dart';
import 'package:csh_app/models/responses/merchant/offer/merchant_offers_response.dart';
import 'package:csh_app/my_theme.dart';
import 'package:csh_app/providers/offer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddOfferErrorDialog extends StatefulWidget {
  const AddOfferErrorDialog({Key? key}) : super(key: key);

  @override
  _AddOfferErrorDialogState createState() => _AddOfferErrorDialogState();
}

class _AddOfferErrorDialogState extends State<AddOfferErrorDialog> {
  late Offer firstOffer;
  late String errorString = '';
  late String errorButtonString = '';
  late Color errorColor;

  @override
  void initState() {
    // getFirstOffer();
    Future.delayed(Duration.zero, () {
      getFirstOffer();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getFirstOffer() {
    final firstOfferFromProvider =
        Provider.of<OfferProvider>(context, listen: false).firstOffer!;

    if (firstOfferFromProvider.state == 'pending') {
      setState(() {
        firstOffer = firstOfferFromProvider;
        errorButtonString = AppLocalizations.of(context)!.ok;
        errorString = AppLocalizations.of(context)!.add_offer_has_pending_error;
        errorColor = MyTheme.warning_color;
      });
    } else if (firstOfferFromProvider.state == 'active') {
      setState(() {
        firstOffer = firstOfferFromProvider;
        errorButtonString = AppLocalizations.of(context)!.ok;
        errorString = AppLocalizations.of(context)!.add_offer_has_active_error;
        errorColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 7, // Blur radius
            offset: Offset(0, 3), // Shadow offset
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 50, bottom: 20),
            decoration: BoxDecoration(
                color: MyTheme.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.sorry,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: errorColor,
                            fontSize: 32),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 24),
                          decoration: BoxDecorations.buildBoxDecoration2(),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              errorString,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ) //
                          ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                TextButton(
                    style: TextButton.styleFrom(
                        // primary: Colors.white,
                        backgroundColor: errorColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        padding: const EdgeInsets.symmetric(vertical: 10)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      errorButtonString,
                      style: TextStyle(color: MyTheme.white),
                    ))
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: MyTheme.white,
                  child: Icon(Icons.close, color: MyTheme.grey_153),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}














// class AddOfferErrorDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
    
//   }

// }
