import 'package:coffee_time/models/cafe.dart';
import 'package:coffee_time/ui/shared/main_drawer.dart';
import 'package:coffee_time/ui/widgets/rating.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final Cafe cafe;
  const DetailScreen({Key key, this.cafe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cafe.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CarouselSlider(images: [
            cafe.mainPhotoUrl,
            cafe.mainPhotoUrl,
            cafe.mainPhotoUrl,
          ]),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                        'Otevřeno do ${cafe.closing.hour}:${cafe.closing.minute.toStringAsPrecision(2)}',
                        style: Theme.of(context).textTheme.overline.copyWith(
                            fontWeight: FontWeight.w300, fontSize: 14)),
                    Spacer(),
                    Rating.large(cafe.rating),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          SelectableText(
                            cafe.title,
                            style: Theme.of(context).textTheme.headline,
                          ),
                          SelectableText(
                            cafe.address,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.mapMarked),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.phone),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: InkWell(
                                  child: Text("775 028 016"),
                                  onTap: () async {
                                    if (await canLaunch("tel:775028016")) {
                                      await launch("tel:775028016");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.globe),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: InkWell(
                                  child: Text("www.cafe.prostoru.cz"),
                                  onTap: () async {
                                    if (await canLaunch(
                                        "https://cafe.prostoru.cz")) {
                                      print('launch web');
                                      await launch("https://cafe.prostoru.cz");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CarouselSlider extends StatefulWidget {
  final List<String> images;

  CarouselSlider({Key key, this.images})
      : assert(images != null),
        super(key: key);

  @override
  _CarouselSliderState createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  @override
  Widget build(BuildContext context) {
    final items = widget.images;
    final theme = Theme.of(context);
    return Container(
      height: 200,
      child: PageIndicatorContainer(
        length: items.length,
        child: PageView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            return Image.network(
              items[index],
              fit: BoxFit.cover,
            );
          },
        ),
        indicatorSelectorColor: theme.primaryColor,
      ),
    );
  }
}
