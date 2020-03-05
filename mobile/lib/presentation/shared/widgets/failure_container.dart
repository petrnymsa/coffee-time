import 'package:coffee_time/presentation/core/blocs/cafe_list/bloc.dart';
import 'package:coffee_time/presentation/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FailureContainer extends StatelessWidget {
  final String message;
  final Function onRefresh;

  const FailureContainer({
    Key key,
    @required this.message,
    @required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FailureMessage(
            message: message,
          ),
          Divider(indent: 60, endIndent: 60),
          if (onRefresh != null)
            FlatButton.icon(
              onPressed: onRefresh,
              icon: Icon(
                FontAwesomeIcons.redo,
                size: 20,
              ),
              label: Text('Obnovit'),
            ),
        ],
      ),
    );
  }
}
