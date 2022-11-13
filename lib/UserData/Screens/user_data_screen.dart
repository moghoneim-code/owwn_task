import 'package:flutter/material.dart';
import 'package:owwn_coding_challenge/Constants/k_colors.dart';
import 'package:owwn_coding_challenge/UserData/Providers/user_provider.dart';
import 'package:owwn_coding_challenge/UserData/Screens/edit_user_data_screen.dart';
import 'package:owwn_coding_challenge/UserData/Widgets/chart_widget.dart';
import 'package:owwn_coding_challenge/UserData/Widgets/user_header.dart';
import 'package:provider/provider.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({
    super.key,
  });

  static String routeName = 'UserDataScreen';

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  @override
  void initState() {
    super.initState();
  }

  /// Creates a [UserDataScreen] widget.
  @override
  Widget build(BuildContext context) {
    /// Listens to the [UserProvider] and rebuilds the widget when the [UserProvider] changes.
    return Consumer<UserProvider>(builder: (context, p, child) {
      return Scaffold(
        backgroundColor: KColors.primaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const EditDataScreen();
                    },
                  ),
                );
              },
              child: Column(
                children: [
                  const UserHeader(
                    active: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      p.selectedUser!.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      p.selectedUser!.id,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Creates a [ChartWidget] widget.
            ChartWidget(
              spots: (p.selectedUser!.statistics as List<dynamic>)
                  .map((e) => int.parse(e.toString()))
                  .toList(),
            ),
          ],
        ),
      );
    });
  }
}
