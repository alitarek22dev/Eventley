import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD2ef4ExvNeAs4_YM4PHIZqpGXuqw_8FvI',
    appId: '1:568766882972:web:ef6f6f0620a0d658d43959',
    messagingSenderId: '568766882972',
    projectId: 'eventley-7d26b',
    authDomain: 'eventley-7d26b.firebaseapp.com',
    storageBucket: 'eventley-7d26b.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHGSpzzOYCiEZZ1zYOBOX7e-9n04zT9U4',
    appId: '1:568766882972:android:5be10ee1a909774fd43959',
    messagingSenderId: '568766882972',
    projectId: 'eventley-7d26b',
    storageBucket: 'eventley-7d26b.firebasestorage.app',
  );
}
