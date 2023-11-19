import 'package:flutter/material.dart';

class OverlayLoading {
  OverlayLoading._sharedInstance();
  static final OverlayLoading _shared = OverlayLoading._sharedInstance();
  factory OverlayLoading.instance() => _shared;

  OverlayEntry? _overlayEntry;

  void showLoading(BuildContext context) {
    hide();
    _overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: Colors.black12.withAlpha(100),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(30),
            child: Image.asset("asset/gif/animated_book.gif"),
          ),
        ),
      ));
    });
    Overlay.of(context).insert(_overlayEntry!);
  }

  void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
