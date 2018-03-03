import 'dart:async';

import 'package:angular/core.dart';
import 'package:firebase/firebase.dart';

import 'utils.dart';

DatabaseReference ref;
Map<int, dynamic> stories = {};
Map<String, dynamic> users = {};

/// Mock service emulating access to a to-do list stored on a server.
@Injectable()
class HNService {
  HNService() {
    if (ref == null) {
      initializeApp(databaseURL: 'https://hacker-news.firebaseio.com');
      ref = database().ref('/v0');
    }
  }

  Future<List<int>> fetchList(String tag) async {
    var _query = await ref.child(DB_MAP[tag]).once('value');
    return _query.snapshot.val();
  }

  Future<Map<String, dynamic>> fetchItem(int id) async {
    if (stories[id] == null) {
      var _query = await ref.child('item/$id').once('value');
      stories[id] = _query.snapshot.val();
    }
    return stories[id];
  }

  Future<Map<String, dynamic>> fetchUser(String id) async {
    if (users[id] == null) {
      var _query = await ref.child('user/$id').once('value');
      users[id] = _query.snapshot.val();
    }
    return users[id];
  }
}
