import 'package:com.mybill.app/helpers/general_helper.dart';
import 'package:com.mybill.app/repositories/category_repository.dart';
import 'package:com.mybill.app/repositories/zones_repository.dart';
import 'package:flutter/services.dart';
import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/custom/device_info.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_auth_repository.dart';
import 'package:com.mybill.app/screens/merchant/location_selector.dart';
import 'package:com.mybill.app/screens/merchant/registration_completed.dart';
import 'package:com.mybill.app/ui_elements/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:com.mybill.app/generated/l10n.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class MerchantRegistration extends StatefulWidget {
  final String email;

  const MerchantRegistration({super.key, required this.email});

  @override
  _MerchantRegistrationState createState() => _MerchantRegistrationState();
}

class _MerchantRegistrationState extends State<MerchantRegistration> {
  final Debounce _debounce = Debounce(const Duration(milliseconds: 900));
  Map<String, dynamic> _errors = {};
  //controllers
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final MultiSelectController _categoriesController = MultiSelectController();
  final TextEditingController _taxRegisterController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();

  // TextEditingController _nameController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormBuilderState>();
  late List _categories_list = [];
  late List _zones_list = [];
  String categoriesIds = '';
  String fullPhone = '';
  int? zoneId;
  LatLng? selectedLocation;
  bool _isLoading = false;
  final bool _enableBtn = false;
  bool obscureText = true;
  Country _country = Country(
    name: "Saudi Arabia",
    nameTranslations: {
      "sk": "Saudská Arábia",
      "se": "Saudi-Arábia",
      "pl": "Arabia Saudyjska",
      "no": "Saudi-Arabia",
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

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    //on Splash Screen hide statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    fetchCategories();
    fetchZones();
    super.initState();
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    _debounce.dispose();
    super.dispose();
  }

  fetchCategories() async {
    var dropDownItems = [];

    var response = await CategoryRepository().getAllCategoriesResponse();
    if (response.runtimeType.toString() == 'AllCategoriesResponse') {
      List<dynamic> categories = response.categories;
      if (categories.isNotEmpty) {
        for (var category in categories) {
          dropDownItems.add(DropdownMenuItem(
            value: category.id,
            child: Text(
              category.name,
              // style: TextStyle(color: Colors.white),
            ),
          ));
        }
      }
      setState(() {
        _categories_list = dropDownItems;
      });
    } else if (response.runtimeType.toString() == 'ValidationResponse') {}
  }

  fetchZones() async {
    var dropDownItems = [];

    var response = await ZoneRepository().getAllZonesResponse();
    if (response.runtimeType.toString() == 'AllZonesResponse') {
      List<dynamic> zones = response.zones;
      if (zones.isNotEmpty) {
        for (var zone in zones) {
          dropDownItems.add(DropdownMenuItem(
            value: zone.id,
            child: Text(zone.name),
          ));
        }
      }
      setState(() {
        _zones_list = dropDownItems;
      });
    } else if (response.runtimeType.toString() == 'ValidationResponse') {}
  }

  onPressedMerchantRegister() async {
    String shopName = _shopNameController.text.toString();
    String categoriesIdsInp = categoriesIds;
    String shopTaxRegister = _taxRegisterController.text.toString();
    String shopAddress = _address.text.toString();
    String shopAdminName = _ownerNameController.text.toString();
    String shopAdminPhone = fullPhone;
    // String shopAdminPhone = _phoneController.text.toString();
    String shopAdminEmail = widget.email; //  _emailController.text.toString();
    String referralCode = _referralCodeController.text.toString();
    setState(() {
      _isLoading = true;
    });

    var response = await MerchantAuthRepository()
        .getMerchantCompleteRegisterResponse(
            shopName,
            shopAddress,
            categoriesIdsInp,
            shopTaxRegister,
            shopAdminName,
            shopAdminPhone,
            shopAdminEmail,
            selectedLocation!.longitude.toString(),
            selectedLocation!.latitude.toString(),
            zoneId!,
            referralCode);
    if (response.runtimeType.toString() == 'MerchantCompleteRegisterResponse') {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const RegistartionCompleted();
      }));
      // Navi
    } else if (response.runtimeType.toString() == 'ValidationResponse') {
      setState(() {
        _errors = response.errors;
      });

      debugPrint('errrrrrrrrrrrrrrrrrrr ${response.errors}');
    }
    setState(() {
      _isLoading = false;
    });
  }

