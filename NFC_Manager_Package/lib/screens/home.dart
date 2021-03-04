import 'package:TagTap/components/customized_button.dart';
import 'package:TagTap/screens/scanned.dart';
import 'package:TagTap/services/admob_service.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import '../const.dart';
import '../strings.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool isScanning = false;
  StreamSubscription<NDEFMessage> _stream;
  final admobService = AdmobService();
  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;

  toggleScanning() {
    setState(() {
      isScanning = !isScanning;
    });
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    interstitialAd = AdmobInterstitial(
      adUnitId: admobService.getInterstitialAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );
    interstitialAd.load();
  }

  @override
  void dispose() {
    super.dispose();
    interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: kColorWhite,
        appBar: AppBar(
          backgroundColor: kColorWhite,
          toolbarHeight: _height * 0.12,
          automaticallyImplyLeading: false,
          title: Image.asset(
            'assets/logo.png',
            height: _height * 0.12,
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  admobService.buildBannerAd(admobService.getBannerAd2Id()),
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  CustomizedButton(
                    text: enable_nfc,
                    rounded: true,
                    onPressed: () async {
                      bool isAvailable = await NFC.isNDEFSupported;
                      if (!isAvailable) {
                        AppSettings.openNFCSettings();
                      } else {
                        _scaffoldKey.currentState.showSnackBar(new SnackBar(
                          content: Text('Already on'),
                          duration: new Duration(seconds: 5),
                        ));
                      }
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () async {
                            if (isScanning) {
                              _stream?.cancel();
                              toggleScanning();
                            } else {
                              toggleScanning();
                              _scaffoldKey.currentState
                                  .showSnackBar(new SnackBar(
                                content: Text(scanning),
                                duration: new Duration(seconds: 5),
                              ));
                              // Start reading using NFC.readNDEF()
                              _stream = NFC
                                  .readNDEF(
                                once: true,
                                throwOnUserCancel: false,
                              )
                                  .listen((NDEFMessage message) {
                                Navigator.push(context,MaterialPageRoute(builder: (context) => ScannedScreen(
                                  resulat: message.payload.toString(),
                                )));
                                _stream?.cancel();
                                toggleScanning();
                              }, onError: (e) {
                                // Check error handling guide below
                                _scaffoldKey.currentState
                                    .showSnackBar(new SnackBar(
                                  content: Text("ERROR : $e"),
                                  duration: new Duration(seconds: 5),
                                ));
                              });
                            }
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.power_settings_new_outlined,
                                color: isScanning == false
                                    ? kColorRed
                                    : kColorGreen,
                                size: _height * 0.22,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: _height * 0.01, width: double.infinity),
                        Text(
                          isScanning == false ? start_scan : scan_on,
                          style: mainStyle.copyWith(
                              color:
                                  isScanning == false ? kColorRed : kColorGreen,
                              fontSize: _height * 0.025,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  admobService.buildBannerAd(admobService.getBannerAd1Id()),
                  CustomizedButton(
                    text: website,
                    width: double.infinity,
                    onPressed: () async {
                      const url = website_link;
                      if (await interstitialAd.isLoaded) {
                        interstitialAd.show();
                      }
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
