import 'package:uni_links/uni_links.dart';
import 'package:drift/drift.dart';
import 'database.dart';

class DeepLinkService {
  static const String _scheme = 'peernode';
  final AppDatabase _db;

  DeepLinkService(this._db);

  Future<void> init() async {
    // Handle links when app is already running
    uriLinkStream.listen((Uri? uri) {
      if (uri != null) _handleUri(uri);
    });

    // Handle link that launched the app (cold start)
    try {
      final uri = await getInitialUri();
      if (uri != null) _handleUri(uri);
    } catch (_) {}
  }

  void _handleUri(Uri uri) {
    if (uri.scheme != _scheme) return;

    switch (uri.host) {
      case 'chat':
        final key = uri.queryParameters['key'];
        if (key != null) _addContact(key);
        break;
      case 'group':
        final id = uri.queryParameters['id'];
        final creatorKey = uri.queryParameters['key'];
        if (id != null && creatorKey != null) _addGroup(id, creatorKey);
        break;
    }
  }

  Future<void> _addContact(String publicKey) async {
    await _db.into(_db.contacts).insert(
      ContactsCompanion(
        id: Value(publicKey),
        name: Value('New Contact'),
        qrToken: Value(publicKey),
      ),
      onConflict: DoNothing(),
    );
  }

  Future<void> _addGroup(String groupId, String creatorKey) async {
    await _db.into(_db.groups).insert(
      GroupsCompanion(
        id: Value(groupId),
        title: Value('New Group'),
        groupQrToken: Value(groupId),
        membersList: Value('[\"$creatorKey\"]'),
      ),
      onConflict: DoNothing(),
    );
  }

  static String buildChatLink(String publicKey) => 'peernode://chat?key=$publicKey';
  static String buildGroupLink(String groupId, String creatorKey) =>
      'peernode://group?id=$groupId&key=$creatorKey';
}