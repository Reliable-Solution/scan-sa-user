import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:scan_sa_user/common/widgets/app_image_widget.dart';
import 'package:scan_sa_user/features/dashboard/screens/qr_scanner_screen/qr_sheet.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:scan_sa_user/util/images.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isClosed = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showQrSheet(context, () {
        isClosed = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildQrView(context),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.paddingOf(context).top + 20,
              left: 20,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: Get.back,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.color.white,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(color: Color(0xFF343434), blurRadius: 5),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgAssets(
                        Images.arrowBackIc,
                        color: context.color.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top + 30,
                left: 20,
              ),
              child: Column(
                children: [
                  Text(
                    'Scan QR Code',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: context.color.white,
                      shadows: [
                        Shadow(
                          color: context.color.primary.withValues(alpha: 0.25),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: context.color.primary.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Please align QR code',
                      style: context.style.s16w700.copyWith(
                        color: context.color.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderRadius: 30,
        borderWidth: 8,
        borderColor: context.color.ff9c9c9c,
        cutOutSize: MediaQuery.sizeOf(context).width * 0.7,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (result == null && isClosed) {
        try {
          if (jsonDecode(scanData.code ?? '{}') is int) {
            Get.back();
            Future.delayed(Durations.short2, () {
              Get.toNamed(
                'store?slug=smart-shopping${scanData.code}&from=qrScan',
              );
            });
            // AppPages.restaurantScreen.push(arguments: scanData.code);
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Invalid QR Code')));
          }
          setState(() {
            result = scanData;
          });
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid QR Code'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('no Permission')));
    }
  }
}
