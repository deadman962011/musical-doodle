import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/responses/user/offer/user_offer_details_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_favorite_offers_repository.dart';
import 'package:com.mybill.app/repositories/user/user_offers_repository.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:toast/toast.dart';

class OfferDetails extends StatefulWidget {
  final int offerId;

  const OfferDetails({super.key, required this.offerId});

  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;
  OfferDetailsItem? _offer;

  @override
  void initState() {
    super.initState();
    fetchOffer();
  }

  fetchOffer() async {
    setState(() {
      isLoading = true;
    });

    var response = await UserOfferRepository()
        .getUserOfferDetailsResponse(id: widget.offerId);
    if (response.runtimeType.toString() == 'UserOfferDetailsResponse') {
      _offer = response.payload;
    }

    setState(() {
      isLoading = false;
    });
  }

  onFavoritePressed(context) async {
    debugPrint('asasxas');
    await UserFavoriteOfferRepository()
        .toggleUserFavoriteOffersResponse(offerId: _offer!.id)
        .then((value) {
      if (value.runtimeType.toString() == 'bool' && value) {
        if (_offer!.isFavorite) {
          ToastComponent.showDialog(
              'offer removed from favorite successfully', context,
              gravity: Toast.bottom, duration: Toast.lengthLong);
        } else {
          ToastComponent.showDialog(
              'offer added to favorite successfully', context,
              gravity: Toast.bottom, duration: Toast.lengthLong);
        }

        setState(() {
          _offer?.isFavorite = !_offer!.isFavorite;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: UserAppBar.buildUserAppBar(
              context, 'offer_details', _offer?.name ?? '', {
            'addToFavorite': () => onFavoritePressed(context),
            'isFavorite': _offer?.isFavorite ?? false
          }),
          body: isLoading
              ? Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      ShimmerHelper().buildBasicShimmer(height: 360),
                      ShimmerHelper().buildBasicShimmer(height: 40),
                      ShimmerHelper().buildBasicShimmer(height: 40),
                      ShimmerHelper().buildBasicShimmer(height: 40),
                      ShimmerHelper().buildBasicShimmer(height: 40),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(children: [
                        _buildOfferCard(),
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/menu.png',
                                      color: MyTheme.accent_color,
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 18),
                                        child: Text(
                                          'Menu',
                                          style: TextStyle(fontSize: 16),
                                        ))
                                  ],
                                )),
                            ExpansionTile(
                              title: const Text('Working hours'),
                              controlAffinity: ListTileControlAffinity.leading,
                              leading: Image.asset(
                                'assets/clock.png',
                                color: MyTheme.accent_color,
                              ),
                              children: _offer != null
                                  ? _offer!.shop.availability.map((item) {
                                      if (item.status == 1) {
                                        return Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(item.day),
                                                Column(
                                                  children:
                                                      item.slots.map((slot) {
                                                    return Row(
                                                      children: [
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 6),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    6),
                                                            decoration: BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                        width:
                                                                            0.3),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            3))),
                                                            child: Text(
                                                              '${intl.DateFormat('HH:MM a').format(slot.start)} - ${intl.DateFormat('HH:MM a').format(slot.end)}',
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                            ))
                                                      ],
                                                    );
                                                  }).toList(),
                                                )
                                              ],
                                            ),
                                            Divider(
                                              thickness: 0.2,
                                              color: Colors.grey,
                                            )
                                          ],
                                        );
                                      } else {
                                        return Row();
                                      }
                                    }).toList()
                                  : [Text('')],
                            ),
                            ExpansionTile(
                                title: const Text('Contact Informations'),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                leading: Image.asset(
                                  'assets/clock.png',
                                  color: MyTheme.accent_color,
                                ),
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 26),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .only(end: 12),
                                                      child: Icon(
                                                        Icons.phone,
                                                        color: MyTheme
                                                            .accent_color,
                                                      )),
                                                  Text('phone number')
                                                ],
                                              ),
                                              Text(
                                                  _offer!.shop.shopContactPhone)
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                          height: 0.3,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .only(end: 12),
                                                      child: Icon(
                                                        Icons.email,
                                                        color: MyTheme
                                                            .accent_color,
                                                      )),
                                                  Text('Email')
                                                ],
                                              ),
                                              Text(
                                                  _offer!.shop.shopContactEmail)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                            ExpansionTile(
                              title: const Text('Ratings'),
                              controlAffinity: ListTileControlAffinity.leading,
                              leading: Image.asset(
                                'assets/star.png',
                                color: MyTheme.accent_color,
                              ),
                              children: const <Widget>[
                                ListTile(title: Text('This is tile number 1')),
                              ],
                            ),
                          ],
                        ),
                      ])))),
    );
  }

  Widget _buildOfferCard() {
    return Container(
      height: 232,
      margin: const EdgeInsets.only(bottom: 20, left: 2, right: 2),
      decoration: BoxDecoration(
        // border: Border.all(width: 0.1),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
        //  BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 6,
            spreadRadius: 0.0,
            offset: const Offset(0.0, 0.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              child: Image.network(
                // width: 376,
                // height: 260,
                _offer!.image,
                // color: Colors.red,
              )),
          Container(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  spreadRadius: 0.0,
                  offset:
                      const Offset(0.0, -3.0), // shadow direction: bottom right
                )
              ],
            ),
            child: Directionality(
              textDirection:
                  app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                            color: MyTheme.accent_color,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50))),
                        child: Text(
                          '${_offer!.cashbackAmount}%',
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(_offer!.name,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Text('Offer ends at ${_offer!.endDate.toString()}')
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          PositionedDirectional(
            top: 0,
            end: 10,
            child: Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                Image.asset(width: 86, height: 86, 'assets/calander.png'),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsetsDirectional.only(end: 6),
                          child: Text(
                            _offer!.days_left.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).days,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            S.of(context).left,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

    // return Container(
    //   margin: const EdgeInsets.only(bottom: 20),
    //   decoration: BoxDecorations.buildBoxDecoration(radius: 8),
    //   child: Stack(
    //     alignment: Alignment.bottomCenter,
    //     children: [
    //       ClipRRect(
    //           borderRadius: BorderRadius.circular(8),
    //           child: _offer?.image != null
    //               ? Image.network(
    //                   _offer!.image,
    //                 )
    //               : Image.asset(
    //                   'assets/dummy_376x238.png',
    //                 )),
    //       Container(
    //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: const BorderRadius.all(Radius.circular(8)),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.black.withOpacity(.08),
    //               blurRadius: 20,
    //               spreadRadius: 0.0,
    //               offset:
    //                   const Offset(0.0, -6.0), // shadow direction: bottom right
    //             )
    //           ],
    //         ),
    //         child: const Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text('offer ends at 23/10/2043'),
    //           ],
    //         ),
    //       ),
    //       PositionedDirectional(
    //         top: 12,
    //         start: 12,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             GestureDetector(
    //                 onTap: () {},
    //                 child: Container(
    //                     padding: const EdgeInsets.all(10),
    //                     decoration: BoxDecoration(
    //                         color: MyTheme.accent_color,
    //                         borderRadius:
    //                             const BorderRadius.all(Radius.circular(50))),
    //                     child: Column(
    //                       children: [
    //                         Image.asset('assets/share.png'),
    //                         const Text(
    //                           'share',
    //                           style: TextStyle(color: Colors.white),
    //                         )
    //                       ],
    //                     ))),
    //           ],
    //         ),
    //       ),
    //       PositionedDirectional(
    //           end: 12,
    //           bottom: 20,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Container(
    //                 padding: const EdgeInsets.all(7.0),
    //                 decoration: const BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius: BorderRadius.all(Radius.circular(50))),
    //                 child: Container(
    //                   margin: const EdgeInsets.only(bottom: 0),
    //                   padding: const EdgeInsets.all(14),
    //                   decoration: BoxDecoration(
    //                       color: MyTheme.accent_color,
    //                       borderRadius:
    //                           const BorderRadius.all(Radius.circular(50))),
    //                   child: const Column(
    //                     children: [
    //                       Text(
    //                         '09%',
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                       Text(
    //                         'كاش باك',
    //                         style: TextStyle(color: Colors.white),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ))
    //     ],
    //   ),
    // );
  }
}
