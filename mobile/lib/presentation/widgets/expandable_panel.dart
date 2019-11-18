import 'package:flutter/material.dart';

class ExpandablePanel extends StatefulWidget {
  final Widget header;
  final Widget body;
  final bool expanded;
  ExpandablePanel({Key key, this.header, this.body, this.expanded = false})
      : assert(header != null, body != null),
        super(key: key);

  @override
  _ExpandablePanelState createState() => _ExpandablePanelState();
}

class _ExpandablePanelState extends State<ExpandablePanel>
    with SingleTickerProviderStateMixin {
  bool _expanded;

  @override
  void initState() {
    _expanded = widget.expanded;
    super.initState();
  }

  void _changeExpansion() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: AnimatedSize(
        alignment: Alignment.topLeft,
        vsync: this,
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 300),
        child: Column(
          children: [
            GestureDetector(
              onTap: _changeExpansion,
              child: Row(
                children: <Widget>[
                  widget.header,
                  Spacer(),
                  IconButton(
                    splashColor: Colors.transparent,
                    icon: Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                    onPressed: _changeExpansion,
                  ),
                ],
              ),
            ),
            if (_expanded)
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: widget.body,
              )
          ],
        ),
      ),
    );
  }
}
