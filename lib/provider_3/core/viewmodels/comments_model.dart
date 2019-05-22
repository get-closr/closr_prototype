import 'package:closr_prototype/provider_3/core/enum/viewstate.dart';
import 'package:closr_prototype/provider_3/core/models/comment.dart';
import 'package:closr_prototype/provider_3/core/services/api.dart';

import '../../locator.dart';
import 'base_model.dart';

class CommentsModel extends BaseModel {
  Api _api = locator<Api>();

  List<Comment> comments;

  Future fetchComments(int postId) async {
    setState(ViewState.Busy);
    comments = await _api.getCommentsForPost(postId);
    setState(ViewState.Idle);
  }
}