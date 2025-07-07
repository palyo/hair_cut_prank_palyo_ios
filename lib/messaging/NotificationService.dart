import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // NB: prints in a background isolate appear in Xcode’s console.
  print(
    '[BG] 🔔 Received in background isolate: '
    '${jsonEncode(message.toMap())}',
  );
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _local = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  /* ------------------------------------------------------------------ */
  /* PUBLIC API                                                         */
  /* ------------------------------------------------------------------ */
  Future<void> initialize() async {
    print('[Init] 🚀 NotificationService starting …');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _requestPermissions();
    await setupFlutterNotifications();

    await _messaging.subscribeToTopic('all');
    print('[Init] ✅ Subscribed to topic “all”.');

    _initMessageHandlers();

    final tok = await _messaging.getToken();
    print('[Init] 🎫 FCM Token → $tok');
  }

  /* ------------------------------------------------------------------ */
  /* PRIVATE HELPERS                                                    */
  /* ------------------------------------------------------------------ */

  Future<void> _requestPermissions() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    print('[Perm] iOS auth status → ${settings.authorizationStatus}');
  }

  Future<void> setupFlutterNotifications() async {
    if (_initialized) {
      print('[Local] Already initialised; skipping.');
      return;
    }

    if (!Platform.isIOS) {
      print('[Local] Not iOS – local‑notification setup skipped.');
      return;
    }

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(iOS: iosSettings);

    await _local.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );

    _initialized = true;
    print('[Local] 🎉 flutter_local_notifications ready.');
  }

  void _initMessageHandlers() {
    print('[Init] 📨 Installing foreground / tap handlers …');

    FirebaseMessaging.onMessage.listen((msg) {
      print('[FG] 🔔 Foreground message → ${jsonEncode(msg.toMap())}');
      showNotification(msg);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      print(
        '[Tap] 📲 Notification tapped (background) → '
        '${jsonEncode(msg.toMap())}',
      );
      _handleNavigation(msg);
    });

    _messaging.getInitialMessage().then((msg) {
      if (msg != null) {
        print(
          '[Tap] 🚀 App launched via notification → '
          '${jsonEncode(msg.toMap())}',
        );
        _handleNavigation(msg);
      }
    });
  }

  Future<void> showNotification(RemoteMessage msg) async {
    final notif = msg.notification;
    if (notif == null) {
      print('[Show] ❌ No “notification” block; nothing to display.');
      return;
    }

    print(
      '[Show] Preparing to display local notification → '
      'title="${notif.title}", body="${notif.body}"',
    );

    if (!Platform.isIOS) {
      print('[Show] Skipped – only showing on iOS per requirement.');
      return;
    }

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const details = NotificationDetails(iOS: iosDetails);

    await _local.show(
      notif.hashCode,
      notif.title,
      notif.body,
      details,
      payload: msg.data['type'],
    );
    print('[Show] ✅ Local notification dispatched.');
  }

  void _handleNavigation(RemoteMessage msg) {
    final type = msg.data['type'];
    print('[Nav] 👉 Handling navigation for type=“$type”');

    // Example navigation logic placeholder
    if (type == 'chat') {
      print('[Nav]   > would navigate to /chat');
      // Navigator.of(context).pushNamed('/chat', arguments: …);
    }
  }

  void _onSelectNotification(NotificationResponse resp) {
    print(
      '[Tap] 📲 User tapped local notification '
      'payload="${resp.payload}"',
    );
    // You could parse resp.payload and navigate similarly here.
  }
}
