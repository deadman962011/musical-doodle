import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/responses/merchant/merchant_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_repository.dart';
import 'package:com.mybill.app/ui_elements/merchant_appbar.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:toast/toast.dart';

import 'package:com.mybill.app/helpers/file_helper.dart';
import 'package:image_picker/image_picker.dart';

class MerchantEdit extends StatefulWidget {
  const MerchantEdit({Key? key}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<MerchantEdit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController _shopNameInArController = TextEditingController();
  final TextEditingController _shopNameInEnController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  late XFile? _file;
  bool _isLoading = false;
  MerchantDetails? merchantDetails;
  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  fetchAll() {
    fetchShop();
  }

  fetchShop() async {
    var response = await MerchantRepository().getMerchantResponse();
    if (response.runtimeType.toString() == 'MerchantResponse') {
      MerchantResponse data = response;
      setState(() {
        _shopNameInArController.text = data.payload.shopNameAr;
        _shopNameInEnController.text = data.payload.shopNameEn;
        merchantDetails = data.payload;
      });
    }
  }

  bool isFormValid() {
    if (_formKey.currentState != null && !_formKey.currentState!.isValid) {
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

  onPressedUpdate() async {
    String shopNameAr = _shopNameInArController.text.toString();

    String shopNameEn = _shopNameInEnController.text.toString();

    setState(
      () {
        _isLoading = true;
      },
    );

    var response = await MerchantRepository()
        .getMerchantUpdateResponse(shopNameAr, shopNameEn);
    if (response.runtimeType.toString() == 'MerchantUpdateResponse') {
      ToastComponent.showDialog(
          'Shop informations successfully updated', context,
          gravity: Toast.bottom, duration: Toast.lengthLong);
    }

    setState(
      () {
        _isLoading = false;
      },
    );
  }

  handleUploadLogo(context) async {
    _file = await _picker.pickImage(source: ImageSource.gallery);

    if (_file != null) {
      String base64Image = FileHelper.getBase64FormateFile(_file!.path);
      String fileName = _file!.path.split("/").last;

      var response = await MerchantRepository().getMerchantUpdateLogoResponse(
        base64Image,
        fileName,
      );
      debugPrint(response.toString());
      if (response.runtimeType.toString() == 'MerchantUpdateLogoResponse') {
        if (response.success) {
          fetchAll();
          ToastComponent.showDialog(S.of(context).shop_logo_updated, context,
              gravity: Toast.bottom, duration: Toast.lengthLong);
          setState(() {});
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: MerchantAppBar.buildMerchantAppBar(
                context,
                'shop_informations',
                _scaffoldKey,
                S.of(context).shop_informations),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  child: Container(
                                    padding: const EdgeInsets.all(7.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.12),
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
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/default_avatar.png',
                                              image: merchantDetails != null &&
                                                      merchantDetails!.logo !=
                                                          null
                                                  ? merchantDetails!.logo!
                                                  : 'https://images.deliveryhero.io/image/stores-glovo/stores/323ded4b85d8d3f109a4eece288ab0d25b64e98bbbbe925a53d6949796726c96?t=W3siYXV0byI6eyJxIjoibG93In19LHsicmVzaXplIjp7Im1vZGUiOiJmaWxsIiwiYmciOiJ0cmFuc3BhcmVudCIsIndpZHRoIjo1ODgsImhlaWdodCI6MzIwfX1d',
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
                                    handleUploadLogo(context);
                                  }),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 12, bottom: 3),
                                    child:
                                        Text(S.of(context).shop_name_in_arabic),
                                  ),
                                  FormBuilderTextField(
                                    name: 'shop_name_in_ar',
                                    controller: _shopNameInArController,
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
                                    child: Text(
                                        S.of(context).shop_name_in_english),
                                  ),
                                  FormBuilderTextField(
                                    name: 'shop_name_in_en',
                                    controller: _shopNameInEnController,
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
                            ]),
                        SizedBox(
                            height: 46,
                            child: TextButton(
                              onPressed: isFormValid()
                                  ? () {
                                      onPressedUpdate();
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
                                  : Text(S.of(context).update,
                                      style: TextStyle(
                                        color: MyTheme.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      )),
                            ))
                      ],
                    ))))));
  }
}
