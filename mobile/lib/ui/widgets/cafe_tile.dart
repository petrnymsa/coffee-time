import 'dart:ui';

import 'package:coffee_time/models/cafe.dart';
import 'package:coffee_time/ui/widgets/rating.dart';
import 'package:coffee_time/ui/widgets/tag.dart';
import 'package:flutter/material.dart';

//TODO text styles
//TODO color styles

class CafeTile extends StatelessWidget {
  final Function onTap;
  final Function onFavoriteTap;
  final Function onMapTap;

  final Cafe _cafe;

  CafeTile({Key key, Cafe cafe, this.onTap, this.onFavoriteTap, this.onMapTap})
      : _cafe = cafe,
        super(key: key);

  void _onTileTap() {
    print('tile click');
    if (onTap != null) onTap();
  }

  void _onFavoriteTap() {
    if (onFavoriteTap != null) onFavoriteTap();
  }

  void _onMapTap() {
    if (onMapTap != null) onMapTap();
  }

  @override
  Widget build(BuildContext context) {
    const tileHeight = 216.0;
    const imageHegiht = 120.0;
    const radius = 8.0;
    const borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );

    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
      ),
      child: GestureDetector(
        onTap: _onTileTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Container(
            height: tileHeight,
            child: Card(
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius,
              ),
              child: Stack(
                children: [
                  Container(
                    height: imageHegiht,
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: borderRadius,
                          child: Image.network(
                            _cafe.mainPhotoUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 4.0),
                            color: Colors.black87,
                            child: Text(
                              _cafe.title,
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Amatic',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.only(left: 2.0, bottom: 2.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(radius),
                          topRight: Radius.circular(radius),
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.favorite),
                        onPressed: _onFavoriteTap,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.only(left: 2.0, bottom: 2.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(radius),
                          topLeft: Radius.circular(radius),
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.map),
                        onPressed: _onMapTap,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: tileHeight - imageHegiht - 8,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                _cafe.address,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                              Spacer(),
                              Rating(_cafe.rating),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Row(
                              children: <Widget>[
                                _buildDistance(context),
                                Spacer(),
                                _buildClosing(context),
                              ],
                            ),
                          ),
                          _buildTags(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text _buildClosing(BuildContext context) {
    return Text(
      'Zavírá ve ${_cafe.closing.hour}:${_cafe.closing.minute}',
      style: TextStyle(
          color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w300),
    );
  }

  Text _buildDistance(BuildContext context) {
    return Text(
      'Vzdálené ${_cafe.distance} m',
      style: TextStyle(
          color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w300),
    );
  }

  Widget _buildTags() {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, top: 8.0),
      child: Row(
        children: _cafe.tags
            .map((t) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Tag(t.title, icon: t.icon, color: t.color),
                ))
            .toList(),
      ),
    );
  }
}
