import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/items/Offer.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_favorite_offers_repository.dart';
import 'package:com.mybill.app/screens/user/offer_details.dart';
import 'package:flutter/material.dart';

import 'package:com.mybill.app/generated/l10n.dart';
import 'package:toast/toast.dart';

class OfferWidget extends StatefulWidget {
  final Offer offer;
  final Function(int) onToggleFavorite;
  const OfferWidget({
    super.key,
    required this.offer,
    required this.onToggleFavorite,
  });

  @override
  _OfferWidgetState createState() => _OfferWidgetState();
}

class _OfferWidgetState extends State<OfferWidget> {
  onFavoritePressed() async {
    debugPrint('preeeed');
    await UserFavoriteOfferRepository()
        .toggleUserFavoriteOffersResponse(offerId: widget.offer.id)
        .then((value) {
      if (value.runtimeType.toString() == 'bool' && value) {
        if (widget.offer.isFavorite) {
          ToastComponent.showDialog(
              'offer removed from favorite successfully', context,
              gravity: Toast.bottom, duration: Toast.lengthLong);
        } else {
          ToastComponent.showDialog(
              'offer added to favorite successfully', context,
              gravity: Toast.bottom, duration: Toast.lengthLong);
        }

        widget.onToggleFavorite(widget.offer.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
                  widget.offer.thumbnail,
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
                    offset: const Offset(
                        0.0, -3.0), // shadow direction: bottom right
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
                            '${widget.offer.cashback_amount}%',
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(widget.offer.shop['name'],
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${widget.offer.shop['distance']} ${S.of(context).km}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.place,
                          color: MyTheme.accent_color,
                          size: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            widget.offer.state == 'active'
                ? PositionedDirectional(
                    top: 0,
                    end: 10,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Image.asset(
                            width: 86, height: 86, 'assets/calander.png'),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 8, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsetsDirectional.only(end: 6),
                                  child: Text(
                                    widget.offer.days_left.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26),
                                  )),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).days,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    S.of(context).left,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : PositionedDirectional(
                    top: 0,
                    end: 10,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Image.asset(
                          width: 86,
                          height: 86,
                          'assets/calander_grey.png',
                        ),
                        Padding(
                            padding: const EdgeInsetsDirectional.only(top: 20),
                            child: Text(
                              S.of(context).expired,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ))
                      ],
                    ),
                  ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OfferDetails(
            offerId: widget.offer.id,
          );
        }));
      },
    );
  }
}
