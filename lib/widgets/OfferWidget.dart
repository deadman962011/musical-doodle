import 'package:csh_app/custom/box_decorations.dart';
import 'package:csh_app/models/items/Offer.dart';
import 'package:csh_app/models/responses/merchant/offer/merchant_offers_response.dart';
import 'package:csh_app/my_theme.dart';
import 'package:csh_app/repositories/user/user_favorite_offers_repository.dart';
import 'package:csh_app/repositories/user/user_offers_repository.dart';
import 'package:csh_app/screens/user/offer_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

class OfferWidget extends StatefulWidget {
  final Offer offer;
  final Function(int) onToggleFavorite;
  const OfferWidget({
    Key? key,
    required this.offer,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  _OfferWidgetState createState() => _OfferWidgetState();
}

class _OfferWidgetState extends State<OfferWidget> {
  onFavoritePressed() async {
    // if()
    await UserFavoriteOfferRepository()
        .toggleUserFavoriteOffersResponse(offerId: widget.offer.id)
        .then((value) {
      if (value.runtimeType.toString() == 'bool' && value) {
        widget.onToggleFavorite(widget.offer.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          // border: Border.all(width: 0.1),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 0.0), // shadow direction: bottom right
            )
          ],
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  width: 376,
                  height: 238,
                  widget.offer.thumbnail,
                  // color: Colors.red,
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 7,
                    spreadRadius: 0.0,
                    offset: Offset(0.0, -3.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.place,
                          color: MyTheme.accent_color,
                          size: 14,
                        ),
                        Text(
                          '40 Km',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(widget.offer.name),
                  ),
                  Flexible(flex: 1, child: Container())
                ],
              ),
            ),
            PositionedDirectional(
              top: 12,
              start: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.06),
                              blurRadius: 6,
                              spreadRadius: 4.0,
                              offset: Offset(
                                  0.0, 0.0), // shadow direction: bottom right
                            )
                          ],
                          color: widget.offer.isFavorite
                              ? MyTheme.accent_color
                              : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: IconButton(
                          onPressed: () {
                            onFavoritePressed();
                          },
                          icon: Icon(
                            widget.offer.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border_rounded,
                            color: widget.offer.isFavorite
                                ? Colors.white
                                : MyTheme.accent_color,
                            size: 26,
                          )))
                ],
              ),
            ),
            PositionedDirectional(
                end: 12,
                bottom: 8,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Column(
                          children: [
                            Text(
                              '${widget.offer.cashback_amount}%',
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
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemSize: 12,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    )
                  ],
                ))
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
