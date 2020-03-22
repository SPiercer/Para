import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Auth/login.dart';

void main() {
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [
      Locale('en', 'US'),
      Locale('en', 'UK'),
      Locale('ar', 'EG'),
      Locale('ar', 'SA'),
    ],
    path: 'lang',
    fallbackLocale: Locale('ar', 'EG'),
    // useOnlyLangCode: true,
    // optional assetLoader default used is RootBundleAssetLoader which uses flutter's assetloader
    // assetLoader: RootBundleAssetLoader()
    // assetLoader: NetworkAssetLoader()
    // assetLoader: TestsAssetLoader()
    // assetLoader: FileAssetLoader()
    // assetLoader: StringAssetLoader()
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Para',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
      home: Login(),
    );
  }
}