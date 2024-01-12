import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kindergarden_mobile/service_layer/logger/logger.dart';

abstract class IDatabaseManager {
  Future<void> start();
  Future<void> clear();
}

@immutable
final class HiveDatabaseManager implements IDatabaseManager {
  @override
  Future<void> start() async {
    await _open();
    _initialOperation();
    Logger.instance.log("HiveDatabaseManager started");
  }

  @override
  Future<void> clear() async {
    await Hive.deleteFromDisk();
  }

  /// Open your database connection
  /// Now using [Hive]
  Future<void> _open() async {
    await Hive.initFlutter();
  }

  /// Register your generic model or make your operation before start
  void _initialOperation() {
    /* Hive.registerAdapter(ChatModelAdapter()); */
  }
}
