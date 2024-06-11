import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/file_helper.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/file_repository.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_offer_repository.dart';
import 'package:com.mybill.app/ui_elements/merchant_appbar.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:toast/toast.dart';

class PayOfferCommissionBank extends StatefulWidget {
  final int offerId;
  const PayOfferCommissionBank({Key? key, required this.offerId});

  @override
  _PayOfferCommissionBankState createState() => _PayOfferCommissionBankState();
}

class _PayOfferCommissionBankState extends State<PayOfferCommissionBank> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _depositAtController = TextEditingController();
  final TextEditingController _noticeCodeController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  late XFile _file;

  String? _uploaded_file = '';
  late int? _uploaded_file_id = 0;
  bool _isLoading = false;
  String fullPhone = '';
  Country _country = Country(
    name: "Saudi Arabia",
    nameTranslations: {
      "no": "Saudi-Arabia",
      "sk": "Saudská Arábia",
      "se": "Saudi-Arábia",
      "pl": "Arabia Saudyjska",
      "ja": "サウジアラビア",
      "it": "Arabia Saudita",
      "zh": "沙特阿拉伯",
      "nl": "Saoedi-Arabië",
      "de": "Saudi-Arabien",
      "fr": "Arabie saoudite",
      "es": "Arabia Saudí",
      "en": "Saudi Arabia",
      "pt_BR": "Arábia Saudita",
      "sr-Cyrl": "Саудијска Арабија",
      "sr-Latn": "Saudijska Arabija",
      "zh_TW": "沙烏地阿拉",
      "tr": "Suudi Arabistan",
      "ro": "Arabia Saudită",
      "ar": "السعودية",
      "fa": "عربستان سعودی",
      "yue": "沙地阿拉伯"
    },
    flag: "🇸🇦",
    code: "SA",
    dialCode: "966",
    minLength: 9,
    maxLength: 9,
  );

  bool isFormValid() {
    if (_formKey.currentState != null && !_formKey.currentState!.isValid) {
      return false;
    }
    if (_isLoading) {
      return false;
    }

    if (_uploaded_file_id == null || _uploaded_file_id! == 0) {
      return false;
    }
    // if (fullPhone == '') {
    //   return false;
    // }

    return true;
  }

  Color bgColorSub() {
    if (isFormValid()) {
      return MyTheme.accent_color;
    } else {
      return MyTheme.accent_color_shadow;
    }
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

  onPressedSendPayComissionReq() async {
    setState(() {
      _isLoading = true;
    });

    String amount = _amountController.text.toString();
    String fullname = _fullNameController.text.toString();
    String deposit_at = _depositAtController.text.toString();
    String notice = _noticeCodeController.text.toString();

    var response = await MerchantOfferRepository()
        .getMerchantOfferPayCommissionResponse(widget.offerId, amount, fullname,
            fullPhone, deposit_at, _uploaded_file_id!.toString(), notice);

    if (response.runtimeType.toString() == 'UnexpectedErrorResponse') {
      ToastComponent.showDialog(response.message, context,
          gravity: Toast.bottom, duration: Toast.lengthLong);
    }

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
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            // mainAxisSize: MainAxisSize.max,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 12, bottom: 3),
                                    child: Text(S.of(context).amount),
                                  ),
                                  FormBuilderTextField(
                                    name: 'amount',
                                    controller: _amountController,
                                    keyboardType: TextInputType.number,
                                    decoration:
                                        InputDecorations.buildInputDecoration_1(
                                            hint_text: S
                                                .of(context)!
                                                .offer_name_placeholder),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                      FormBuilderValidators.minLength(1),
                                      FormBuilderValidators.numeric()
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
                                        EdgeInsets.only(top: 12, bottom: 3),
                                    child: Text(S.of(context).sender_full_name),
                                  ),
                                  FormBuilderTextField(
                                    name: 'sender_full_name',
                                    controller: _fullNameController,
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
                                        EdgeInsets.only(top: 12, bottom: 3),
                                    child:
                                        Text(S.of(context).sender_phone_number),
                                  ),
                                  IntlPhoneField(
                                    enabled: true,
                                    onChanged: (phone) {
                                      List<int> _prefixes = [
                                        50,
                                        53,
                                        54,
                                        55,
                                        59,
                                        58,
                                        56,
                                        57
                                      ];
                                      if (phone.number.length > 3) {
                                        int prefix = int.parse(
                                            phone.number.substring(0, 2));
                                        bool containsPrefix =
                                            _prefixes.contains(prefix);
                                        if (phone.number.length >=
                                                _country.minLength &&
                                            phone.number.length <=
                                                _country.maxLength &&
                                            containsPrefix) {
                                          setState(() {
                                            fullPhone = phone.number;
                                          });
                                        } else {
                                          setState(() {
                                            fullPhone = '';
                                          });
                                        }
                                      }
                                    },
                                    countries: [_country],
                                    controller: _phoneController,
                                    decoration: InputDecorations
                                        .buildDropdownInputDecoration_1(),
                                    initialCountryCode: 'SA',
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 0, bottom: 3),
                                    child: Text(S.of(context).deposited_at),
                                  ),
                                  FormBuilderDateTimePicker(
                                    lastDate: DateTime.now(),
                                    name: 'birth_date',
                                    controller: _depositAtController,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    decoration:
                                        InputDecorations.buildInputDecoration_1(
                                            hint_text: S.of(context).birthDate),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                    inputType: InputType.date,
                                    textInputAction: TextInputAction.next,
                                  )
                                ],
                              ),
                              _buildAttachmentDropZone(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 12, bottom: 3),
                                    child: Text(S.of(context).notice),
                                  ),
                                  FormBuilderTextField(
                                      name: 'notice',
                                      controller: _noticeCodeController,
                                      decoration: InputDecorations
                                          .buildInputDecoration_1(
                                              hint_text: S
                                                  .of(context)!
                                                  .offer_name_placeholder),
                                      minLines: 4,
                                      maxLines: null),
                                ],
                              ),
                            ]),
                        SizedBox(
                            height: 46,
                            child: TextButton(
                              onPressed: isFormValid()
                                  ? () {
                                      onPressedSendPayComissionReq();
                                    }
                                  : null,
                              style: TextButton.styleFrom(
                                // primary: Colors.white,
                                backgroundColor: bgColorSub(),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 36, // Set the desired height
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
                                  : Text(S.of(context).save,
                                      style: TextStyle(
                                        color: MyTheme.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      )),
                            ))
                      ],
                    ))))));
  }

  Widget _buildAttachmentDropZone() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 3),
            child: Text(S.of(context).transaction_screenshot),
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
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 6,
                            spreadRadius: 0.0,
                            offset: const Offset(
                                0.0, 0.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: ClipRRect(
                          child: _uploaded_file != null &&
                                  _uploaded_file!.isNotEmpty
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Image.network(
                                        _uploaded_file!,
                                        width: 140,
                                        height: 140,
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          child: const Icon(
                                            Icons.close,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _uploaded_file = '';
                                            _uploaded_file_id = null;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                )
                              : const Icon(Icons.file_upload_outlined)
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
        ]);

    // ]);
  }
}
