import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/helpers/file_helper.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/responses/merchant/merchant_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_repository.dart';
import 'package:com.mybill.app/screens/full_screen_image_view.dart';
import 'package:com.mybill.app/screens/merchant/profile/contact_informations.dart';
import 'package:com.mybill.app/screens/merchant/profile/edit.dart';
import 'package:com.mybill.app/screens/merchant/profile/working_hours.dart';
import 'package:com.mybill.app/ui_elements/merchant_appbar.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:com.mybill.app/generated/l10n.dart';
import 'package:toast/toast.dart';

class MerchantProfileEdit extends StatefulWidget {
  const MerchantProfileEdit({super.key});

  @override
  _MerchantProfileEditState createState() => _MerchantProfileEditState();
}

class _MerchantProfileEditState extends State<MerchantProfileEdit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ImagePicker _picker = ImagePicker();
  late XFile? _file;
  bool _isLoading = true;
  bool _isMenuUploading = false;
  MerchantDetails? merchantDetails;

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchAll() {
    fetchShop();
  }

  fetchShop() async {
    setState(() {
      _isLoading = true;
    });

    var response = await MerchantRepository().getMerchantResponse();
    if (response.runtimeType.toString() == 'MerchantResponse') {
      MerchantResponse data = response;
      merchantDetails = data.payload;
    }

    setState(() {
      _isLoading = false;
    });
  }

  handleUploadMenu(context) async {
    _file = await _picker.pickImage(source: ImageSource.gallery);
    if (_file != null) {
      setState(() {
        _isMenuUploading = true;
      });
      String base64Image = FileHelper.getBase64FormateFile(_file!.path);
      String fileName = _file!.path.split("/").last;

      var response = await MerchantRepository().getMerchantUpdateMenuResponse(
        base64Image,
        fileName,
      );

      if (response.runtimeType.toString() == 'MerchantUpdateMenuResponse') {
        if (response.success) {
          fetchAll();

          ToastComponent.showDialog(S.of(context).menu_updated, context,
              gravity: Toast.bottom, duration: Toast.lengthLong);
        }
      }
      setState(() {
        _isMenuUploading = false;
      });
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
                _scaffoldKey, S.of(context).profile_edit),
            drawer: MerchantDrawer.buildDrawer(context),
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: _isLoading
                  ? _buildLoaderWidget()
                  : Column(
                      children: [
                        _buildShopThumb(),
                        const Text('مطعم جميل'),
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
          height: 238,
          placeholder: 'assets/dummy_376x238.png',
          image: merchantDetails!.logo!,
        ),
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MerchantEdit();
            })).then((value) {
              setState(() {
                fetchAll();
              });
            });
            ;
          },
          icon: const Icon(Icons.edit),
          color: Colors.black,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
          padding: const EdgeInsets.all(6),
        )
      ],
    );
  }

  Widget _buildProfileEditMenu() {
    final Map<String, dynamic> mainProfilesData = {
      'tabs': [
        {
          'title': S.of(context).menu,
          'image': 'assets/menu_2.png',
          'action': 'menu',
          'action_title': merchantDetails!.menu == null
              ? S.of(context).add_menu
              : S.of(context).edit_menu
        },
        {
          'title': S.of(context).working_hours,
          'image': 'assets/clock.png',
          'action': 'working_hours',
          'action_title': S.of(context).edit
        },
        {
          'title': S.of(context).contact_informations,
          'image': 'assets/inf.png',
          'action': 'contact_informations',
          'action_title': S.of(context).edit
        },
        // {
        //   'title': S.of(context).rating,
        //   'image': 'assets/star.png',
        //   'action': 'rating',
        //   'action_title': S.of(context).edit
        // },
      ]
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: buildMenuSection(mainProfilesData),
    );
  }

  Widget buildMenuSection(data) {
    return Column(
      children: data['tabs'].map<Widget>((tab) {
        return Column(children: [
          const Divider(
            thickness: 0.2,
            height: 12,
            color: Colors.black,
          ),
          TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {},
              child: Column(children: [
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
                            style: const TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      tab['action'] == 'menu'
                          ? _isMenuUploading
                              ? Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      color: MyTheme.accent_color,
                                    ),
                                  ))
                              : Row(
                                  children: [
                                    TextButton(
                                        child: Text(
                                          tab['action_title'],
                                          style: TextStyle(
                                              color: MyTheme.accent_color),
                                        ),
                                        onPressed: () {
                                          handleUploadMenu(context);
                                        }),
                                    merchantDetails!.menu != null
                                        ? IconButton(
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              color: MyTheme.accent_color,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FullscreenImageView(
                                                          imageUrl:
                                                              merchantDetails!
                                                                  .menu!),
                                                ),
                                              );
                                            })
                                        : Container()
                                  ],
                                )
                          : tab['action'] == 'contact_informations'
                              ? TextButton(
                                  child: Text(
                                    tab['action_title'],
                                    style:
                                        TextStyle(color: MyTheme.accent_color),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const ContactInformations();
                                    }));
                                  })
                              : tab['action'] == 'working_hours'
                                  ? TextButton(
                                      child: Text(
                                        tab['action_title'],
                                        style: TextStyle(
                                            color: MyTheme.accent_color),
                                      ),
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const WorkingHours();
                                        }));
                                      })
                                  : Container()
                    ])
              ]))
        ]);
        // ['menu', 'working_hours', 'contact_informations']
        //         .contains(tab['action'])
        //         ?
        //         tab['action'] == 'menu' ?
        //             _isMenuUploading ?
        //             const Padding(
        //                 padding:
        //                     EdgeInsets.symmetric(horizontal: 12),
        //                 child: SizedBox(
        //                   width: 30,
        //                   height: 30,
        //                   child: CircularProgressIndicator(
        //                     color: Color.fromRGBO(84, 38, 222, 1),
        //                   ),
        //                 )) :
        //         Row(children: [
        //             TextButton(
        //               onPressed: () {
        //                 if (tab['action'] == 'menu') {
        //                   handleUploadMenu(context);
        //                 } else if (tab['action'] ==
        //                     'working_hours') {
        //                   Navigator.push(context,
        //                       MaterialPageRoute(builder: (context) {
        //                     return const WorkingHours();
        //                   }));
        //                 } else if (tab['action'] ==
        //                     'contact_informations') {
        //                   Navigator.push(context,
        //                       MaterialPageRoute(builder: (context) {
        //                     return const ContactInformations();
        //                   }));
        //                 }
        //               },
        //               child: Text(
        //                 tab['action_title'],
        //                 style:
        //                     TextStyle(color: MyTheme.accent_color),
        //               ),
        //             ),
        //               merchantDetails!.menu != null
        //                 ? IconButton(
        //                     icon: Icon(
        //                       Icons.remove_red_eye,
        //                       color: MyTheme.accent_color,
        //                     ),
        //                     onPressed: () {
        //                       Navigator.push(
        //                         context,
        //                         MaterialPageRoute(
        //                           builder: (context) =>
        //                               FullscreenImageView(
        //                                   imageUrl: merchantDetails!
        //                                       .menu!),
        //                         ),
        //                       );
        //                     })
        //                 : Container()
        //                     ],
        // ) : Container() : Container();]);

//
        // : Container()

        //  tab['action'] == 'contact_informations' ?

        // TextButton(
        //   onPressed: () {
        //     if (tab['action'] == 'menu') {
        //       handleUploadMenu(context);
        //     } else if (tab['action'] ==
        //         'working_hours') {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) {
        //         return const WorkingHours();
        //       }));
        //     } else if (tab['action'] ==
        //         'contact_informations') {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) {
        //         return const ContactInformations();
        //       }));
        //     }
        //   },
        //   child: Text(
        //     tab['action_title'],
        //     style:
        //         TextStyle(color: MyTheme.accent_color),
        //   ),
        // ),
        // tab['action'] == 'menu' &&

        // ],
        // ));
        // ],
        // );
      }).toList(),
    );
  }

  Widget _buildLoaderWidget() {
    return Column(
      children: [
        ShimmerHelper().buildBasicShimmer(height: 300),
        ShimmerHelper().buildBasicShimmer(height: 100),
        ShimmerHelper().buildBasicShimmer(height: 100),
      ],
    );
  }
}
