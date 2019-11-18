import 'package:coffee_time/domain/entities/comment.dart';
import 'package:coffee_time/presentation/widgets/rating.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CommentTile extends StatelessWidget {
  final CommentEntity comment;

  const CommentTile({
    Key key,
    @required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(FontAwesomeIcons.solidUser),
          backgroundColor: Theme.of(context).accentColor,
          foregroundColor: Colors.white,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  comment.user,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Rating.small(
                  comment.rating,
                  displayRating: false,
                ),
              ],
            ),
            Text(
              DateFormat.yMMMd().format(comment.posted),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            comment.content,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
