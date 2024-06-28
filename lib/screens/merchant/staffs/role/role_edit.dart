import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/responses/merchant/role/merchant_permissions_response.dart';
import 'package:com.mybill.app/models/responses/merchant/role/merchant_role_details_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_role_repository.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:toast/toast.dart';

class MerchantRoleEdit extends StatefulWidget {
  final String id;

  const MerchantRoleEdit({Key? key, required this.id}) : super(key: key);

  @override
  _MerchantRoleEditState createState() => _MerchantRoleEditState();
}

class _MerchantRoleEditState extends State<MerchantRoleEdit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController _roleNameInArabicController =
      TextEditingController();
  final TextEditingController _roleNameInEnglishController =
      TextEditingController();
  RoleDetails? _role;
  List<MerchantPermission> _permissionsList = [];
  List<String> _selectedPermissionsList = [];
  bool _isLoading = false;
  bool _isPermissionsLoading = true;
  bool _isRoleDetailsLoading = true;

  Map<String, dynamic> _errors = {};

  bool isFormValid() {
    if (_formKey.currentState != null && !_formKey.currentState!.isValid) {
      return false;
    }
    if (_selectedPermissionsList.isEmpty) {
      return false;
    }
    if (_isLoading) {
      return false;
    }
    if (_isRoleDetailsLoading) {
      return false;
    }
    if (_isPermissionsLoading) {
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

  fetchPermissions() async {
    var response =
        await MerchantRoleRepository().getMerchantRolesPermissionsResponse();

    if (response.runtimeType.toString() == 'MerchantPermissionsResponse') {
      setState(() {
        _permissionsList = response.payload;
        _isPermissionsLoading = false;
      });
    } else {}
  }

  fetchRole() async {
    var response = await MerchantRoleRepository()
        .getSaveMerchantRoleDetailsResponse(widget.id.toString());

    if (response.runtimeType.toString() == 'MerchantRoleDetailsResponse') {
      setState(() {
        _role = response.payload;
        _selectedPermissionsList = response.payload.permissions;
        _roleNameInArabicController.text = response.payload.roleNameInArabic;
        _roleNameInEnglishController.text = response.payload.roleNameInEnglish;
        _isRoleDetailsLoading = false;
      });
    } else {}
  }

  onPressedUpdateRole() async {
    setState(() {
      _isLoading = true;
    });

    var role_name_in_arabic = _roleNameInArabicController.value.text.toString();
    var role_name_in_english =
        _roleNameInEnglishController.value.text.toString();
    var premissions = _selectedPermissionsList.join(',');
    var response = await MerchantRoleRepository().getUpdateMerchantRoleResponse(
        widget.id, role_name_in_arabic, role_name_in_english, premissions);
    debugPrint(response.runtimeType.toString());
    if (response.runtimeType.toString() == 'MerchantUpdateRoleResponse') {
      ToastComponent.showDialog('staff role successfully updated', context,
          gravity: Toast.bottom, duration: Toast.lengthLong);

      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //   return MerchantRoles();
      // }));
    } else if (response.runtimeType.toString() == 'ValidationResponse') {
      setState(() {
        _errors = response.errors;
      });
    } else {}

    setState(() {
      _isLoading = false;
    });
  }

  togglePermission(String permission) {
    if (_selectedPermissionsList.contains(permission)) {
      setState(() {
        _selectedPermissionsList.remove(permission);
      });
    } else {
      setState(() {
        _selectedPermissionsList.add(permission);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPermissions();
    fetchRole();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: UserAppBar.buildUserAppBar(
                context, 'edit_role', S.of(context).edit_role, {}),
            body: SingleChildScrollView(
                child: Container(
                    padding:
                        const EdgeInsets.only(left: 14, right: 14, bottom: 12),
                    width: MediaQuery.of(context).size.width,
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8),
                                              child: Text(
                                                S
                                                    .of(context)
                                                    .role_name_in_arabic,
                                              ),
                                            ),
                                            FormBuilderTextField(
                                              name: 'role_name_in_ar',
                                              controller:
                                                  _roleNameInArabicController,
                                              decoration: InputDecorations
                                                  .buildDropdownInputDecoration_1(),
                                              validator: FormBuilderValidators
                                                  .compose([
                                                FormBuilderValidators
                                                    .required(),
                                                FormBuilderValidators.minLength(
                                                    3),
                                              ]),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8),
                                              child: Text(S
                                                  .of(context)
                                                  .role_name_in_english),
                                            ),
                                            FormBuilderTextField(
                                              name: 'role_name_in_english',
                                              controller:
                                                  _roleNameInEnglishController,
                                              decoration: InputDecorations
                                                  .buildDropdownInputDecoration_1(),
                                              validator: FormBuilderValidators
                                                  .compose([
                                                FormBuilderValidators
                                                    .required(),
                                                FormBuilderValidators.minLength(
                                                    3),
                                              ]),
                                            ),
                                          ],
                                        )),
                                    Column(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 8),
                                                  child: Text(S
                                                      .of(context)
                                                      .permissions),
                                                ),
                                                _buildPermissionsList()
                                              ],
                                            ))
                                      ],
                                    )
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          backgroundColor:
                                              bgColorSub(), //MyTheme.accent_color
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0))),
                                      onPressed: isFormValid()
                                          ? () async {
                                              await onPressedUpdateRole();
                                            }
                                          : null,
                                      child: _isLoading
                                          ? const SizedBox(
                                              height:
                                                  24, // Set the desired height
                                              child: LoadingIndicator(
                                                indicatorType:
                                                    Indicator.ballPulseSync,
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 255, 255, 255)
                                                ], // Customize the color if needed
                                                strokeWidth:
                                                    2, // Customize the stroke width if needed
                                                backgroundColor: Colors
                                                    .transparent, // Customize the background color if needed
                                              ))
                                          : Text(
                                              S.of(context).update,
                                              style: TextStyle(
                                                color: MyTheme.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            )))
                            ],
                          )
                        ])))));
  }

  Widget _buildPermissionsList() {
    if (_isPermissionsLoading || _isRoleDetailsLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShimmerHelper().buildBasicShimmer(height: 80),
          ShimmerHelper().buildBasicShimmer(height: 80),
          ShimmerHelper().buildBasicShimmer(height: 80),
          ShimmerHelper().buildBasicShimmer(height: 80),
        ],
      );
    } else {
      if (_permissionsList.length > 0) {
        return Column(
            children: _permissionsList.map((permission) {
          return FormBuilderSwitch(
            name: 'permission_${permission.key}',
            title: Text(permission.name),
            initialValue: _role!.permissions.contains(permission.key),
            activeColor: MyTheme.accent_color,
            inactiveThumbColor: Colors.grey.shade300,
            inactiveTrackColor: Colors.grey.shade500,
            onChanged: (value) {
              togglePermission(permission.key);
              // toggleDay(day.id);
            },
          );
        }).toList());
      } else {
        return Text('no permissions');
      }
    }
  }
}
