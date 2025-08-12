// import 'package:flutter/material.dart';
// import 'package:scan_sa_user/utils/extension/context_ext.dart';

// class CommonBottomScreen<T extends ChangeNotifier> extends StatefulWidget {
//   const CommonBottomScreen({
//     super.key,
//     required this.children,
//     required this.title,
//     required this.provider,
//     this.suffixWidget,
//     this.isProviderValue = false,
//     this.isProfileScreen = false,
//   });

//   final String title;
//   final List<Widget> Function(BuildContext context, T provider, Widget? child)
//   children;
//   final T provider;
//   final Widget? suffixWidget;
//   final bool isProviderValue;
//   final bool isProfileScreen;

//   @override
//   State<CommonBottomScreen<T>> createState() => _CommonBottomScreenState<T>();
// }

// class _CommonBottomScreenState<T extends ChangeNotifier>
//     extends State<CommonBottomScreen<T>> {
//   final _scrollController = ScrollController();

//   @override
//   Widget build(BuildContext context) {
//     Widget builder(BuildContext context, Widget? child) {
//       final provider = Provider.of<T>(context, listen: false);
//       return CustomScrollView(
//         controller: _scrollController,
//         slivers: [
//           SliverAppBar(
//             backgroundColor: context.color.white,
//             elevation: 0,
//             floating: true,
//             snap: true,
//             foregroundColor: context.color.white,
//             surfaceTintColor: context.color.white,
//             title: Row(
//               children: [
//                 Text(
//                   widget.title,
//                   style: TextStyle(
//                     fontFamily: AppStrings.pacifico,
//                     color: context.color.primaryColor,
//                     fontSize: 34,
//                   ),
//                 ),
//                 if (!widget.isProfileScreen) const Spacer(),
//                 if (!widget.isProfileScreen)
//                   widget.suffixWidget ??
//                       GestureDetect(
//                         onTap: () {},
//                         child: const CustomBorder(
//                           padding: 8,
//                           child: SvgAssets(AppIcons.searchIc),
//                         ),
//                       ),
//               ],
//             ),
//           ),
//           ...widget.children(context, provider, child),
//         ],
//       );
//     }

//     return SafeArea(
//       child: Builder(
//         builder: (context) {
//           return Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: widget.isProviderValue
//                 ? ChangeNotifierProvider.value(
//                     value: widget.provider,
//                     builder: builder,
//                   )
//                 : ChangeNotifierProvider(
//                     create: (context) => widget.provider,
//                     builder: builder,
//                   ),
//           );
//         },
//       ),
//     );
//   }
// }
