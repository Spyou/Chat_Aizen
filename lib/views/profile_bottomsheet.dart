import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileSheetList extends StatelessWidget {
  const ProfileSheetList({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 1.2.h,
            ),
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/88382789?v=4'),
            ),
            SizedBox(height: 3.h),
            Text(
              'Krishna Vishwakarma',
              style: TextStyle(
                fontSize: 16.sp,
                color: theme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'spyou',
              style: TextStyle(
                fontSize: 11.sp,
                color: theme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Divider(
              color: theme.secondary,
              indent: 8.w,
              endIndent: 8.w,
            ),
            SizedBox(height: 2.h),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.secondary),
                ),
                onPressed: () {
                  launchUrl(
                    Uri.parse('https://github.com/Spyou'),
                  );
                },
                child: Text('See Profile',
                    style: TextStyle(
                      color: theme.primary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ))),
            SizedBox(height: 2.h),
          ],
        ));
  }
}
