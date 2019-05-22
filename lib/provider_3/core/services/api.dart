import 'dart:convert';
import 'package:closr_prototype/provider_3/core/models/comment.dart';
import 'package:closr_prototype/provider_3/core/models/post.dart';
import 'package:closr_prototype/provider_3/core/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;


class Api {
  static const endpoint = 'https://jsonplaceholder.typicode.com';

  var client = new http.Client();

  FirebaseAuth _auth;
  FirebaseUser _user;

  Future<User> getUserProfile(int userId) async {
    // Get user profile for id
    var response = await client.get('$endpoint/users/$userId');

    // Convert and return
    print(response);
    return User.fromJson(json.decode(response.body));
  }

  Future<FirebaseUser> signInWithCredentials(String email, String password) async {
    FirebaseUser user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password
    );
    return user;
  }


  Future<List<Post>> getPostsForUser(int userId) async {
    var posts = List<Post>();
    var response = await client.get('$endpoint/posts?userId=$userId');
    var parsed = json.decode(response.body) as List<dynamic>;

    for (var post in parsed) {
      posts.add(Post.fromJson(post));
    }
    return posts;
  }

  Future<List<Comment>> getCommentsForPost(int postId) async {
    var comments = List<Comment>();

    var response = await client.get('$endpoint/comments?postId=$postId');

    var parsed = json.decode(response.body) as List<dynamic>;

    for (var comment in parsed) {
      comments.add(Comment.fromJson(comment));
    }
    return comments;
  }


}