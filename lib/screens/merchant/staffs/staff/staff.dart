import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/responses/merchant/staff/merchant_staff_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_staff_repository.dart';
import 'package:com.mybill.app/screens/merchant/staffs/staff/add_staff.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';

class MerchantStaff extends StatefulWidget {
  const MerchantStaff({Key? key}) : super(key: key);

  @override
  _StaffState createState() => _StaffState();
}

class _StaffState extends State<MerchantStaff> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _mainScrollController = ScrollController();
  bool _isStaffsLoading = true;
  late List<MerchantStaffItem> _merchantStaffList = [];
  int _page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reset();
    fetchStaffs();

    _mainScrollController.addListener(() {
      if (_mainScrollController.position.pixels ==
          _mainScrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
        });
        _isStaffsLoading = true;
        reset();
        fetchStaffs();
      }
    });
  }

  fetchStaffs() async {
    // if (offerProvider.firstOffer != null) {}

    var response =
        await MerchantStaffRepository().getMerchantStaffsResponse(page: _page);
    debugPrint(response.runtimeType.toString());
    if (response.runtimeType.toString() == 'MerchantStaffResponse') {
      _merchantStaffList = response.payload.data;
    }
    setState(() {
      _isStaffsLoading = false;
    });
  }

  reset() {
    setState(() {
      _page = 1;
      _isStaffsLoading = true;
      _merchantStaffList.clear();
    });
  }

  Future<void> _onRefresh() async {
    reset();
    fetchStaffs();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: UserAppBar.buildUserAppBar(
              context, 'staff', S.of(context).staff, {}),
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
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildBankAccountList(),
                    ],
                  ),
                ),
              )),
        ));
  }

  Widget _buildBankAccountList() {
    return Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 80),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: _isStaffsLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerHelper().buildBasicShimmer(height: 120),
                  ShimmerHelper().buildBasicShimmer(height: 120),
                  ShimmerHelper().buildBasicShimmer(height: 120),
                  ShimmerHelper().buildBasicShimmer(height: 120),
                ],
              )
            : _merchantStaffList.isEmpty
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
                            S.of(context).no_staff,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            child: Text(
                              S.of(context).add_new_staff,
                              style: TextStyle(
                                  color: MyTheme.accent_color,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AddStaff();
                              })).then((value) => setState(() {
                                
                              }));
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
                          children: _merchantStaffList
                              .map((staff) => _buildStaffItem(staff))
                              .toList(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            child: Text(
                              S.of(context).add_new_staff,
                              style: TextStyle(
                                  color: MyTheme.accent_color,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AddStaff();
                              })).then((value) => setState(() {
                                
                              }));
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   return AddBankAccount();
                              // }));
                            },
                          ),
                        )
                      ],
                    )));

    // return _buildNoNotifications();
  }

  Widget _buildStaffItem(MerchantStaffItem staff) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(staff.name),
            Icon(
              Icons.arrow_right,
              color: MyTheme.accent_color,
            )
          ],
        ),
        decoration: BoxDecorations.buildBoxDecoration2(),
      ),
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return BankAccountEdit(
        //     bankAccountId: bank_account.id,
        //   );
        // }));
      },
    );
  }
}
