import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) throw UnsupportedError('Web not supported');
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError('Unsupported platform');
    }
  }

  // ─── FROM google-services.json ───────────────────────────
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXaDjoQqdVrl8Zs8nW1TWdqmPyvKbZgzM',
    appId: '1:1054726484508:android:1234567890abcdef',
    messagingSenderId: '1054726484508',
    projectId: 'hills-book-store',
    storageBucket: 'hills-book-store.appspot.com',
  );

  // ─── FROM GoogleService-Info.plist ───────────────────────
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0h3V0rscwfFJluIyWZcQV27rw-AS-m24',
    appId: '1:1054726484508:ios:1234567890abcdef',
    messagingSenderId: '1054726484508',
    projectId: 'hills-book-store',
    storageBucket: 'hills-book-store.appspot.com',
    iosClientId: 'PASTE_CLIENT_ID_HERE',
    iosBundleId: 'com.hills.bookstore',
  );
}
