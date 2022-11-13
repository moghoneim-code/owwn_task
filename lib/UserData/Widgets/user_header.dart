import 'package:flutter/material.dart';
import 'package:owwn_coding_challenge/Constants/k_colors.dart';
import 'package:owwn_coding_challenge/UserData/Providers/user_provider.dart';
import 'package:owwn_coding_challenge/utilities.dart';
import 'package:provider/provider.dart';

class UserHeader extends StatefulWidget {
  /// Creates a [UserHeader] widget.
  const UserHeader({
    super.key,
    required this.active,
  });

  final bool active;

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (
        context,
        p,
        child,
      ) {
        return Column(
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Stack(
                children: [
                  Align(
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        color: KColors.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          Utilities.getInitials(p.selectedUser!.name),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Utilities.buildSexIcon(p.selectedUser!.gender),
                            size: 35,
                            color: KColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: !widget.active
                          ? KColors.primaryColor.withOpacity(0.5)
                          : Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
