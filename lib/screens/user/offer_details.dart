import 'package:csh_app/custom/box_decorations.dart';
import 'package:csh_app/custom/toast_component.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:csh_app/models/items/Offer.dart';
import 'package:csh_app/my_theme.dart';
import 'package:csh_app/repositories/user/user_favorite_offers_repository.dart';
import 'package:csh_app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toast/toast.dart';

class OfferDetails extends StatefulWidget {
  final int offerId;

  const OfferDetails({Key? key, required this.offerId}) : super(key: key);

  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late bool isLoading = true;
  bool _customTileExpanded = false;
  var _offer = Offer(
      id: 1,
      commission: 0,
      end_date: '12',
      name: 'asdasd',
      sales: 0,
      cashback_amount: 9,
      start_date: '12',
      state: 'active',
      isFavorite: false,
      thumbnail:
          'http://192.168.43.103:8000/uploads/all/X9REONCvtAIL2BlojDsZL8Sneg0pK64gdyqWfse2.png',
      days_left: 12,
      shop: Map());

  fetchOffer() async {
    _offer = Offer(
        id: 1,
        commission: 0,
        end_date: '12',
        name: 'asdasd',
        sales: 0,
        cashback_amount: 4,
        start_date: '12',
        state: 'active',
        isFavorite: false,
        thumbnail:
            'http://192.168.43.103:8000/uploads/all/X9REONCvtAIL2BlojDsZL8Sneg0pK64gdyqWfse2.png',
        days_left: 12,
        shop: Map());
  }

  onFavoritePressed(context) async {
    debugPrint('asasxas');
    await UserFavoriteOfferRepository()
        .toggleUserFavoriteOffersResponse(offerId: _offer.id)
        .then((value) {
      if (value.runtimeType.toString() == 'bool' && value) {
        if (_offer.isFavorite) {
          ToastComponent.showDialog(
              'offer removed from favorite successfully', context,
              gravity: Toast.bottom, duration: Toast.lengthLong);
        } else {
          ToastComponent.showDialog(
              'offer added to favorite successfully', context,
              gravity: Toast.bottom, duration: Toast.lengthLong);
        }

        setState(() {
          _offer.isFavorite = !_offer.isFavorite;
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
              context, 'offer_details', _offer.name, {
            'addToFavorite': () => onFavoritePressed(context),
            'isFavorite': _offer.isFavorite
          }),
          body: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Column(children: [
                    _buildOfferCard(),
                    // OfferWidget(
                    //   offer: _offer,
                    // ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'مرحبا بكم في مطعمنا أطباقنا الشهية الأكثر مبيعاً هي برغر ميتو , كيتو , جيم باي , على الرغم من أن لدينا مجموعة متنوعة من الأطباق والوجبات اللذيذة للغداء والعشاءمرحبا بكم في مطعمنا أطباقنا الشهية الأكثر مبيعاً هي برغر ميتو , كيتو , جيم باي , على الرغم من أن لدينا مجموعة متنوعة من الأطباق والوجبات اللذيذة للغداء والعشاء',
                          textAlign: TextAlign.center,
                        )),
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/menu.png',
                                  color: MyTheme.accent_color,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: Text(
                                      'Menu',
                                      style: TextStyle(fontSize: 16),
                                    ))
                              ],
                            )),
                        ExpansionTile(
                          title: Text('Working hours'),
                          controlAffinity: ListTileControlAffinity.leading,
                          leading: Image.asset(
                            'assets/clock.png',
                            color: MyTheme.accent_color,
                          ),
                          children: <Widget>[
                            ListTile(title: Text('This is tile number 1')),
                          ],
                        ),
                        ExpansionTile(
                          title: Text('Ratings'),
                          controlAffinity: ListTileControlAffinity.leading,
                          leading: Image.asset(
                            'assets/star.png',
                            color: MyTheme.accent_color,
                          ),
                          children: <Widget>[
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
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecorations.buildBoxDecoration(radius: 8),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/dummy_376x238.png',
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.08),
                  blurRadius: 20,
                  spreadRadius: 0.0,
                  offset: Offset(0.0, -6.0), // shadow direction: bottom right
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('offer ends at 23/10/2043'),
              ],
            ),
          ),
          PositionedDirectional(
            top: 12,
            start: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: MyTheme.accent_color,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Column(
                          children: [
                            Image.asset('assets/share.png'),
                            Text(
                              'share',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ))),
              ],
            ),
          ),
          PositionedDirectional(
              end: 12,
              bottom: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(7.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 0),
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: MyTheme.accent_color,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Column(
                        children: [
                          Text(
                            '09%',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'كاش باك',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