//   isButtonActive(){
// // _isLoading ||_formKey.currentState !=null && !_formKey.currentState!.validate()
//     return true;

//   }

  bool isFormValid() {
    if (_formKey.currentState != null && !_formKey.currentState!.isValid) {
      return false;
    }
    if (categoriesIds.isEmpty) {
      return false;
    }
    if (zoneId == null) {
      return false;
    }
    if (fullPhone == '') {
      return false;
    }
    if (selectedLocation == null) {
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return AuthScreen.buildScreen(context, 'Merchant Registration',
        merchantRegistration(), true, scaffoldKey);
  }

  Widget merchantRegistration() {
    return Container(
        width: DeviceInfo(context).width,
        margin: const EdgeInsets.only(top: 140, bottom: 40),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecorations.buildBoxDecoration_1(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                'assets/envelop.png',
                width: 180,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text(
                    S.of(context).please_enter_your_informations_to_continue,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
            ),
            // Text(_formKey.currentState?.isValid.toString() ?? 's'),
            FormBuilder(
              key: _formKey,
              onChanged: () {
                setState(() {
                  _errors = {};
                });
              },
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: FormBuilderTextField(
                      // autofocus: false,
                      // autovalidateMode: AutovalidateMode.always,
                      name: 'shop_name',
                      controller: _shopNameController,
                      autovalidateMode: AutovalidateMode.disabled,
                      decoration: InputDecorations.buildInputDecoration_1(
                          hint_text: S.of(context).shop_name),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(3),
                      ]),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownSearch(
                            dropdownBuilder: (context, selectedItem) {
                              if (selectedItem != null) {
                                return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.all(0),
                                        title: selectedItem,
                                      ),
                                    ));
                              } else {
                                return const Text('Select Category');
                              }
                            },
                            // dropdownBuilder: (context, selectedItems) {

                            //   if (selectedItems.isNotEmpty) {
                            //     return Wrap(
                            //         children: selectedItems.map((e) {
                            //       return Container(
                            //         margin: const EdgeInsets.symmetric(
                            //             vertical: 8, horizontal: 6),
                            //         padding: const EdgeInsets.symmetric(
                            //           vertical: 10,
                            //           horizontal: 10,
                            //         ),
                            //         decoration: BoxDecoration(
                            //           color: MyTheme.accent_color,
                            //           borderRadius: BorderRadius.circular(20),
                            //         ),
                            //         child: Text(
                            //               e.child.data,
                            //               style: const TextStyle(
                            //                   color: Colors.white),
                            //             ) ??
                            //             const Text(''),
                            //       );
                            //     }).toList());
                            //   } else {
                            //     return Text(S.of(context).select_category);
                            //   }
                            // },
                            onChanged: (value) {
                              setState(
                                () {
                                  categoriesIds = value.value.toString();
                                },
                              );
                            },
                            popupProps: PopupPropsMultiSelection.menu(
                                itemBuilder: _customPopupItemBuilder,
                                showSearchBox: true,
                                isFilterOnline: true,
                                searchDelay:
                                    const Duration(seconds: 0, milliseconds: 1),
                                searchFieldProps: TextFieldProps(
                                    decoration: InputDecorations
                                        .buildDropdownInputDecoration_1(
                                            hint_text: S.of(context).search))),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration:
                                  InputDecorations.buildInputDecoration_1(
                                      hint_text: S.of(context).search),
                            ),
                            items: _categories_list,
                            filterFn: (i, s) {
                              return i.child.data.contains(s.toString());
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: FormBuilderTextField(
                      name: 'tax_name',
                      controller: _taxRegisterController,
                      autovalidateMode: AutovalidateMode.disabled,
                      decoration: InputDecorations.buildInputDecoration_1(
                        hint_text: S.of(context).tex_register,
                        error_text: _errors['tax_register'] != null
                            ? _errors['tax_register']![0]
                            : null,
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(3),
                      ]),
                      textInputAction: TextInputAction.next,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: FormBuilderTextField(
                      // autofocus: false,
                      // autovalidateMode: AutovalidateMode.always,
                      name: 'shop_admin_name',
                      controller: _ownerNameController,
                      autovalidateMode: AutovalidateMode.disabled,
                      decoration: InputDecorations.buildInputDecoration_1(
                          hint_text: S.of(context).shop_admin_name),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(3),
                      ]),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: IntlPhoneField(
                        enabled: true,
                        onChanged: (phone) {
                          List<String> _prefixes = [
                            '50',
                            '53',
                            '54',
                            '55',
                            '059',
                            '58',
                            '56',
                            '57'
                          ];

                          if (phone.number.length >= _country.minLength &&
                              phone.number.length <= _country.maxLength &&
                              _prefixes
                                  .contains(phone.number.substring(0, 3))) {
                            setState(() {
                              fullPhone = phone.number;
                            });
                          } else {
                            setState(() {
                              fullPhone = '';
                            });
                          }
                        },
                        countries: [_country],
                        controller: _phoneController,
                        decoration:
                            InputDecorations.buildDropdownInputDecoration_1(),
                        initialCountryCode: 'SA',
                      )

                      // FormBuilderTextField(
                      //   // autofocus: false,
                      //   // autovalidateMode: AutovalidateMode.always,
                      //   name: 'shop_admin_phone',
                      //   controller: _phoneController,
                      //   autovalidateMode: AutovalidateMode.disabled,
                      //   decoration: InputDecorations.buildInputDecoration_1(
                      //       error_text: _errors['shop_admin_phone'] != null
                      //           ? _errors['shop_admin_phone']![0]
                      //           : null,
                      //       hint_text: S.of(context).shop_admin_phone),

                      //   validator: FormBuilderValidators.compose([
                      //     FormBuilderValidators.required(),
                      //     FormBuilderValidators.minLength(10),
                      //   ]),
                      //   textInputAction: TextInputAction.next,
                      //   inputFormatters: <TextInputFormatter>[
                      //     FilteringTextInputFormatter.digitsOnly
                      //   ],
                      //   keyboardType: TextInputType.number,
                      // ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownSearch(
                            dropdownBuilder: (context, selectedItem) {
                              if (selectedItem != null) {
                                return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.all(0),
                                        title: selectedItem,
                                      ),
                                    ));
                              } else {
                                return const Text('Select Zone');
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                zoneId = value.value;
                              });
                            },
                            popupProps: PopupPropsMultiSelection.menu(
                                itemBuilder: _customPopupItemBuilder,
                                showSearchBox: true,
                                isFilterOnline: true,
                                searchDelay:
                                    const Duration(seconds: 0, milliseconds: 1),
                                searchFieldProps: TextFieldProps(
                                    decoration: InputDecorations
                                        .buildDropdownInputDecoration_1(
                                            hint_text: S.of(context).search))),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration:
                                  InputDecorations.buildInputDecoration_1(
                                      hint_text: S.of(context).search),
                            ),
                            items: _zones_list,
                            filterFn: (i, s) {
                              return i.child.data.contains(s.toString());
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: FormBuilderTextField(
                      // autofocus: false,
                      // autovalidateMode: AutovalidateMode.always,
                      controller: _referralCodeController,
                      name: 'referral_code',
                      autovalidateMode: AutovalidateMode.disabled,
                      decoration: InputDecorations.buildInputDecoration_1(
                          hint_text: S.of(context).referral_code),
                      textInputAction: TextInputAction.send,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 36,
                            decoration: BoxDecoration(
                                color: MyTheme.grey_153,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.grey.shade300.withOpacity(0.8),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: const Offset(-3, 3),
                                  )
                                ]),
                            child: TextButton(
                              child: Text(
                                S.of(context).select_location,
                                style: TextStyle(color: MyTheme.accent_color),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LocationSelector()),
                                ).then((selectedLocation) => {
                                      setState(() {
                                        this.selectedLocation =
                                            selectedLocation;
                                      })
                                    });
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SizedBox(
                            width: 130,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                // primary: Colors.white,
                                backgroundColor: bgColorSub(),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                padding: !_isLoading
                                    ? const EdgeInsets.symmetric(vertical: 12)
                                    : null,
                              ),
                              onPressed: isFormValid()
                                  ? () {
                                      onPressedMerchantRegister();
                                    }
                                  : null,
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
                                  : Text(
                                      S.of(context).continue_b,
                                      style: TextStyle(
                                        color: MyTheme.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).by_clicking_continue_you_are,
                                  style: TextStyle(
                                      color: MyTheme.grey_153,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w300),
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        minimumSize: Size.zero,
                                        padding: EdgeInsets.zero),
                                    onPressed: () {},
                                    child: Text(S.of(context).terms_conditions,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: MyTheme.accent_color,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w300))),
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _customPopupItemBuilder(BuildContext context, item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: item.child,
      ),
    );
  }
}
