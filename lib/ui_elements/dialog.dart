import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/models/items/MerchantIOffer.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/providers/offer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:com.mybill.app/generated/l10n.dart';

//
class AddOfferErrorDialog extends StatefulWidget {
  const AddOfferErrorDialog({super.key});

  @override
  _AddOfferErrorDialogState createState() => _AddOfferErrorDialogState();
}

class _AddOfferErrorDialogState extends State<AddOfferErrorDialog> {
  late MerchantOffer firstOffer;
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
        errorButtonString = S.of(context).ok;
        errorString = S.of(context).add_offer_has_pending_error;
        errorColor = MyTheme.warning_color;
      });
    } else if (firstOfferFromProvider.state == 'active') {
      setState(() {
        firstOffer = firstOfferFromProvider;
        errorButtonString = S.of(context).ok;
        errorString = S.of(context).add_offer_has_active_error;
        errorColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(14),
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
            offset: const Offset(0, 3), // Shadow offset
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            decoration: BoxDecoration(
                color: MyTheme.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
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
                        S.of(context).sorry,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: errorColor,
                            fontSize: 32),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 24),
                          decoration: BoxDecorations.buildBoxDecoration2(),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              errorString,
                              style: const TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ) //
                          ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
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

//

class ScanErrorDialog extends StatefulWidget {
  final bool state;
  final String errorText;
  final void Function() action;

  const ScanErrorDialog(
      {super.key,
      required this.state,
      required this.errorText,
      required this.action});

  @override
  _ScanErrorDialogState createState() => _ScanErrorDialogState();
}

class _ScanErrorDialogState extends State<ScanErrorDialog> {
  late String errorString = widget.errorText;
  late String errorButtonString = S.of(context).ok;
  late Color errorColor = widget.state ? Colors.green : Colors.red;

  @override
  void initState() {
    // getFirstOffer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(14),
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
            offset: const Offset(0, 3), // Shadow offset
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            decoration: BoxDecoration(
                color: MyTheme.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
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
                      Image.asset('assets/err_man.png'),
                      Text(
                        S.of(context).sorry,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: errorColor,
                            fontSize: 32),
                      ),
                      Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecorations.buildBoxDecoration2(),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              errorString,
                              style: const TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ) //
                          ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: errorColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            padding: const EdgeInsets.symmetric(vertical: 10)),
                        onPressed: () {
                          Navigator.pop(context);
                          widget.action();
                        },
                        child: Text(
                          errorButtonString,
                          style: TextStyle(color: MyTheme.white),
                        )))
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
