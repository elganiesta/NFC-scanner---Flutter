import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';

class AdmobService {
  final String _appIdIOS = 'ca-app-pub-6864817783919073~7540533737';
  final String _appIdAndroid = 'ca-app-pub-6864817783919073~1577760611';

  // Ads IDs for IOS
  final String banner1IDIos = 'ca-app-pub-6864817783919073/1058885869';
  final String banner2IDIos = 'ca-app-pub-6864817783919073/6878543976';
  final String interstitialIDIos = 'ca-app-pub-6864817783919073/5182318926';

  // Ads IDs for Android
  final String banner1IDAndroid = 'ca-app-pub-6864817783919073/9839394012';
  final String banner2IDAndroid = 'ca-app-pub-6864817783919073/2173012206';
  final String interstitialIDAndroid = 'ca-app-pub-6864817783919073/1981440516';

  //get the app id configured at Admob
  String getAppId() {
    if (Platform.isIOS) {
      return _appIdIOS;
    } else if (Platform.isAndroid) {
      return _appIdAndroid;
    }
    return null;
  }

  //Banner Ad
  AdmobBanner buildBannerAd(String bannerId) {
    return AdmobBanner(
      adUnitId: bannerId,
      adSize: AdmobBannerSize.FULL_BANNER,
    );
  }

  //######### Set your Ads here #########
  String getBannerAd1Id() {
    if (Platform.isIOS) {
      return banner1IDIos;
    } else if (Platform.isAndroid) {
      return banner1IDAndroid;
    }
    return null;
  }
  String getBannerAd2Id() {
    if (Platform.isIOS) {
      return banner2IDIos;
    } else if (Platform.isAndroid) {
      return banner2IDAndroid;
    }
    return null;
  }

  String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return interstitialIDIos;
    } else if (Platform.isAndroid) {
      return interstitialIDAndroid;
    }
    return null;
  }
}
