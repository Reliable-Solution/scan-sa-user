import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';

class DynamicTextColor extends StatelessWidget {
  const DynamicTextColor({super.key, required this.dynamicText});
  final String dynamicText;

  @override
  Widget build(BuildContext context) {
    List<String> words = dynamicText.split(' ');

    String lastWord = '';
    String secondLastWord = '';
    String thirdLastWord = '';
    String remainingText = '';
    String secondRemainingText = dynamicText;

    if (words.length >= 3) {
      lastWord = words.removeLast();
      secondLastWord = words.removeLast();
      thirdLastWord = words.removeLast();
    } else if (words.length == 2) {
      lastWord = words.removeLast();
      secondLastWord = words.removeLast();
      remainingText = words.join(' ');
    } else if (words.length == 1) {
      lastWord = words.removeLast();
    }

    return RichText(
      text: TextSpan(
        style: robotoBold.copyWith(fontSize: Dimensions.fontSizeOverLarge),
        children: words.length > 4
            ? [
                TextSpan(
                  text: '$remainingText ',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                TextSpan(
                  text: '$thirdLastWord ',
                  style: TextStyle(color: context.color.secondary),
                ),
                TextSpan(
                  text: '$secondLastWord ',
                  style: TextStyle(color: context.color.secondary),
                ),
                TextSpan(
                  text: lastWord,
                  style: TextStyle(color: context.color.secondary),
                ),
              ]
            : [
                TextSpan(
                  text: secondRemainingText,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
      ),
    );
  }
}
