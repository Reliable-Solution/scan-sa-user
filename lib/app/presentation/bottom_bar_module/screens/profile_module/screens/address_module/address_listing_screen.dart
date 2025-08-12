import 'package:flutter/material.dart';
import 'package:scan_sa_user/app/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class AddressListingScreen extends StatelessWidget {
  const AddressListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSubScreen(
      appBarTitle: context.l10n.myAddress,
      child: const SizedBox(),
    );
  }
}
