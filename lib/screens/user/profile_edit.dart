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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  String _gender = '';
  final DateTime _birthDate = DateTime.now();

  final ImagePicker _picker = ImagePicker();
  late XFile _file;
  bool _isLoading = false;

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
        .getUserProfileUpdateResponse(firstName, lastName, _gender, birthDate)
        .then((value) {
      if (value.runtimeType.toString() == 'UserProfileUpdateResponse' &&
          value.success) {
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
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        'first name',
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
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Text('last name'),
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
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 8.0),
                                            child: Text('birth date'),
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
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 8),
                                                child: Text('gender'),
                                              ),
                                              FormBuilderDropdown(
                                                name: 'gender',
                                                initialValue: _gender,
                                                items: const [
                                                  DropdownMenuItem(
                                                      value: 'male',
                                                      child: Text('male')),
                                                  DropdownMenuItem(
                                                      value: 'female',
                                                      child: Text('female'))
                                                ],
                                                validator: FormBuilderValidators
                                                    .compose([
                                                  FormBuilderValidators
                                                      .required(),
                                                ]),
                                                decoration: InputDecorations
                                                    .buildDropdownInputDecoration_1(
                                                        hint_text:
                                                            'Select Gender'),
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
