import 'package:hive_flutter/hive_flutter.dart';

/// Hive boxes for local cache and session data
class HiveBoxes {
  static const String session = 'session';
  static const String settings = 'settings';
  static const String priceCache = 'price_cache';
  static const String customerCache = 'customer_cache';
}

/// Session data stored in Hive
class SessionData {
  final String tenantId;
  final String userId;
  final String branchId;
  final String userName;
  final String roleName;
  final DateTime loginAt;
  final String? accessToken;

  SessionData({
    required this.tenantId,
    required this.userId,
    required this.branchId,
    required this.userName,
    required this.roleName,
    required this.loginAt,
    this.accessToken,
  });

  Map<String, dynamic> toJson() => {
    'tenantId': tenantId,
    'userId': userId,
    'branchId': branchId,
    'userName': userName,
    'roleName': roleName,
    'loginAt': loginAt.toIso8601String(),
    'accessToken': accessToken,
  };

  factory SessionData.fromJson(Map<String, dynamic> json) => SessionData(
    tenantId: json['tenantId'],
    userId: json['userId'],
    branchId: json['branchId'],
    userName: json['userName'],
    roleName: json['roleName'],
    loginAt: DateTime.parse(json['loginAt']),
    accessToken: json['accessToken'],
  );
}

/// Initialize Hive storage
Future<void> initHive() async {
  await Hive.initFlutter();
  
  // Open boxes
  await Hive.openBox(HiveBoxes.session);
  await Hive.openBox(HiveBoxes.settings);
  await Hive.openBox(HiveBoxes.priceCache);
  await Hive.openBox(HiveBoxes.customerCache);
}

/// Get session box
Box get sessionBox => Hive.box(HiveBoxes.session);

/// Get settings box
Box get settingsBox => Hive.box(HiveBoxes.settings);

/// Save current session
Future<void> saveSession(SessionData session) async {
  await sessionBox.put('current', session.toJson());
}

/// Get current session
SessionData? getCurrentSession() {
  final data = sessionBox.get('current');
  if (data == null) return null;
  return SessionData.fromJson(Map<String, dynamic>.from(data));
}

/// Clear session (logout)
Future<void> clearSession() async {
  await sessionBox.delete('current');
}

/// Check if user is logged in
bool isLoggedIn() {
  return sessionBox.containsKey('current');
}
