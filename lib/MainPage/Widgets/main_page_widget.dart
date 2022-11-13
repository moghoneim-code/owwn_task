import 'package:flutter/material.dart';
import 'package:owwn_coding_challenge/Constants/k_colors.dart';
import 'package:owwn_coding_challenge/MainPage/Models/user_model.dart';
import 'package:owwn_coding_challenge/MainPage/Widgets/user_tile_widget.dart';
import 'package:owwn_coding_challenge/Shared/widgets/provider_listener.dart';
import 'package:owwn_coding_challenge/UserData/Providers/user_provider.dart';
import 'package:owwn_coding_challenge/UserData/Screens/user_data_screen.dart';
import 'package:provider/provider.dart';

import '../../Network/view_state.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({super.key, required this.users});

  final List<UserModel> users;

  @override
  State<MainPageWidget> createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  List<UserModel> activeUsers = [];
  List<UserModel> inActiveUsers = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sortList(widget.users);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future sortList(List<UserModel> users) {
    inActiveUsers.clear();
    activeUsers.clear();
    for (final element in users) {
      if (element.status == 'active') {
        if (!activeUsers.contains(element)) {
          activeUsers.add(element);
        }
      } else {
        if (!inActiveUsers.contains(element)) {
          inActiveUsers.add(element);
        }
      }
    }
    setState(() {});
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: KColors.accentColor, fontSize: 18);
    return ProviderListener<UserProvider>(
      listener: (context, p) {
        if (p.userViewState == ViewState.loaded) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const UserDataScreen(),
            ),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (activeUsers.isNotEmpty)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'active',
                style: style,
              ),
            )
          else
            const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: KColors.secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Container(
                  color: KColors.primaryColor,
                  height: 5,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Provider.of<UserProvider>(context, listen: false)
                          .setSelectedUser(activeUsers[index]);
                    },
                    child: UserTileWidget(
                      name: activeUsers[index].name,
                      email: activeUsers[index].id,
                    ),
                  );
                },
                itemCount: activeUsers.length,
              ),
            ),
          ),
          if (inActiveUsers.isNotEmpty)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'inactive',
                style: style,
              ),
            )
          else
            Container(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: KColors.secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Container(
                  color: KColors.primaryColor,
                  height: 5,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Provider.of<UserProvider>(context, listen: false)
                          .setSelectedUser(inActiveUsers[index]);
                    },
                    child: UserTileWidget(
                      name: inActiveUsers[index].name,
                      email: inActiveUsers[index].id,
                    ),
                  );
                },
                itemCount: inActiveUsers.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
