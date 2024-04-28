import 'package:csh_app/custom/box_decorations.dart';
import 'package:csh_app/custom/input_decorations.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:csh_app/my_theme.dart';
import 'package:csh_app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: UserAppBar.buildUserAppBar(context, 'edit_profile'),
            body: Container(
              padding: EdgeInsets.only(left: 14, right: 14, bottom: 12),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          child: Image.asset(
                            'assets/default_avatar.png',
                            height: 140,
                          ),
                          onTap: () {}),
                      FormBuilder(
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        'first name',
                                      ),
                                    ),
                                    FormBuilderTextField(
                                      name: 'test',
                                      decoration: InputDecorations
                                          .buildDropdownInputDecoration_1(),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text('last name'),
                                    ),
                                    FormBuilderTextField(
                                      name: 'test',
                                      decoration: InputDecorations
                                          .buildDropdownInputDecoration_1(),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text('email'),
                                    ),
                                    FormBuilderTextField(
                                      name: 'test',
                                      decoration: InputDecorations
                                          .buildDropdownInputDecoration_1(),
                                    ),
                                  ],
                                )),
                            Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Text('birth date'),
                                          ),
                                          FormBuilderDateTimePicker(
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
                                SizedBox(
                                  width: 12,
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 8),
                                                child: Text('gender'),
                                              ),
                                              FormBuilderDropdown(
                                                name: 'test',
                                                items: [
                                                  DropdownMenuItem(
                                                      value: 'male',
                                                      child: Text('male')),
                                                  DropdownMenuItem(
                                                      value: 'female',
                                                      child: Text('female'))
                                                ],
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
                      Container(
                          width: double.infinity,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  backgroundColor: MyTheme.accent_color,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
                              onPressed: () {},
                              child: Text(
                                'save',
                                style: TextStyle(color: Colors.white),
                              )))
                    ],
                  )
                ],
              ),
            )));
  }
}
