import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/responses/user/split_cashback/user_split_cashback_registered_contacts_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_split_cashback_repository.dart';
import 'package:com.mybill.app/screens/user/split_reward_set_values.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class SplitRewardSelectContacts extends StatefulWidget {
  int offer_id;
  int cashback_amount;

  SplitRewardSelectContacts(
      {Key? key, required this.offer_id, required this.cashback_amount})
      : super(key: key);

  @override
  _SplitRewardSekectContactsState createState() =>
      _SplitRewardSekectContactsState();
}

class _SplitRewardSekectContactsState extends State<SplitRewardSelectContacts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> importedContacts = [
    RegisteredContact(
        id: int.parse(user_id.$),
        name: 'me',
        phone: user_phone.$,
        isSelected: true)
  ];

  List<Map<String, dynamic>> selectedContacts = [
    {
      'id': 0,
      'name': 'Me',
      'phone': user_phone,
      'isSelected': true,
      'index': int.parse(user_id.$)
    },
  ];

  @override
  void initState() {
    super.initState();
    _importContacts();
  }

  Future<void> _importContacts() async {
    if (await Permission.contacts.request().isGranted) {
      Iterable<Contact> contacts = await ContactsService.getContacts();

      const int batchSize = 30;
      int batchCount = (contacts.length / batchSize).ceil();
      for (int i = 0; i < batchCount; i++) {
        var start = i * batchSize;
        var end = (i + 1) * batchSize > contacts.length
            ? contacts.length
            : (i + 1) * batchSize;

        List<String> batchPhoneNumbers = [];
        for (Contact contact in contacts.skip(start).take(end - start)) {
          if (contact.phones != null && contact.phones!.isNotEmpty) {
            for (Item phone in contact.phones!) {
              if (user_phone.$ != phone.value) {
                batchPhoneNumbers.add(phone.value!);
              }
            }
          }
        }

        var fetched_contacts = await _fetchContacts(batchPhoneNumbers);
        debugPrint('new batch ${fetched_contacts.toString()}');
        setState(() {
          importedContacts.addAll(fetched_contacts);
        });
      }
    }
  }

  Future<List<dynamic>> _fetchContacts(List<String> phoneNumbers) async {
    var response = await UserSplitCashbackRepository()
        .getUserSplitCashbackRegisteredContactsResponse(phoneNumbers);
    debugPrint(response.runtimeType.toString());
    if (response.runtimeType.toString() ==
        'UserSplitCashbackRegisteredContactsResponse') {
      UserSplitCashbackRegisteredContactsResponse data = response;
      return data.payload;
    } else {
      return [];
    }
  }

  _toggleContact(int id) {
    debugPrint(id.toString());
    var contact = importedContacts[id];
    if (contact.isSelected) {
      selectedContacts.removeWhere((element) => element['id'] == contact.id);
    } else {
      selectedContacts.add({
        'id': contact.id,
        'name': contact.name,
        'phone': contact.phone,
        'index': id
      });
    }

    setState(() {
      importedContacts[id].isSelected = !contact.isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: UserAppBar.buildUserAppBar(
                context,
                'split_reward_select_contacts',
                'split_reward_select_contacts ', {}),
            body: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  Text(widget.cashback_amount.toString()),
                  _buildSelectedContactsList(),
                  _buildContactSearch(),
                  _buildContactsList()
                ],
              ),
            ),
            bottomNavigationBar: Container(
                margin: EdgeInsets.only(bottom: 10, left: 16, right: 16),
                height: 120,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 10),
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return SplitRewardSetValues(
                          //     offer_id: widget.offer_id,
                          //     cashback_amount: widget.cashback_amount,
                          //     selected_contacts: importedContacts,
                          //   );
                          // }));

                          // onPressedSendPayUpgradenReq();
                        },
                        style: TextButton.styleFrom(
                          // primary: Colors.white,
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                        child: Text('Add contacts to group',
                            style: TextStyle(
                              color: MyTheme.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SplitRewardSetValues(
                                offer_id: widget.offer_id,
                                cashback_amount: widget.cashback_amount,
                                selected_contacts: importedContacts,
                              );
                            }));

                            // onPressedSendPayUpgradenReq();
                          },
                          style: TextButton.styleFrom(
                            // primary: Colors.white,
                            backgroundColor: MyTheme.accent_color,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          child: Text(S.of(context).continue_b,
                              style: TextStyle(
                                color: MyTheme.white,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              )),
                        ))
                  ],
                ))));
  }

  Widget _buildSelectedContactsList() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 24),
        child: Row(
            children: selectedContacts.map((entry) {
          return _buildSelectedContactItem(entry);
        }).toList()));
  }

  Widget _buildSelectedContactItem(selected_contact_item) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        // width: 74,
        child: Column(
          children: [
            Stack(alignment: Alignment.topLeft, children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                child: Text(
                  "${selected_contact_item['name'][0].toUpperCase()}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 24),
                ),
              ),
              selected_contact_item['name'] == 'Me'
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        _toggleContact(selected_contact_item['index']);
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 14.0,
                          backgroundColor: MyTheme.accent_color,
                          child: Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                    )
            ]),
            Text(selected_contact_item['name'])
          ],
        ));
  }

  Widget _buildContactSearch() {
    return Container(
      child: TextField(),
    );
  }

  Widget _buildContactsList() {
    return Expanded(
        child: ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: importedContacts.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(importedContacts[index].name),
                Checkbox(
                  tristate: true,
                  onChanged: importedContacts[index].id == int.parse(user_id.$)
                      ? null
                      : (val) {
                          _toggleContact(index);
                        },
                  value: importedContacts[index].id == int.parse(user_id.$)
                      ? true
                      : importedContacts[index].isSelected,
                )
              ],
            )

            //  Center(child: Text('Entry ${importedContacts[index].id}')),
            );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.black,
      ),
    ));
  }
}
