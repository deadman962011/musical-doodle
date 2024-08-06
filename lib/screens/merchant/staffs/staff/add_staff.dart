import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_role_repository.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_staff_repository.dart';
import 'package:com.mybill.app/screens/merchant/staffs/staff/staff.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:toast/toast.dart';

class AddStaff extends StatefulWidget {
  const AddStaff({Key? key}) : super(key: key);

  @override
  _AddStaffState createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  List<DropdownMenuItem<Object>> _roles = [];
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String roleId = '';
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
  String fullPhone = '';

  bool _isLoading = false;
  Map<String, dynamic> _errors = {};

  bool isFormValid() {
    if (_formKey.currentState != null && !_formKey.currentState!.isValid) {
      return false;
    }
    if (roleId == '') {
      return false;
    }
    if (fullPhone == '') {
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

  onPressedSaveBankAccount() async {
    setState(() {
      _isLoading = true;
    });

    var full_name = _fullNameController.value.text.toString();
    var email = _emailController.value.text.toString();
    var response = await MerchantStaffRepository()
        .getSaveMerchantStaffResponse(full_name, email, fullPhone, roleId);
    if (response.runtimeType.toString() == 'MerchantSaveStaffResponse') {
      ToastComponent.showDialog(S.of(context).staff_successfully_created, context,
          gravity: Toast.bottom, duration: Toast.lengthLong);
      // Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MerchantStaff();
      }));
    } else if (response.runtimeType.toString() == 'ValidationResponse') {
      setState(() {
        _errors = response.errors;
      });
    } else {}

    setState(() {
      _isLoading = false;
    });
  }

  fetchRoles() async {
    List<DropdownMenuItem<Object>> dropDownItems = [];

    var response = await MerchantRoleRepository().getAllMerchantRolesResponse();

    if (response.runtimeType.toString() == 'MerchantAllRolesResponse') {
      List _merchantRolessItems = response.payload;
      if (_merchantRolessItems.isNotEmpty) {
        for (var _merchantRolessItem in _merchantRolessItems) {
          dropDownItems.add(DropdownMenuItem(
            value: _merchantRolessItem.id,
            child: Text(
              _merchantRolessItem.name,
            ),
          ));
        }
      }

      setState(() {
        _roles = dropDownItems;
      });
    } else if (response.runtimeType.toString() == 'UnexpectedErrorResponse') {
      ToastComponent.showDialog(response.message, context,
          gravity: Toast.bottom, duration: Toast.lengthLong);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRoles();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: UserAppBar.buildUserAppBar(
              context, 'add_staff', S.of(context).add_staff, {}),
          body: Container(
              padding: const EdgeInsets.only(left: 14, right: 14, bottom: 12),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        FormBuilder(
                          key: _formKey,
                          onChanged: () {
                            setState(() {
                              _errors = {};
                            });
                          },
                          child: Column(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          S.of(context).full_name,
                                        ),
                                      ),
                                      FormBuilderTextField(
                                        name: 'full_name',
                                        controller: _fullNameController,
                                        decoration: InputDecorations
                                            .buildDropdownInputDecoration_1(),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                          FormBuilderValidators.minLength(3),
                                        ]),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 12, bottom: 8),
                                        child: Text(
                                          S.of(context).phone_number,
                                        ),
                                      ),
                                      IntlPhoneField(
                                        enabled: true,
                                        disableLengthCheck: true,
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

                                              _errors['phone'] = "";
                                            });
                                          } else {
                                            setState(() {
                                              fullPhone = '';
                                              _errors['phone'] = [
                                                S
                                                    .of(context)
                                                    .phone_number_is_invalid
                                              ];
                                            });
                                          }
                                        },
                                        countries: [_country],
                                        decoration: InputDecorations
                                            .buildDropdownInputDecoration_1(
                                                error_text:
                                                    _errors['phone'] != null &&
                                                            _errors['phone']
                                                                    .length >
                                                                0
                                                        ? _errors['phone']![0]
                                                        : null),
                                        initialCountryCode: 'SA',
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 8),
                                        child: Text(S.of(context).email),
                                      ),
                                      FormBuilderTextField(
                                        name: 'email',
                                        controller: _emailController,
                                        decoration: InputDecorations
                                            .buildDropdownInputDecoration_1(
                                                error_text:
                                                    _errors['email'] != null
                                                        ? _errors['email']![0]
                                                        : null),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                          FormBuilderValidators.email(),
                                        ]),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 8),
                                        child: Text(S.of(context).role),
                                      ),
                                      DropdownSearch(
                                        dropdownBuilder:
                                            (context, selectedItem) {
                                          if (selectedItem != null) {
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Container(
                                                  child: ListTile(
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    title: selectedItem,
                                                  ),
                                                ));
                                          } else {
                                            return Text(
                                                S.of(context).select_role);
                                          }
                                        },
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              roleId = value.value.toString();
                                            },
                                          );
                                        },
                                        popupProps:
                                            PopupPropsMultiSelection.menu(
                                          itemBuilder: _customPopupItemBuilder,
                                          showSearchBox: false,
                                          isFilterOnline: true,
                                        ),
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecorations
                                                  .buildInputDecoration_1(
                                                      hint_text:
                                                          S.of(context).search),
                                        ),
                                        items: _roles,
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ])),
          bottomNavigationBar: Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: bgColorSub(), //MyTheme.accent_color
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  onPressed: isFormValid()
                      ? () async {
                          await onPressedSaveBankAccount();
                        }
                      : null,
                  child: _isLoading
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
                          'Save',
                          style: TextStyle(
                            color: MyTheme.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ))),
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
