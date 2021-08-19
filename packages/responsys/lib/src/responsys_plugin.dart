import 'dart:convert';

import 'package:flutter/services.dart';

class Responsys {
  final MethodChannel _channel = const MethodChannel('responsys/messages');

  final EventChannel _eventChannel = const EventChannel('responsys/events');

  Stream<Map<String, dynamic>?>? _foregroundNotificationStream;

  Stream<Map<String, dynamic>?> get handleForegroundNotification =>
      _foregroundNotificationStream ??= _eventChannel
          .receiveBroadcastStream()
          .map<Map<String, dynamic>?>((event) {
        if (event != null) {
          if (event is String) {
            return Map.from(jsonDecode(event));
          } else {
            return Map.from(event);
          }
        } else {
          return null;
        }
      });

  Future<void> init() => _channel.invokeMethod('init');

  Future<Map<String, dynamic>?> getNotificationData() async {
    final _data = await _channel.invokeMethod('getNotificationData');
    if (_data != null) {
      if (_data is String) {
        return Map.from(jsonDecode(_data));
      } else {
        return Map.from(_data);
      }
    } else {
      return null;
    }
  }

  Future<String?> registerUserId(String userId) async {
    final properties = <String, dynamic>{'userId': userId};

    return _channel.invokeMethod<String>('registerUserId', properties);
  }

  Future<String?> unregisterUserId() async =>
      _channel.invokeMethod<String>('unregisterUserId');

  Future<List<Map<String, dynamic>>> loadCache() async {
    final data = await _channel.invokeMethod('loadCache');

    if (data != null) {
      if (data is String) {
        return List.from(jsonDecode(data));
      } else {
        return List.from(data);
      }
    } else {
      return [];
    }
  }

  Future<void> clearCache() => _channel.invokeMethod('clearCache');
}
