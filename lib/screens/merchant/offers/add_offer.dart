import 'package:csh_app/custom/input_decorations.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:csh_app/my_theme.dart';
import 'package:csh_app/repositories/merchant/merchant_offer_repository.dart';
import 'package:csh_app/screens/merchant/offers/offers.dart';
import 'package:csh_app/ui_elements/merchant_appbar.dart';
import 'package:csh_app/ui_elements/merchant_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddOffer extends StatefulWidget {
  const AddOffer({Key? key}) : super(key: key);

  @override
  _AddOfferState createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  // MultiSelectController _categoriesController = MultiSelectController();
  final TextEditingController _offerNameController = TextEditingController();
  final TextEditingController _offerStartDateController =
      TextEditingController();
  final TextEditingController _offerEndDateController = TextEditingController();
  final TextEditingController _offerCashbackAmountController =
      TextEditingController();
  final TextEditingController _offerComissionAmountController =
      TextEditingController(text: '5% من قيمة الفاتورة');
  DateTime? _endDateFirstDate;
  bool _isLoading = false;

  Color bgColorSub() {
    if (_formKey.currentState == null || !_formKey.currentState!.isValid) {
      return MyTheme.accent_color_shadow;
    }
    if (_isLoading) {
      return MyTheme.accent_color_shadow;
    }

    return MyTheme.accent_color;
  }

  onPressedSaveOffer() async {
    setState(() {
      _isLoading = true;
    });

    var offerName = _offerNameController.text.toString();
    var startDate = _offerStartDateController.text.toString();
    var endDate = _offerEndDateController.text.toString();
    var cashbackAmount = _offerCashbackAmountController.text.toString();

    var response = await MerchantOfferRepository().saveMerchantOfferResponse(
        offerName, startDate, endDate, cashbackAmount);
    debugPrint(response.runtimeType.toString());
    if (response.runtimeType.toString() == 'MerchantSaveOfferResponse') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MerchantOffers();
      }));

      debugPrint('offer successfully saved');
    } else {}

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: MerchantAppBar.buildMerchantAppBar(
                context, 'add_offer', _scaffoldKey),
            drawer: MerchantDrawer.buildDrawer(context),
            body: Padding(
                padding: const EdgeInsets.only(right: 14, left: 14, bottom: 20),
                child: FormBuilder(
                    onChanged: () {
                      setState(() {});
                    },
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.zero,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(AppLocalizations.of(context)!
                                            .offer_duration),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.info),
                                          iconSize: 20,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 4),
                                                child: Text(AppLocalizations.of(
                                                        context)!
                                                    .start),
                                              ),
                                              FormBuilderDateTimePicker(
                                                name: 'start_date',
                                                controller:
                                                    _offerStartDateController,
                                                decoration: InputDecorations
                                                    .buildInputDecoration_1(
                                                        hint_text: AppLocalizations
                                                                .of(context)!
                                                            .start_date_placeholder),
                                                validator: FormBuilderValidators
                                                    .compose([
                                                  FormBuilderValidators
                                                      .required(),
                                                ]),
                                                textInputAction:
                                                    TextInputAction.next,
                                                firstDate: DateTime.now(),
                                                onChanged: (DateTime? value) {
                                                  if (value != null) {
                                                    // Update the endDate's firstDate based on the startDate
                                                    setState(() {
                                                      _endDateFirstDate = value;
                                                    });
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 4),
                                                child: Text(AppLocalizations.of(
                                                        context)!
                                                    .end),
                                              ),
                                              FormBuilderDateTimePicker(
                                                name: 'end_date',
                                                controller:
                                                    _offerEndDateController,
                                                decoration: InputDecorations
                                                    .buildInputDecoration_1(
                                                        hint_text: AppLocalizations
                                                                .of(context)!
                                                            .end_date_placeholder),
                                                validator: FormBuilderValidators
                                                    .compose([
                                                  FormBuilderValidators
                                                      .required(),
                                                ]),
                                                textInputAction:
                                                    TextInputAction.next,
                                                initialDate: _endDateFirstDate
                                                        ?.add(const Duration(
                                                            hours: 1)) ??
                                                    DateTime.now(),
                                                firstDate: _endDateFirstDate
                                                        ?.add(const Duration(
                                                            hours: 1)) ??
                                                    DateTime.now(),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 12, bottom: 3),
                                  child: Text(
                                      AppLocalizations.of(context)!.offer_name),
                                ),
                                FormBuilderTextField(
                                  name: 'offerName',
                                  controller: _offerNameController,
                                  decoration:
                                      InputDecorations.buildInputDecoration_1(
                                          hint_text:
                                              AppLocalizations.of(context)!
                                                  .offer_name_placeholder),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.minLength(3),
                                  ]),
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 12, bottom: 3),
                                  child: Text(AppLocalizations.of(context)!
                                      .cashback_amount),
                                ),
                                FormBuilderDropdown(
                                  name: 'offerCashback',
                                  onChanged: (value) => {
                                    _offerCashbackAmountController.text =
                                        value.toString(),
                                    // setState(() {
                                    //   _formKey.currentState?.validate();
                                    // })
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      value: '',
                                      child: Text(AppLocalizations.of(context)!
                                          .cashback_amount_placeholder),
                                    ),
                                    const DropdownMenuItem(
                                      value: '10',
                                      child: Text('10 %'),
                                    ),
                                    const DropdownMenuItem(
                                      value: '15',
                                      child: Text('15 %'),
                                    ),
                                    const DropdownMenuItem(
                                      value: '30',
                                      child: Text('30 %'),
                                    ),
                                    const DropdownMenuItem(
                                      value: '50',
                                      child: Text('50 %'),
                                    ),
                                    const DropdownMenuItem(
                                      value: '70',
                                      child: Text('70'),
                                    ),
                                  ],
                                  decoration: InputDecorations
                                      .buildDropdownInputDecoration_1(
                                          hint_text:
                                              AppLocalizations.of(context)!
                                                  .cashback_amount_placeholder),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              textDirection: app_language_rtl.$
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 12, bottom: 3),
                                  child: Text(AppLocalizations.of(context)!
                                      .application_commission),
                                ),
                                TextFormField(
                                  controller: _offerComissionAmountController
                                    ..text =
                                        '5% ${AppLocalizations.of(context)!.of_bill_amount}',
                                  readOnly: true,
                                  decoration:
                                      InputDecorations.buildInputDecoration_1(
                                          hint_text: ''),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.zero,
                              child: FormBuilderCheckbox(
                                name: 'accept_terms',
                                activeColor: MyTheme.accent_color,
                                checkColor: MyTheme.white,
                                side: BorderSide(
                                    width: 2, color: MyTheme.accent_color),
                                shape: CircleBorder(
                                    side: BorderSide(
                                        color: MyTheme.accent_color)),
                                initialValue: false,
                                onChanged: null,
                                title: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .i_acknowledge_that_i_will_pay,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                validator: FormBuilderValidators.equal(
                                  true,
                                  errorText:
                                      'You must accept terms and conditions to continue',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 12, right: 12),
                                child: SizedBox(
                                  width: 100,
                                  height: 46,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      // primary: Colors.white,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: MyTheme.accent_color,
                                              width: 1.6),
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      // padding: !_isLoading
                                      //     ? const EdgeInsets.symmetric(vertical: 12)
                                      //     : null,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.cancel,
                                      style: TextStyle(
                                        color: MyTheme.accent_color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 12, right: 12),
                                child: SizedBox(
                                  width: 100,
                                  height: 46,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      // primary: Colors.white,
                                      backgroundColor: bgColorSub(),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      // padding: !_isLoading
                                      //     ? const EdgeInsets.symmetric(vertical: 12)
                                      //     : null,
                                    ),
                                    onPressed: !_isLoading
                                        ? () {
                                            onPressedSaveOffer();
                                          }
                                        : null,
                                    child: _isLoading
                                        ? const SizedBox(
                                            height:
                                                36, // Set the desired height
                                            child: LoadingIndicator(
                                              indicatorType:
                                                  Indicator.ballPulseSync,
                                              colors: [
                                                Color.fromARGB(
                                                    255, 255, 255, 255)
                                              ], // Customize the color if needed
                                              strokeWidth:
                                                  2, // Customize the stroke width if needed
                                              backgroundColor: Colors
                                                  .transparent, // Customize the background color if needed
                                            ))
                                        : Text(
                                            AppLocalizations.of(context)!
                                                .add_offer,
                                            style: TextStyle(
                                              color: MyTheme.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    )))));
  }
}
