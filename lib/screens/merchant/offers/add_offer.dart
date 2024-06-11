import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/helpers/file_helper.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/file_repository.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_offer_repository.dart';
import 'package:com.mybill.app/repositories/setting_repository.dart';
import 'package:com.mybill.app/screens/merchant/offers/offers.dart';
import 'package:com.mybill.app/ui_elements/merchant_appbar.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:com.mybill.app/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:toast/toast.dart';

class AddOffer extends StatefulWidget {
  const AddOffer({super.key});

  @override
  _AddOfferState createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  // MultiSelectController _categoriesController = MultiSelectController();
  final TextEditingController _offerNameEnController = TextEditingController();
  final TextEditingController _offerNameArController = TextEditingController();
  final TextEditingController _offerStartDateController =
      TextEditingController();
  final TextEditingController _offerEndDateController = TextEditingController();
  final TextEditingController _offerCashbackAmountController =
      TextEditingController();
  final TextEditingController _offerComissionAmountController =
      TextEditingController(text: '5% من قيمة الفاتورة');
  DateTime? _endDateFirstDate = DateTime.now();
  DateTime? _endDateLastDate;
  DateTime? _endDateInitalDate;
  bool _isLoading = false;
  late final List<DropdownMenuItem> _checkout_amounts = [];

  final ImagePicker _picker = ImagePicker();
  late XFile _file;
  String? _uploaded_file = '';
  late int? _uploaded_file_id = 0;
  @override
  void initState() {
    //on Splash Screen hide statusbar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.bottom]);
    super.initState();
    fetchCheckoutAmounts();
  }

  fetchCheckoutAmounts() async {
    // setState(() {
    //   _checkout_amounts.add(DropdownMenuItem(
    //     value: '',
    //     child: Text(S.of(context).cashback_amount_placeholder),
    //   ));
    // });

    var response =
        await SettingRepository().getSettingResponse(key: 'cashbak_amounts');

    if (response.runtimeType.toString() == 'SettingResponse') {
      List amounts = response.value.split(',');
      for (var element in amounts) {
        setState(() {
          _checkout_amounts.add(DropdownMenuItem(
            value: element.toString(),
            child: Text(element.toString()),
          ));
        });
      }
    }
  }

  bool isFormValid() {
    if (_formKey.currentState != null && !_formKey.currentState!.isValid) {
      return false;
    }
    if (_uploaded_file_id == null) {
      return false;
    }

    if (_isLoading) {
      return false;
    }
    return true;
  }

  Color bgColorSub() {
    if (isFormValid()) {
      return MyTheme.accent_color;
    } else {
      return MyTheme.accent_color_shadow;
    }
  }

  DateTime parseDateString(String dateString) {
    debugPrint(dateString);
    List<String> dateParts = dateString.split(' ');
    List<String> parts = dateParts[0].split('/');
    // List<String> parts = dateString.split('/');
    int month = int.parse(parts[0]);
    int day = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    return DateTime(year, month, day);
  }

  onChangeStartDate(DateTime date) {
    DateTime startDateVal = date;
    DateTime startDateInpEndDate = startDateVal;
    DateTime endDateInpEndDate = startDateVal.add(const Duration(days: 13));
    if (_offerEndDateController.value.text.isNotEmpty) {
      var endDateInpval = parseDateString(_offerEndDateController.value.text);
      if (endDateInpval.isAfter(startDateInpEndDate) ||
          endDateInpval.isBefore(endDateInpEndDate)) {
        setState(() {
          _formKey.currentState!.fields['end_date']!.reset();
          _endDateFirstDate = endDateInpEndDate;
          _endDateLastDate = null;
        });
      }
    }
    setState(() {
      _endDateInitalDate = startDateVal;
      _endDateFirstDate = startDateInpEndDate;
      _endDateLastDate = endDateInpEndDate;
    });

    debugPrint(
        "${_endDateFirstDate.toString()}, ${_endDateLastDate.toString()}");
  }

