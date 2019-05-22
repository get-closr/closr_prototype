import 'package:closr_prototype/provider_3/core/enum/viewstate.dart';
import 'package:closr_prototype/provider_3/core/models/comment.dart';
import 'package:closr_prototype/provider_3/core/viewmodels/comments_model.dart';
import 'package:closr_prototype/provider_3/ui/shared/app_colors.dart';
import 'package:closr_prototype/provider_3/ui/shared/ui_helpers.dart';
import 'package:closr_prototype/provider_3/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  final int postId;
  Comments(int id, {this.postId});

  @override
  Widget build(BuildContext context) {
    return BaseView<CommentsModel>(
        onModelReady: (model) => model.fetchComments(postId),
        builder: (context, model, child) => model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Expanded(
                child: ListView(
                  children: model.comments
                      .map((comment) => CommentItem(comment))
                      .toList(),
                ),
              ));
  }
}

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: commentColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            comment.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          UIHelper.verticalSpaceSmall(),
          Text(comment.body),
        ],
      ),
    );
    ;
  }
}
