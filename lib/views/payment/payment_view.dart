import 'package:fasionxt/views/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:convert';
import 'dart:typed_data';

class PaymentViewPage extends StatefulWidget {
  @override
  _PaymentViewPageState createState() => _PaymentViewPageState();
}

class _PaymentViewPageState extends State<PaymentViewPage> {
  late InAppWebViewController webViewController;
  final String url = 'https://iyabos.com/ipaymu/';
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
  }

  void _showDialogThanks(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            null;
          },
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 60),
                      Text(
                        'Order Successfull',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Products will be delivered soon.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: purplePrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 50,
                  right: 50,
                  top: -60,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: purplePrimary.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/icon-delivery.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _reloadPage() {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    webViewController.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iPaymu Payment'),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse(url),
              method: 'POST',
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
              },
              body: Uint8List.fromList(utf8.encode(Uri(
                queryParameters: {
                  'product[]': ['headset', 'softcase'],
                  'qty[]': ['1', '3'],
                  'price[]': ['100000', '20000'],
                  'imageUrl[]': [
                    'https://demo.ipaymu.com/assets/images/product-1.jpg',
                    'https://demo.ipaymu.com/assets/images/product-2.jpg'
                  ],
                },
              ).query)),
            ),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
                hasError = false;
              });
              if (url.toString().contains('thanks.php')) {
                _showDialogThanks(context);
              }
            },
            onLoadStop: (controller, url) async {
              setState(() {
                isLoading = false;
              });
            },
            onLoadError: (controller, url, code, message) {
              setState(() {
                isLoading = false;
                hasError = true;
              });
            },
          ),
          if (isLoading) Center(child: CircularProgressIndicator()),
          if (hasError)
            Center(
              child: IconButton(
                icon: Icon(Icons.refresh, size: 50),
                onPressed: _reloadPage,
              ),
            ),
        ],
      ),
    );
  }
}
