import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/helpers/file_helper.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/screens/merchant/profile/contact_informations.dart';
import 'package:com.mybill.app/screens/merchant/profile/working_hours.dart';
import 'package:com.mybill.app/ui_elements/merchant_appbar.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toast/toast.dart';

class MerchantProfileEdit extends StatefulWidget {
  const MerchantProfileEdit({Key? key}) : super(key: key);

  @override
  _MerchantProfileEditState createState() => _MerchantProfileEditState();
}

class _MerchantProfileEditState extends State<MerchantProfileEdit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  late XFile _file;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  chooseAndUploadImage(context) async {
    _file = (await _picker.pickImage(source: ImageSource.gallery))!;
    if (_file == null) {
      ToastComponent.showDialog('no file chosen', context,
          gravity: Toast.center, duration: Toast.lengthLong);
      return;
    } else {
      String base64Image = FileHelper.getBase64FormateFile(_file.path);
      String fileName = _file.path.split("/").last;
      // var response =
      //     await UserAuthRepository().getUserProfileUpdateImageResponse(
      //   base64Image,
      //   fileName,
      // );
      // if (response.runtimeType.toString() == 'UserProfileUploadImageResponse' &&
      //     response.success) {
      //   ToastComponent.showDialog('profile image updated', context,
      //       gravity: Toast.bottom, duration: Toast.lengthLong);
      // }
      // user_avatar.$ = response.path;
      // user_avatar.save();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: MerchantAppBar.buildMerchantAppBar(context, 'profile_edit',
                _scaffoldKey, AppLocalizations.of(context)!.profile_edit),
            drawer: MerchantDrawer.buildDrawer(context),
            body: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  _buildShopThumb(),
                  Text('مطعم جميل'),
                  _buildProfileEditMenu()
                ],
              ),
            )));
  }

  Widget _buildShopThumb() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        FadeInImage.assetNetwork(
          width: MediaQuery.of(context).size.width,
          placeholder: 'assets/dummy_376x238.png',
          image:
              'https://images.deliveryhero.io/image/stores-glovo/stores/323ded4b85d8d3f109a4eece288ab0d25b64e98bbbbe925a53d6949796726c96?t=W3siYXV0byI6eyJxIjoibG93In19LHsicmVzaXplIjp7Im1vZGUiOiJmaWxsIiwiYmciOiJ0cmFuc3BhcmVudCIsIndpZHRoIjo1ODgsImhlaWdodCI6MzIwfX1d',
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.edit),
          color: Colors.black,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
          padding: EdgeInsets.all(6),
        )
      ],
    );
  }

  Widget _buildProfileEditMenu() {
    final Map<String, dynamic> mainProfilesData = {
      'tabs': [
        {
          'title': AppLocalizations.of(context)!.menu,
          'image': 'assets/menu_2.png',
          'action': 'menu',
          'action_title': AppLocalizations.of(context)!.add_menu
        },
        {
          'title': AppLocalizations.of(context)!.working_hours,
          'image': 'assets/clock.png',
          'action': 'working_hours',
          'action_title': AppLocalizations.of(context)!.edit
        },
        {
          'title': AppLocalizations.of(context)!.contact_informations,
          'image': 'assets/inf.png',
          'action': 'contact_informations',
          'action_title': AppLocalizations.of(context)!.edit
        },
        {
          'title': AppLocalizations.of(context)!.rating,
          'image': 'assets/star.png',
          'action': 'rating',
          'action_title': AppLocalizations.of(context)!.edit
        },
      ]
    };

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: buildMenuSection(mainProfilesData),
    );
  }

  Widget buildMenuSection(data) {
    return Column(
      children: data['tabs'].map<Widget>((tab) {
        return Column(
          children: [
            Divider(
              thickness: 0.2,
              height: 12,
              color: Colors.black,
            ),
            TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {},
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(end: 8),
                              child: Image.asset(
                                tab['image'],
                                color: MyTheme.accent_color,
                                height: 20,
                              ),
                            ),
                            Text(
                              tab['title'],
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                        ['menu', 'working_hours', 'contact_informations']
                                .contains(tab['action'])
                            ? TextButton(
                                onPressed: () {
                                  if (tab['action'] == 'menu') {
                                    chooseAndUploadImage(context);
                                  } else if (tab['action'] == 'working_hours') {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return WorkingHours();
                                    }));
                                  } else if (tab['action'] ==
                                      'contact_informations') {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ContactInformations();
                                    }));
                                  }
                                },
                                child: Text(
                                  tab['action_title'],
                                  style: TextStyle(color: MyTheme.accent_color),
                                ),
                              )
                            : Container()

                        // : tab['action'] ?  : Container()
                      ],
                    ),
                  ],
                ))
          ],
        );
      }).toList(),
    );
  }
}
