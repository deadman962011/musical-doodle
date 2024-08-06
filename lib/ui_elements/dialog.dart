import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/models/items/MerchantIOffer.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/providers/offer_provider.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_offer_repository.dart';
import 'package:com.mybill.app/screens/user/split_reward_select_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import 'package:com.mybill.app/generated/l10n.dart';
import 'package:toast/toast.dart';

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
  late Color errorColor = MyTheme.accent_color;

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
                      widget.state
                          ? Image.asset(
                              'assets/confetti.gif',
                              width: 140,
                              height: 140,
                            )
                          : Image.asset(
                              'assets/err_man.png',
                              width: 140,
                              height: 140,
                            ),
                      Text(
                        !widget.state ? S.of(context).sorry : '',
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

//

class CheckLocaionDialog extends StatefulWidget {
  final String description;
  final Function onOkPressed;

  const CheckLocaionDialog(
      {super.key, required this.description, required this.onOkPressed});

  @override
  _CheckLocaionDialogState createState() => _CheckLocaionDialogState();
}

class _CheckLocaionDialogState extends State<CheckLocaionDialog> {
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
                      Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecorations.buildBoxDecoration2(),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              'location permission',
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
                            backgroundColor: MyTheme.accent_color,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            padding: const EdgeInsets.symmetric(vertical: 10)),
                        onPressed: () {
                          widget.onOkPressed;
                          // widget.action();
                        },
                        child: Text(
                          'location permission',
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

//

class CancelOfferInvoiceDialog extends StatefulWidget {
  int offerId;
  int InvoiceId;

  CancelOfferInvoiceDialog(
      {required this.InvoiceId, required this.offerId, super.key});

  @override
  _CancelOfferInvoiceDialogState createState() =>
      _CancelOfferInvoiceDialogState();
}

class _CancelOfferInvoiceDialogState extends State<CancelOfferInvoiceDialog> {
  bool isLoading = false;
  final TextEditingController _cancelReasonController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _errors = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isFormValid() {
    if (_formKey.currentState != null && !_formKey.currentState!.isValid) {
      return false;
    }
    if (isLoading) {
      return false;
    }

    return true;
  }

  Color bgColorSub() {
    if (isFormValid()) {
      return Colors.red;
    } else {
      return Colors.red.shade700;
    }
  }

  cancelOfferInvoiceExec() async {
    setState(() {
      isLoading = true;
    });

    var _cancelReason = _cancelReasonController.text.toString();
    var response = await MerchantOfferRepository()
        .getMerchantCancelOfferInvoice(
            widget.offerId, widget.InvoiceId, _cancelReason);
    if (response.runtimeType.toString() ==
        'MerchantCancelOfferInvoiceResponse') {
      Navigator.of(context).pop();
      ToastComponent.showDialog(
          S.of(context).offer_invoice_cancelation_request_successfully_sent,
          context,
          gravity: Toast.bottom,
          duration: Toast.lengthLong);
    } else {
      ToastComponent.showDialog(response.message, context,
          gravity: Toast.bottom, duration: Toast.lengthLong);
    }

    setState(() {
      isLoading = false;
    });
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
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                            "${S.of(context).are_you_sure_you_want_cancel_the_invoice_with_id}${widget.InvoiceId} ? ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          )),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        child: FormBuilder(
                            key: _formKey,
                            onChanged: () {
                              setState(() {
                                _errors = {};
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(S.of(context).cancel_reason),
                                FormBuilder(
                                  child: Column(
                                    children: [
                                      FormBuilderTextField(
                                        name: 'cancel_reason',
                                        controller: _cancelReasonController,
                                        minLines: 6,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          fillColor: const Color.fromARGB(
                                              255,
                                              236,
                                              236,
                                              236), // Set the background color here
                                          filled: true, // Enable filling
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide
                                                .none, // Remove the border
                                          ),
                                        ),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                          FormBuilderValidators.minLength(3),
                                        ]),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
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
                            backgroundColor: bgColorSub(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            padding: const EdgeInsets.symmetric(vertical: 10)),
                        onPressed: isFormValid()
                            ? () async {
                                await cancelOfferInvoiceExec();
                              }
                            : null,
                        child: isLoading
                            ? const SizedBox(
                                height: 24, // Set the desired height
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballPulseSync,
                                  colors: [
                                    Color.fromARGB(255, 255, 255, 255)
                                  ], // Customize the color if needed
                                  strokeWidth:
                                      2, // Customize the stroke width if needed
                                  backgroundColor: Colors
                                      .transparent, // Customize the background color if needed
                                ))
                            : Text(
                                S.of(context).send,
                                style: TextStyle(
                                  color: MyTheme.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
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

class UserCashbackRecivedDialog extends StatefulWidget {
  int offer_id;
  int cashback_amount;

  UserCashbackRecivedDialog(
      {Key? key, required this.offer_id, required this.cashback_amount})
      : super(key: key);

  @override
  _UserCashbackRecivedDialogState createState() =>
      _UserCashbackRecivedDialogState();
}

class _UserCashbackRecivedDialogState extends State<UserCashbackRecivedDialog> {
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
            padding: const EdgeInsets.only(top: 8, bottom: 8),
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
                      Image.asset(
                        'assets/gift_2.png',
                        width: 80,
                        height: 80,
                      ),
                      Text(
                        S.of(context).congrats_you_got_cashback_reward,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        widget.cashback_amount.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 48),
                                      ),
                                      Text('Points',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 24))
                                    ],
                                  ),
                                  Text('Cashback',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24))
                                ],
                              )
                            ],
                          )),
                      Column(
                        children: [
                          Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 14),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10)),
                                  onPressed: () {
                                    // Navigator.pop(context);

                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SplitRewardSelectContacts(
                                        offer_id: widget.offer_id,
                                        cashback_amount: widget.cashback_amount,
                                      );
                                    }));

                                    // widget.action();
                                  },
                                  child: Text(
                                    S.of(context).split_reward,
                                    style: TextStyle(color: MyTheme.white),
                                  ))),
                          const SizedBox(height: 8.0),
                          Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 14),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // widget.action();
                                  },
                                  child: Text(
                                    'share your experience',
                                    style: TextStyle(color: Colors.black),
                                  )))
                        ],
                      )
                    ],
                  ),
                ),
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

    // Text('User Cashback recived'));
  }
}

// class AddOfferErrorDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//   }

// }