  onPressedSaveOffer() async {
    setState(() {
      _isLoading = true;
    });

    var offerNameAr = _offerNameArController.text.toString();
    var offerNameEn = _offerNameEnController.text.toString();
    var startDate = _offerStartDateController.text.toString();
    var endDate = _offerEndDateController.text.toString();
    var cashbackAmount = _offerCashbackAmountController.text.toString();

    var response = await MerchantOfferRepository().saveMerchantOfferResponse(
        offerNameAr,
        offerNameEn,
        startDate,
        endDate,
        cashbackAmount,
        _uploaded_file_id!);
    debugPrint(response.runtimeType.toString());
    if (response.runtimeType.toString() == 'MerchantSaveOfferResponse') {
      ToastComponent.showDialog('offer successfully saved', context,
          gravity: Toast.center, duration: Toast.lengthLong);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const MerchantOffers();
      }));
    } else {
      ToastComponent.showDialog('unable to save offer', context,
          gravity: Toast.center, duration: Toast.lengthLong);
    }

    setState(() {
      _isLoading = false;
    });
  }

  chooseAndUploadImage(context) async {
    _file = (await _picker.pickImage(source: ImageSource.gallery))!;
    String base64Image = FileHelper.getBase64FormateFile(_file.path);
    String fileName = _file.path.split("/").last;
    var response = await FileRepository().getFileUploadResponse(
      base64Image,
      fileName,
    );
    if (response.runtimeType.toString() == 'FileUploadResponse' &&
        response.success) {
      setState(() {
        _uploaded_file_id = response.id;
        _uploaded_file = response.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: MerchantAppBar.buildMerchantAppBar(
                context, 'add_offer', _scaffoldKey, S.of(context).add_offer),
            drawer: MerchantDrawer.buildDrawer(context),
            body: Padding(
                padding: const EdgeInsets.only(right: 14, left: 14, bottom: 20),
                child: FormBuilder(
                    onChanged: () {
                      setState(() {});
                    },
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: SingleChildScrollView(
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
                                        Text(S.of(context).offer_duration),
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
                                                child:
                                                    Text(S.of(context).start),
                                              ),
                                              FormBuilderDateTimePicker(
                                                name: 'start_date',
                                                controller:
                                                    _offerStartDateController,
                                                decoration: InputDecorations
                                                    .buildInputDecoration_1(
                                                        hint_text: S
                                                            .of(context)
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
                                                    setState(
                                                      () {},
                                                    );
                                                    onChangeStartDate(value);
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
                                                child: Text(S.of(context).end),
                                              ),
                                              FormBuilderDateTimePicker(
                                                name: 'end_date',
                                                controller:
                                                    _offerEndDateController,
                                                decoration: InputDecorations
                                                    .buildInputDecoration_1(
                                                        hint_text: S
                                                            .of(context)
                                                            .end_date_placeholder),
                                                validator: FormBuilderValidators
                                                    .compose([
                                                  FormBuilderValidators
                                                      .required(),
                                                ]),
                                                textInputAction:
                                                    TextInputAction.next,
                                                initialDate: _endDateInitalDate,
                                                firstDate: _endDateFirstDate,
                                                lastDate: _endDateLastDate,
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
                                  child: Text(S.of(context).offer_name_in_en),
                                ),
                                FormBuilderTextField(
                                  name: 'offerNameEn',
                                  controller: _offerNameEnController,
                                  decoration:
                                      InputDecorations.buildInputDecoration_1(
                                          hint_text: S
                                              .of(context)!
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
                                  child: Text(S.of(context).offer_name_in_ar),
                                ),
                                FormBuilderTextField(
                                  name: 'offerNameAr',
                                  controller: _offerNameArController,
                                  decoration:
                                      InputDecorations.buildInputDecoration_1(
                                          hint_text: S
                                              .of(context)!
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
                                  child: Text(S.of(context).cashback_amount),
                                ),
                                FormBuilderDropdown(
                                  name: 'offerCashback',
                                  iconEnabledColor: MyTheme.accent_color,
                                  onChanged: (value) => {
                                    _offerCashbackAmountController.text =
                                        value.toString(),
                                    
                                  },
                                  items: _checkout_amounts,
                                  decoration: InputDecorations
                                      .buildDropdownInputDecoration_1(
                                          hint_text: S
                                              .of(context)!
                                              .cashback_amount_placeholder),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                ),
                              ],
                            ),

                            //
                            //
                            //
                            //
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                textDirection: app_language_rtl.$
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, bottom: 3),
                                    child: Text(
                                        S.of(context).application_commission),
                                  ),
                                  GestureDetector(
                                      child: DottedBorder(
                                          color: Colors.grey,
                                          borderType: BorderType.RRect,
                                          radius: const Radius.circular(20),
                                          dashPattern: const [10, 10],
                                          child: Container(
                                              width: double.infinity,
                                              height: 120,
                                              padding:
                                                  const EdgeInsets.all(7.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.12),
                                                    blurRadius: 6,
                                                    spreadRadius: 0.0,
                                                    offset: const Offset(0.0,
                                                        0.0), // shadow direction: bottom right
                                                  )
                                                ],
                                              ),
                                              child: ClipRRect(
                                                  child: _uploaded_file !=
                                                              null &&
                                                          _uploaded_file!
                                                              .isNotEmpty
                                                      ? Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .topRight,
                                                            children: [
                                                              Image.network(
                                                                _uploaded_file!,
                                                                width: 140,
                                                                height: 140,
                                                              ),
                                                              GestureDetector(
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          3),
                                                                  decoration: const BoxDecoration(
                                                                      color: Colors
                                                                          .red,
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(50))),
                                                                  child:
                                                                      const Icon(
                                                                    Icons.close,
                                                                    size: 18,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  setState(() {
                                                                    _uploaded_file =
                                                                        '';
                                                                    _uploaded_file_id =
                                                                        null;
                                                                  });
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : const Icon(Icons
                                                          .file_upload_outlined)
                                                  // user_avatar.$ != ''
                                                  //     ? FadeInImage.assetNetwork(
                                                  //         placeholder:
                                                  //             'assets/default_avatar.png',
                                                  //         image: user_avatar.$,
                                                  //         width: 140,
                                                  //         height: 140,
                                                  //       )
                                                  //     : Image.asset(
                                                  //         'assets/default_avatar.png',
                                                  //         width: 140,
                                                  //         height: 140,
                                                  //       )

                                                  ))),
                                      onTap: () {
                                        chooseAndUploadImage(context);
                                      })
                                ]),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              textDirection: app_language_rtl.$
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 12, bottom: 3),
                                  child: Text(
                                      S.of(context).application_commission),
                                ),
                                TextFormField(
                                  controller: _offerComissionAmountController
                                    ..text =
                                        '5% ${S.of(context).of_bill_amount}',
                                  readOnly: true,
                                  style: TextStyle(color: MyTheme.accent_color),
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
                                        text: S
                                            .of(context)!
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
                        Flex(
                          mainAxisAlignment: MainAxisAlignment.center,
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              flex: 2,
                              child: SizedBox(
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
                                    onPressed: isFormValid()
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
                                            S.of(context).add_offer_btn,
                                            style: TextStyle(
                                              color: MyTheme.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                  )),
                            ),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: SizedBox(
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
                                          S.of(context).cancel,
                                          style: TextStyle(
                                            color: MyTheme.accent_color,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    )))
                          ],
                        ),
                      ],
                    ))))));
  }
}
