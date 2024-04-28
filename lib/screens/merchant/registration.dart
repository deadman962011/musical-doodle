import 'package:csh_app/app_config.dart';
import 'package:csh_app/helpers/general_helper.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:csh_app/repositories/category_repository.dart';
import 'package:csh_app/repositories/zones_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:csh_app/custom/box_decorations.dart';
import 'package:csh_app/custom/device_info.dart';
import 'package:csh_app/my_theme.dart';
import 'package:csh_app/repositories/merchant/merchant_auth_repository.dart';
import 'package:csh_app/screens/merchant/location_selector.dart';
import 'package:csh_app/screens/merchant/registration_completed.dart';
import 'package:csh_app/ui_elements/auth_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:csh_app/custom/input_decorations.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

class MerchantRegistration extends StatefulWidget {
  final String email;

  const MerchantRegistration({super.key, required this.email});

  @override
  _MerchantRegistrationState createState() => _MerchantRegistrationState();
}

class _MerchantRegistrationState extends State<MerchantRegistration> {
  late LatLng selectedLocation;
  final Debounce _debounce = Debounce(Duration(milliseconds: 900));
  Map<String, dynamic> _errors = {};
  //controllers
  TextEditingController _shopNameController = TextEditingController();
  TextEditingController _address = TextEditingController();
  MultiSelectController _categoriesController = MultiSelectController();
  TextEditingController _taxRegisterController = TextEditingController();
  TextEditingController _ownerNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _referralCodeController = TextEditingController();

  // TextEditingController _nameController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormBuilderState>();
  late List _categories_list = [];
  late List _zones_list = [];
  late String categoriesIds = '';
  late String zoneId = '';
  bool _isLoading = false;
  bool _enableBtn = false;

