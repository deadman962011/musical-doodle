import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';

import 'package:com.mybill.app/generated/l10n.dart';

class UserNotifications extends StatefulWidget {
  const UserNotifications({super.key});

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<UserNotifications> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: UserAppBar.buildUserAppBar(
              context, 'notifications', S.of(context).notifications, {}),
          body: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: RefreshIndicator(
                  color: MyTheme.accent_color,
                  backgroundColor: Colors.white,
                  displacement: 0,
                  onRefresh: () async {},
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [_buildNotificationsList()],
                  ))),
        ));
  }

  Widget _buildNotificationsList() {
    return _buildNoNotifications();
  }

  Widget _buildNoNotifications() {
    return Expanded(
        child: CustomScrollView(slivers: [
      // Wrap your widgets with the SliverToBoxAdapter
      SliverFillRemaining(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/bell_medium.png',
            color: MyTheme.accent_color,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'No Notifications',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ))
    ]));
  }
}
