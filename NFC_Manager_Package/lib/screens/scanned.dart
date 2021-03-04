import 'dart:async';

import 'package:TagTap/components/customized_button.dart';
import 'package:TagTap/services/admob_service.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../const.dart';
import '../strings.dart';

class ScannedScreen extends StatefulWidget {
  final String resulat;

  const ScannedScreen({Key key, this.resulat}) : super(key: key);
  @override
  _ScannedScreenState createState() => _ScannedScreenState();
}

class _ScannedScreenState extends State<ScannedScreen> {
  final admobService = AdmobService();
  AdmobBannerSize bannerSize;

  @override
  void initState() {
    super.initState();
    startTime(widget.resulat);
  }

  startTime(initResult) async {
    var duration = new Duration(seconds: 2);
    return new Timer(
      duration,
      () async {
        var url = initResult;
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kbackgroundColor,
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
          child: Column(
            children: [
              admobService.buildBannerAd(admobService.getBannerAd1Id()),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomizedButton(
                      text: start_rescan,
                      rounded: true,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                    ),
                  ],
                ),
              ),
              admobService.buildBannerAd(admobService.getBannerAd2Id()),
              CustomizedButton(
                text: website,
                width: double.infinity,
                onPressed: () async {
                  const url = website_link;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
