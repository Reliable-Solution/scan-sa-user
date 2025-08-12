import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart'
    show HtmlWidget;
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/html/controllers/html_controller.dart';
import 'package:scan_sa_user/app/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/utils/dimensions.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HtmlViewerScreen extends StatefulWidget {
  const HtmlViewerScreen({super.key, required this.isPrivacyPolicy});
  final bool isPrivacyPolicy;

  @override
  State<HtmlViewerScreen> createState() => _HtmlViewerScreenState();
}

class _HtmlViewerScreenState extends State<HtmlViewerScreen> {
  final htmlController = Get.put(
    HtmlController(htmlServiceInterface: Get.find()),
  );
  @override
  void initState() {
    super.initState();

    htmlController.getHtmlText(widget.isPrivacyPolicy);
  }

  @override
  Widget build(BuildContext context) {
    return CommonSubScreen(
      appBarTitle: widget.isPrivacyPolicy
          ? context.l10n.privacyPolicy
          : context.l10n.termsConditions,
      child: GetBuilder<HtmlController>(
        builder: (htmlController) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).cardColor,
            child: htmlController.htmlText != null
                ? SingleChildScrollView(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    physics: const BouncingScrollPhysics(),
                    child: HtmlWidget(
                      htmlController.htmlText ?? '',
                      key: Key(
                        widget.isPrivacyPolicy
                            ? 'privacy_policy'
                            : 'terms_condition',
                      ),
                      onTapUrl: (String url) {
                        return launchUrlString(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
