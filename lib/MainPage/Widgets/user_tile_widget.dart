import 'package:flutter/material.dart';
import 'package:owwn_coding_challenge/Constants/k_colors.dart';
import 'package:owwn_coding_challenge/utilities.dart';

class UserTileWidget extends StatelessWidget {
  const UserTileWidget({super.key, required this.name, this.email});

  final String name;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: KColors.secondaryColor,
          ),
          child: Row(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xff393939),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        Utilities.getInitials(name),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: KColors.accentColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: KColors.accentColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  if (email != null)
                    Text(
                      email!,
                      style: const TextStyle(
                        color: KColors.accentColor,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
