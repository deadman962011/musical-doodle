import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/responses/merchant/role/merchant_role_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_role_repository.dart';
import 'package:com.mybill.app/screens/merchant/staffs/role/add_role.dart';
import 'package:com.mybill.app/screens/merchant/staffs/role/role_edit.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';

class MerchantRoles extends StatefulWidget {
  const MerchantRoles({Key? key}) : super(key: key);

  @override
  _MerchantRoleState createState() => _MerchantRoleState();
}

class _MerchantRoleState extends State<MerchantRoles>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _mainScrollController = ScrollController();
  bool _isRolesLoading = true;
  late List<MerchantRoleItem> _merchantRoleList = [];
  int _page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reset();
    fetchRoles();

    _mainScrollController.addListener(() {
      if (_mainScrollController.position.pixels ==
          _mainScrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
        });
        _isRolesLoading = true;
        reset();
        fetchRoles();
      }
    });
  }

  fetchRoles() async {
    // if (offerProvider.firstOffer != null) {}

    var response =
        await MerchantRoleRepository().getMerchantRolesResponse(page: _page);
    debugPrint(response.runtimeType.toString());
    if (response.runtimeType.toString() == 'MerchantRoleResponse') {
      _merchantRoleList = response.payload.data;
    }
    setState(() {
      _isRolesLoading = false;
    });
  }

  reset() {
    setState(() {
      _page = 1;
      _isRolesLoading = true;
      _merchantRoleList.clear();
    });
  }

  Future<void> _onRefresh() async {
    reset();
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
              context, 'merchant_roles', S.of(context).roles, {}),
          body: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: RefreshIndicator(
                color: MyTheme.accent_color,
                backgroundColor: Colors.white,
                displacement: 0,
                onRefresh: () async {
                  reset();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildRolesList(),
                    ],
                  ),
                ),
              )),
        ));
  }

  Widget _buildRolesList() {
    return Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 80),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: _isRolesLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerHelper().buildBasicShimmer(height: 120),
                  ShimmerHelper().buildBasicShimmer(height: 120),
                  ShimmerHelper().buildBasicShimmer(height: 120),
                  ShimmerHelper().buildBasicShimmer(height: 120),
                ],
              )
            : _merchantRoleList.isEmpty
                ? Container(
                    height: MediaQuery.sizeOf(context).height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/credit_card.png',
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            S.of(context).no_role,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            child: Text(
                              S.of(context).add_new_role,
                              style: TextStyle(
                                  color: MyTheme.accent_color,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AddRole();
                              })).then((value) => setState(() {}));
                            },
                          ),
                        )
                      ],
                    ))
                : Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: [
                        Column(
                          children: _merchantRoleList
                              .map((role) => _buildRoleItem(role))
                              .toList(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            child: Text(
                              S.of(context).add_new_role,
                              style: TextStyle(
                                  color: MyTheme.accent_color,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AddRole();
                              })).then((value) => setState(() {}));
                            },
                          ),
                        )
                      ],
                    )));

    // return _buildNoNotifications();
  }

  Widget _buildRoleItem(MerchantRoleItem role) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(role.name),
            Icon(
              Icons.arrow_right,
              color: MyTheme.accent_color,
            )
          ],
        ),
        decoration: BoxDecorations.buildBoxDecoration2(),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MerchantRoleEdit(
            id: role.id.toString(),
          );
        }));
      },
    );
  }
}
