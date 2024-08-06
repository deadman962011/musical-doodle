import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_auth_repository.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:com.mybill.app/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:toast/toast.dart';
import 'package:com.mybill.app/helpers/file_helper.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _errors = {};
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _gender = '';
  final DateTime _birthDate = DateTime.now();

  final ImagePicker _picker = ImagePicker();
  late XFile _file;
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

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  Color bgColorSub() {
    if (_formKey.currentState == null || !_formKey.currentState!.isValid) {
      return MyTheme.grey_153;
    }
    if (_isLoading) {
      return MyTheme.accent_color_shadow;
    }

    return MyTheme.accent_color;
  }

  DateTime parseDateString(String dateString) {
    List<String> parts = dateString.split('/');
    int month = int.parse(parts[0]);
    int day = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    return DateTime(year, month, day);
  }

  fetchProfile() async {
    await UserAuthRepository().getUserProfileResponse().then((value) {
      if (value.runtimeType.toString() == 'UserProfileResponse') {
        _firstNameController.text = value.payload['first_name'];
        _lastNameController.text = value.payload['last_name'];
        _birthDateController.text = value.payload['birth_date'];

        setState(() {
          _gender = value.payload['gender'];
          _formKey.currentState!.fields['gender']
              ?.didChange(value.payload['gender']);
          _formKey.currentState!.fields['birth_date']
              ?.didChange(parseDateString(value.payload['birth_date']));
        });
      }
    });
  }

  onPressedUpdateProfile() async {
    String firstName = _firstNameController.text.toString();
    String lastName = _lastNameController.text.toString();
    String birthDate = _birthDateController.text.toString();
    setState(() {
      _isLoading = true;
    });

    var response = await UserAuthRepository()
        .getUserProfileUpdateResponse(
            firstName, lastName, _gender, birthDate, fullPhone)
        .then((value) {
      if (value.runtimeType.toString() == 'UserProfileUpdateResponse' &&
          value.success) {
        user_phone.$ = fullPhone;
        user_phone.save();

        ToastComponent.showDialog(S.of(context).profile_updated, context,
            gravity: Toast.bottom, duration: Toast.lengthLong);
      }

      setState(() {
        _isLoading = false;
      });
    });
  }

  chooseAndUploadImage(context) async {
    _file = (await _picker.pickImage(source: ImageSource.gallery))!;
    String base64Image = FileHelper.getBase64FormateFile(_file.path);
    String fileName = _file.path.split("/").last;
    var response = await UserAuthRepository().getUserProfileUpdateImageResponse(
      base64Image,
      fileName,
    );
    if (response.runtimeType.toString() == 'UserProfileUploadImageResponse' &&
        response.success) {
      ToastComponent.showDialog(S.of(context).profile_image_updated, context,
          gravity: Toast.bottom, duration: Toast.lengthLong);
    }
    user_avatar.$ = response.path;
    user_avatar.save();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: UserAppBar.buildUserAppBar(
                context, 'edit_profile', S.of(context).profile_edit, {}),
            body: Container(
              padding: const EdgeInsets.only(left: 14, right: 14, bottom: 12),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(7.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.12),
                                    blurRadius: 6,
                                    spreadRadius: 0.0,
                                    offset: const Offset(0.0,
                                        0.0), // shadow direction: bottom right
                                  )
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100))),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/default_avatar.PNG',
                                      image: user_avatar.$,
                                      width: 140,
                                      height: 140,
                                    )),
                                Image.asset(
                                  'assets/add.png',
                                  width: 40,
                                  height: 40,
                                  color: MyTheme.accent_color,
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            chooseAndUploadImage(context);
                          }),
                      FormBuilder(
                        key: _formKey,
                        onChanged: () {
                          setState(() {
                            // _errors = {};
                          });
                        },
                        child: Column(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        S.of(context).firstname,
                                      ),
                                    ),
                                    FormBuilderTextField(
                                      name: 'first_name',
                                      controller: _firstNameController,
                                      decoration: InputDecorations
                                          .buildDropdownInputDecoration_1(),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                        FormBuilderValidators.minLength(3),
                                      ]),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Text(S.of(context).last_name),
                                    ),
                                    FormBuilderTextField(
                                      name: 'last_name',
                                      controller: _lastNameController,
                                      decoration: InputDecorations
                                          .buildDropdownInputDecoration_1(),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                        FormBuilderValidators.minLength(3),
                                      ]),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: IntlPhoneField(
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
                                    int prefix =
                                        int.parse(phone.number.substring(0, 2));
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
                                          S.of(context).phone_number_is_invalid
                                        ];
                                      });
                                    }
                                  },
                                  countries: [_country],
                                  controller: _phoneController,
                                  decoration: InputDecorations
                                      .buildDropdownInputDecoration_1(
                                          error_text: _errors['phone'] !=
                                                      null &&
                                                  _errors['phone'].length > 0
                                              ? _errors['phone']![0]
                                              : null),
                                  initialCountryCode: 'SA',
                                )),
                            Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 8.0),
                                            child:
                                                Text(S.of(context).birth_date),
                                          ),
                                          FormBuilderDateTimePicker(
                                            initialDate: _birthDate,
                                            lastDate: DateTime.now(),
                                            name: 'birth_date',
                                            controller: _birthDateController,
                                            autovalidateMode:
                                                AutovalidateMode.disabled,
                                            decoration: InputDecorations
                                                .buildInputDecoration_1(
                                                    hint_text: ''),
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(),
                                            ]),
                                            inputType: InputType.date,
                                          ),
                                        ],
                                      ),
                                    )),
                                const SizedBox(
                                  width: 12,
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 8),
                                                child:
                                                    Text(S.of(context).gender),
                                              ),
                                              FormBuilderDropdown(
                                                name: 'gender',
                                                initialValue: _gender,
                                                items: [
                                                  DropdownMenuItem(
                                                      value: 'male',
                                                      child: Text(
                                                          S.of(context).male)),
                                                  DropdownMenuItem(
                                                      value: 'female',
                                                      child: Text(
                                                          S.of(context).female))
                                                ],
                                                validator: FormBuilderValidators
                                                    .compose([
                                                  FormBuilderValidators
                                                      .required(),
                                                ]),
                                                decoration: InputDecorations
                                                    .buildDropdownInputDecoration_1(
                                                        hint_text: S
                                                            .of(context)
                                                            .select_gender),
                                              )
                                            ])))
                              ],
                              // ['male','female'],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  backgroundColor:
                                      bgColorSub(), //MyTheme.accent_color
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
                              onPressed: _formKey.currentState != null &&
                                          _formKey.currentState!.isValid ||
                                      _isLoading
                                  ? () async {
                                      debugPrint('xasxasx');
                                      await onPressedUpdateProfile();
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
                                      S.of(context).save,
                                      style: TextStyle(
                                        color: MyTheme.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )

                              // Text(
                              //   'save',
                              //   style: TextStyle(color: Colors.white),
                              // )
                              ))
                    ],
                  )
                ],
              ),
            )));
  }
}
