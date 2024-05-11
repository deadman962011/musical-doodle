import 'package:csh_app/custom/input_decorations.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:csh_app/my_theme.dart';
import 'package:csh_app/ui_elements/merchant_appbar.dart';
import 'package:csh_app/ui_elements/merchant_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  Color bgColorSub() {
    if (_formKey.currentState == null || !_formKey.currentState!.isValid) {
      return MyTheme.grey_153;
    }
    if (_isLoading) {
      return MyTheme.accent_color_shadow;
    }

    return MyTheme.accent_color;
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
                children: [_buildShopThumb(), _buildProfileEditMenu()],
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
          'title': AppLocalizations.of(context)!.active,
          'image': 'assets/menu.png',
          'redirect_to': 'profile',
        },
        {
          'title': AppLocalizations.of(context)!.active,
          'image': 'assets/clock.png',
          'redirect_to': 'profile',
        },
        {
          'title': AppLocalizations.of(context)!.add_offer_btn,
          'image': 'assets/profile.png',
          'redirect_to': 'profile',
        },
        {
          'title': AppLocalizations.of(context)!.add_offer_has_active_error,
          'image': 'assets/profile.png',
          'redirect_to': 'profile',
        },
      ]
    };

    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('مطعم جميل'), buildMenuSection(mainProfilesData)],
        ));
  }

  Widget buildMenuSection(data) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(
        children: data['tabs'].map<Widget>((tab) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {},
                  child: Row(
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
                  )));
        }).toList(),
      )
    ]);
  }
}
