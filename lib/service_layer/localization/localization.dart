import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/firebase/firebase_remote_config.dart';
import 'package:kindergarden_mobile/service_layer/logger/logger.dart';
import 'package:kindergarden_mobile/service_layer/providers/connection_management.dart';
import 'package:kindergarden_mobile/tools/constants/remote_config_constants.dart';

import '../device_info/device_info.dart';
import '../network/network_manager.dart';

class LocalizationService with ChangeNotifier {
  static final LocalizationService include = LocalizationService();

  Map<String, dynamic>? _content;

  bool get isLoaded => _content != null && _content!.isNotEmpty && _content is Map<String, dynamic>;

  final String _language = DeviceInfoService.instance.deviceLanguage;
  String get language => languages.contains(_language) ? _language : defaultLanguage;

  Future init() async => await parseContent();

  Future parseContent() async {
    if (ConnectionManagement.include.state != ConnectState.Connected || isLoaded == true) return;

    _languages = FirebaseRemoteConfigService.instance.getList<String>(RemoteConfigConstants.SUPPORTED_LANGS, locale: false);
    Logger.instance.log('LocalizationService ::: parseContent ::: language: $language, _language: $_language, languages: $languages');

    try {
      _content ??= (await NetworkManager.instance.get<Map<String, dynamic>>(
        '/translate/$language.json',
        fromJsonT: (json) => (json)['content'] as Map<String, dynamic>,
      ))
          .data;
    } catch (e) {
      Logger.instance.log('LocalizationService ::: parseContent ::: error: $e');
    }

    notifyListeners();
  }

  String tr(String pageKey, String keyEnum) {
    Logger.instance.log('LocalizationService ::: tr ::: pageKey: $pageKey, keyEnum: $keyEnum');
    var sources = _content?[pageKey] ?? '';

    if (sources is Map<String, dynamic>) {
      sources = sources.cast<String, String>();
    } else {
      return '';
    }

    String result = sources[keyEnum] ?? '';
    return result;
  }
/*
  Future<Map<String, dynamic>> fromFile() async {
    try {
      final String response = await rootBundle.loadString('assets/translate/$language.json');
      return jsonDecode(response)['data'];
    } catch (e) {
      final String response = await rootBundle.loadString('assets/translate/$defaultLanguage.json');
      return jsonDecode(response)['data'];
    }
  } */

  List<String> _languages = [];

  List<String> get languages => _languages;
  String defaultLanguage = 'en';
}
