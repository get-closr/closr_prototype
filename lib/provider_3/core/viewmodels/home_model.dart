import 'package:closr_prototype/provider_3/core/enum/viewstate.dart';
import 'package:closr_prototype/provider_3/core/models/post.dart';
import 'package:closr_prototype/provider_3/core/services/api.dart';
import 'package:closr_prototype/provider_3/locator.dart';

import 'base_model.dart';

class HomeModel extends BaseModel {
  Api _api = locator<Api>();

  List<Post> posts;

  Future getPosts(int userId) async {
    setState(ViewState.Busy);
    posts = await _api.getPostsForUser(userId);
    setState(ViewState.Idle);
  }
}