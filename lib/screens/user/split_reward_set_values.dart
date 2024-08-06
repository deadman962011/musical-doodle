import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/screens/user/main.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:com.mybill.app/repositories/user/user_split_cashback_repository.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplitRewardSetValues extends StatefulWidget {
  int cashback_amount;
  int offer_id;
  List selected_contacts;

  SplitRewardSetValues(
      {Key? key,
      required this.offer_id,
      required this.cashback_amount,
      required this.selected_contacts})
      : super(key: key);

  @override
  _SplitRewardSetValuesState createState() => _SplitRewardSetValuesState();
}

class _SplitRewardSetValuesState extends State<SplitRewardSetValues> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String activeSplitMode = 'equal';
  bool isEqualSplitEnabled = true;
  int totalSplitedAmout = 0;

  List<dynamic> _contacts = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      totalSplitedAmout = widget.cashback_amount;
    });

    _canDivideEqually();
    _splitCashback();
    // _importContacts();
  }

  _canDivideEqually() {
    var canDivide =
        widget.cashback_amount % widget.selected_contacts.length == 0;
    if (!canDivide) {
      setState(() {
        activeSplitMode = 'custom';
        isEqualSplitEnabled = false;
      });
    }
  }

  _splitCashback() {
    setState(() {
      _contacts.clear();
    });
    if (isEqualSplitEnabled) {
      int amount = widget.cashback_amount ~/ widget.selected_contacts.length;
      widget.selected_contacts.forEach((contact) {
        setState(() {
          _contacts.add({'contact': contact, 'amount': amount});
        });
      });
    } else {
      //handle custom split
      int totalCashback = widget.cashback_amount;
      int contactsCount = widget.selected_contacts.length;

      int baseAmountPerContact = totalCashback ~/ contactsCount;
      int remainder = totalCashback % contactsCount;

      widget.selected_contacts.forEach((contact) {
        setState(() {
          int amountToAdd = baseAmountPerContact;
          // Add remainder to the first contact
          if (_contacts.isEmpty) {
            amountToAdd += remainder;
          }
          _contacts.add({'contact': contact, 'amount': amountToAdd});
        });
      });
    }
  }

  _toggleSplitMode(String mode) {
    if (isEqualSplitEnabled && mode == 'equal') {
      setState(() {
        _splitCashback();
      });
    }

    setState(() {
      activeSplitMode = mode;
    });
  }

  _increaseQty(int id) {
    if (totalSplitedAmout < widget.cashback_amount) {
      int indexOfContact =
          _contacts.indexWhere((element) => element['contact'].id == id);

      setState(() {
        _contacts[indexOfContact]['amount'] =
            _contacts[indexOfContact]['amount'] + 1;
        totalSplitedAmout = totalSplitedAmout + 1;
        activeSplitMode = 'custom';
      });
    }
  }

  _reduceQty(int id) {
    int indexOfContact =
        _contacts.indexWhere((element) => element['contact'].id == id);

    if (_contacts[indexOfContact]['amount'] != 0) {
      setState(() {
        _contacts[indexOfContact]['amount'] =
            _contacts[indexOfContact]['amount'] + -1;
        totalSplitedAmout = totalSplitedAmout - 1;
        activeSplitMode = 'custom';
      });
    }
  }

  _removeContact(int id) {
    setState(() {
      //_contacts.indexWhere((element) => element['contact'].id == id);
      int indexOfContact =
          _contacts.indexWhere((element) => element['contact'].id == id);
      debugPrint(indexOfContact.toString());
      totalSplitedAmout =
          totalSplitedAmout - _contacts[indexOfContact]['amount'] as int;
      _contacts.removeAt(indexOfContact);
    });
  }

  bool isValid() {
    return totalSplitedAmout == widget.cashback_amount ? true : false;
  }

  _onPressedSplitCashback() async {
    var user_ids = [];
    var amount_ids = [];

    _contacts.forEach((element) {
      user_ids.add(element['contact'].id);
      amount_ids.add(element['amount']);
    });

    var response = await UserSplitCashbackRepository()
        .getUserSplitCashbackResponse(widget.offer_id, user_ids, amount_ids);
    if (response.runtimeType.toString() == 'UserSplitCashbackResponse') {
      // Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return UserMain(
          go_back: false,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: UserAppBar.buildUserAppBar(context,
                'split_reward_set_values', 'split_reward_set_values ', {}),
            body: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  Text(widget.cashback_amount.toString()),
                  _buildSplitModeTabs(),
                  _buildContactsList(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsetsDirectional.only(end: 6),
                                child: Image.asset(
                                  "assets/home.png",
                                  color: MyTheme.accent_color,
                                  width: 20,
                                  height: 20,
                                )),
                            Text(
                              'add another user',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: MyTheme.accent_color),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
            bottomNavigationBar: Container(
                margin: EdgeInsets.only(bottom: 10, left: 16, right: 16),
                height: 46,
                child: TextButton(
                  onPressed: isValid()
                      ? () {
                          _onPressedSplitCashback();
                        }
                      : null,
                  style: TextButton.styleFrom(
                    // primary: Colors.white,
                    backgroundColor: isValid()
                        ? MyTheme.accent_color
                        : MyTheme.accent_color_shadow,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: Text(S.of(context).continue_b,
                      style: TextStyle(
                        color: MyTheme.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      )),
                ))));
  }

  Widget _buildSplitModeTabs() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                  style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.horizontal(
                              start: Radius.circular(20))),
                      backgroundColor: activeSplitMode == 'equal'
                          ? MyTheme.accent_color
                          : MyTheme.grey_153),
                  onPressed: () {
                    _toggleSplitMode('equal');
                  },
                  child: Text(
                    'Equal',
                    style: TextStyle(
                        color: activeSplitMode == 'equal'
                            ? Colors.white
                            : MyTheme.light_grey),
                  )),
            ),
            Expanded(
                flex: 1,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.horizontal(
                                end: Radius.circular(20))),
                        backgroundColor: activeSplitMode == 'custom'
                            ? MyTheme.accent_color
                            : MyTheme.grey_153),
                    onPressed: () {
                      _toggleSplitMode('custom');
                    },
                    child: Text('Custom',
                        style: TextStyle(
                            color: activeSplitMode == 'custom'
                                ? Colors.white
                                : MyTheme.light_grey))))
          ],
        ));
  }

  Widget _buildContactsList() {
    return Container(
        child: Column(
            children: _contacts.map((contact) {
      return Column(
        children: [
          Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        contact['contact'].name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      contact['contact'].name != 'me'
                          ? TextButton(
                              onPressed: () {
                                _removeContact(contact['contact'].id);
                              },
                              child: Text(
                                'remove',
                                style: TextStyle(
                                    color: MyTheme.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ))
                          : Container(),
                    ],
                  ),
                  _buildCashbackAmountControl(
                      contact['contact'].id, contact['amount'])
                ],
              )),
          Divider(
            color: Colors.black,
          )
        ],
      );
    }).toList()));
  }

  Widget _buildCashbackAmountControl(int id, int amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Ink(
          width: 30,
          height: 30,
          decoration: ShapeDecoration(
            color: MyTheme.accent_color,
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                blurRadius: 10,
                spreadRadius: 0.0,
                offset:
                    const Offset(0.0, 6.0), // shadow direction: bottom right
              )
            ],
            shape: CircleBorder(
                side: BorderSide(
                    width: 0.1, color: Colors.black.withOpacity(.09))),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.add,
              size: 16,
            ),
            color: Colors.white,
            onPressed: () {
              _increaseQty(id);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(amount.toString()),
        ),

        Ink(
          width: 30,
          height: 30,
          decoration: ShapeDecoration(
            color: Colors.white,
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                blurRadius: 10,
                spreadRadius: 0.0,
                offset:
                    const Offset(0.0, 6.0), // shadow direction: bottom right
              )
            ],
            shape: CircleBorder(
                side: BorderSide(
                    width: 0.1, color: Colors.black.withOpacity(.09))),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.remove,
              size: 16,
            ),
            color: MyTheme.accent_color,
            onPressed: () {
              _reduceQty(id);
            },
          ),
        )

        // Icon(Icons)
      ],
    );
  }
}