  bool obscureText = true;

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    //on Splash Screen hide statusbar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.bottom]);
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
      if (categories.length > 0) {
        categories.forEach((category) {
          dropDownItems.add(DropdownMenuItem(
            value: category.id,
            child: Text(category.name),
          ));
        });
      }
      setState(() {
        _categories_list = dropDownItems;
      });
    } else if (response.runtimeType.toString() == 'ValidationResponse') {}
  }

  fetchZones() async {
    var dropDownItems = [];

    var response = await ZoneRepository().getAllZonesResponse();
    if (response.runtimeType.toString() == 'AllCategoriesResponse') {
      List<dynamic> zones = response.zones;
      if (zones.length > 0) {
        zones.forEach((zone) {
          dropDownItems.add(DropdownMenuItem(
            value: zone.id,
            child: Text(zone.name),
          ));
        });
      }
      setState(() {
        _zones_list = dropDownItems;
      });
    } else if (response.runtimeType.toString() == 'ValidationResponse') {}
  }

  onPressedMerchantRegister() async {
    String shop_name = _shopNameController.text.toString();
    String categories_ids = categoriesIds;
    String shop_tax_register = _taxRegisterController.text.toString();
    String shop_address = _address.text.toString();
    String shop_admin_name = _ownerNameController.text.toString();
    String shop_admin_phone = _phoneController.text.toString();
    String shop_admin_email =
        widget.email; //  _emailController.text.toString();
    String referral_code = _referralCodeController.text.toString();

    setState(() {
      _isLoading = true;
    });

    var response = await MerchantAuthRepository()
        .getMerchantCompleteRegisterResponse(
            shop_name,
            shop_address,
            categories_ids,
            shop_tax_register,
            shop_admin_name,
            shop_admin_phone,
            shop_admin_email,
            selectedLocation.longitude.toString(),
            selectedLocation.latitude.toString(),
            referral_code);
    if (response.runtimeType.toString() == 'MerchantCompleteRegisterResponse') {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return RegistartionCompleted();
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

  Color bgColorSub() {
    if (_formKey.currentState == null ||
        !_formKey.currentState!.isValid ||
        categoriesIds.isEmpty) {
      return MyTheme.grey_153;
    }
    if (_isLoading) {
      return MyTheme.accent_color_shadow;
    }

    return MyTheme.accent_color;
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return AuthScreen.buildScreen(context, 'Merchant Registration',
        merchantRegistration(), true, scaffoldKey);
  }

  Widget merchantRegistration() {
    return Container(
        width: DeviceInfo(context).width,
        margin: const EdgeInsets.only(top: 140, bottom: 40),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .please_enter_your_informations_to_continue,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    padding: EdgeInsets.only(bottom: 8),
                    child: FormBuilderTextField(
                      // autofocus: false,
                      // autovalidateMode: AutovalidateMode.always,
                      name: 'shop_name',
                      controller: _shopNameController,
                      autovalidateMode: AutovalidateMode.disabled,
                      decoration: InputDecorations.buildInputDecoration_1(
                          hint_text: AppLocalizations.of(context)!.shop_name),
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
                        DropdownSearch.multiSelection(
                            dropdownBuilder: (context, selectedItems) {
                              if (selectedItems.isNotEmpty) {
                                return Wrap(
                                    children: selectedItems.map((e) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(0),
                                        title: e ?? Text(''),
                                      ),
                                    ),
                                  );
                                }).toList());
                              } else {
                                return Text(AppLocalizations.of(context)!
                                    .select_category);
                              }
                            },
                            onChanged: (value) {
                              categoriesIds =
                                  value.map((item) => item.value).join(', ');
                            },
                            popupProps: PopupPropsMultiSelection.menu(
                                itemBuilder: _customPopupItemBuilder,
                                showSearchBox: true,
                                isFilterOnline: true,
                                searchDelay:
                                    Duration(seconds: 0, milliseconds: 1),
                                searchFieldProps: TextFieldProps(
                                    decoration: InputDecorations
                                        .buildDropdownInputDecoration_1(
                                            hint_text:
                                                AppLocalizations.of(context)!
                                                    .search))),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration:
                                  InputDecorations.buildInputDecoration_1(
                                      hint_text:
                                          AppLocalizations.of(context)!.search),
                            ),
                            items: _categories_list,
                            filterFn: (i, s) {
                              return i.child.data.contains(s.toString());
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: FormBuilderTextField(
                      name: 'tax_name',
                      controller: _taxRegisterController,
                      autovalidateMode: AutovalidateMode.disabled,
                      decoration: InputDecorations.buildInputDecoration_1(
                        hint_text: AppLocalizations.of(context)!.tex_register,
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
                    padding: EdgeInsets.only(bottom: 8),
                    child: FormBuilderTextField(
                      // autofocus: false,
                      // autovalidateMode: AutovalidateMode.always,
                      name: 'shop_admin_name',
                      controller: _ownerNameController,
                      autovalidateMode: AutovalidateMode.disabled,
                      decoration: InputDecorations.buildInputDecoration_1(
                          hint_text:
                              AppLocalizations.of(context)!.shop_admin_name),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(3),
                      ]),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: FormBuilderTextField(
                      // autofocus: false,
                      // autovalidateMode: AutovalidateMode.always,
                      name: 'shop_admin_phone',
                      controller: _phoneController,
                      autovalidateMode: AutovalidateMode.disabled,
                      decoration: InputDecorations.buildInputDecoration_1(
                          error_text: _errors['shop_admin_phone'] != null
                              ? _errors['shop_admin_phone']![0]
                              : null,
                          hint_text:
                              AppLocalizations.of(context)!.shop_admin_phone),

                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(10),
                      ]),
                      textInputAction: TextInputAction.next,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownSearch(
                            dropdownBuilder: (context, selectedItem) {
                              if (selectedItem) {
                                return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(0),
                                        title: selectedItem,
                                      ),
                                    ));
                              } else {
                                return Text('Select Zone');
                              }
                            },
                            onChanged: (value) {
                              zoneId = value.value;
                            },
                            popupProps: PopupPropsMultiSelection.menu(
                                itemBuilder: _customPopupItemBuilder,
                                showSearchBox: true,
                                isFilterOnline: true,
                                searchDelay:
                                    Duration(seconds: 0, milliseconds: 1),
                                searchFieldProps: TextFieldProps(
                                    decoration: InputDecorations
                                        .buildDropdownInputDecoration_1(
                                            hint_text:
                                                AppLocalizations.of(context)!
                                                    .search))),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration:
                                  InputDecorations.buildInputDecoration_1(
                                      hint_text:
                                          AppLocalizations.of(context)!.search),
                            ),
                            items: _zones_list,
                            filterFn: (i, s) {
                              return i.child.data.contains(s.toString());
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: FormBuilderTextField(
                      // autofocus: false,
                      // autovalidateMode: AutovalidateMode.always,
                      controller: _referralCodeController,
                      name: 'referral_code',
                      autovalidateMode: AutovalidateMode.disabled,
                      decoration: InputDecorations.buildInputDecoration_1(
                          hint_text:
                              AppLocalizations.of(context)!.referral_code),
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
                                AppLocalizations.of(context)!.select_location,
                                style: TextStyle(color: MyTheme.accent_color),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LocationSelector()),
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
                              onPressed: _formKey.currentState != null &&
                                      _formKey.currentState!.isValid &&
                                      categoriesIds.isNotEmpty
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
                                      AppLocalizations.of(context)!.continue_b,
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
                                  AppLocalizations.of(context)!
                                      .by_clicking_continue_you_are,
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
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .terms_conditions,
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
      margin: EdgeInsets.symmetric(horizontal: 8),
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
