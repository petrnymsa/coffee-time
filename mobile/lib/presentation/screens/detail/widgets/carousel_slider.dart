import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

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
