import 'package:chat_ai/controllers/ai_controller.dart';
import 'package:chat_ai/controllers/theme_controller.dart';
import 'package:chat_ai/utils/utils.dart';
import 'package:chat_ai/views/profile_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ChatAiController controller = Get.put(ChatAiController());
    ThemeController themeController = Get.put(ThemeController());
    TextEditingController textEditingController = TextEditingController();
    var theme = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: theme.background,
        appBar: _appBar(theme, themeController, controller, context),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    _introAizen(theme),
                    Divider(
                      color: Colors.grey,
                      indent: 6.w,
                      endIndent: 6.w,
                    ),
                    Obx(
                      () => Column(
                          children: controller.historyList
                              .map((e) => InkWell(
                                    onLongPress: () {
                                      _bottomSheet(
                                          context, e, controller, theme);
                                    },
                                    child: _chatsA(e, theme),
                                  ))
                              .toList()),
                    )
                  ],
                ),
              ),
              _textField(theme, textEditingController, controller),
            ],
          ),
        ));
  }

  Container _chatsA(e, ColorScheme theme) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (e.system == "aizen")
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://qph.cf2.quoracdn.net/main-qimg-742d3f93801510e2a31dc2dc4ceb328e'),
                  radius: 15,
                ),
              if (e.system == "you")
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://wallpapers.com/images/hd/one-piece-pictures-1s22yzh31ithr08w.jpg'),
                  radius: 15,
                ),
              SizedBox(
                width: 4.w,
              ),
              if (e.system == "aizen")
                Text('Aizen',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: theme.onPrimary,
                      fontWeight: FontWeight.w600,
                    )),
              if (e.system == "you")
                Text('You',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: theme.onPrimary,
                      fontWeight: FontWeight.w600,
                    )),
            ],
          ),
          SizedBox(
            height: 0.2.h,
          ),
          SizedBox(
            width: 65.w,
            child: Text(
              e.message.toString(),
              softWrap: true,
              style: TextStyle(
                fontSize: 11.sp,
                color: theme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _bottomSheet(
      BuildContext context, e, ChatAiController controller, ColorScheme theme) {
    return showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: e.message)).then(
                      (value) {
                        Get.back();
                        Utils.flushBarMessage('Copied', Icons.copy_rounded,
                            theme.onSurface, Colors.blueAccent, context);
                      },
                    );
                  },
                  child: const Text("Copy",
                      style: TextStyle(color: Colors.blueAccent)),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    if (controller.historyList.remove(e) == true) {
                      Get.back();
                      Utils.flushBarMessage('Deleted', Icons.delete_rounded,
                          theme.onSurface, Colors.redAccent, context);
                    }
                  },
                  child: const Text("Delete",
                      style: TextStyle(color: Colors.redAccent)),
                ),
              ],
            ));
  }

  // TextField Chat Aizen

  Container _textField(
      ColorScheme theme,
      TextEditingController textEditingController,
      ChatAiController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: theme.secondary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 10.sp,
                  color: theme.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
                controller: textEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type a message",
                  hintStyle: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          Obx(
            () => controller.isLoading.value
                ? SpinKitSpinningCircle(
                    color: theme.onSecondaryContainer,
                    size: 20,
                  )
                : ZoomTapAnimation(
                    onTap: () {
                      if (textEditingController.text != "") {
                        controller.sendPrompt(textEditingController.text);
                        textEditingController.clear();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.onSecondaryContainer,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  // Introduction Chat Aizen
  Center _introAizen(ColorScheme theme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Container(
            width: 80.w,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: theme.secondaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Hi, I'am Aizen,\nWhat Can I Do For You?",
              // textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            )),
      ),
    );
  }

  // AppBar Chat Aizen
  AppBar _appBar(ColorScheme theme, ThemeController themeController,
      ChatAiController controller, context) {
    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: theme.primary,
      elevation: 0,
      centerTitle: true,
      title: GestureDetector(
        onTap: () {
          Utils.flushBarMessage('Long Tap Aizen Profile 😁', Icons.info_rounded,
              theme.onSurface, Colors.redAccent, context);
        },
        child: Text('AIZEN',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            )),
      ),
      actions: [
        IconButton(
            tooltip: 'Clear Chat',
            onPressed: () {
              controller.historyList.clear();
            },
            icon: const Icon(Icons.refresh_rounded)),
        IconButton(
            tooltip: 'Change Theme',
            onPressed: () {
              themeController.toggleTheme();
            },
            icon: Icon(
              themeController.isDarkMode.value
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ))
      ],
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: ZoomTapAnimation(
          onLongTap: () {
            _profileSheet(context);
            print('Krishna');
          },
          onTap: () {
            controller.sendPrompt("Yo 🤚🏻");
          },
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://qph.cf2.quoracdn.net/main-qimg-742d3f93801510e2a31dc2dc4ceb328e'),
          ),
        ),
      ),
    );
  }
}

Future<dynamic> _profileSheet(BuildContext context) {
  return showModalBottomSheet(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      builder: (BuildContext context) {
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              height: 4,
              margin: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 43.w),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(8)),
            ),
            const ProfileSheetList(),
          ],
        );
      });
}
