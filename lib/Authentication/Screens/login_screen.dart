import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:owwn_coding_challenge/Authentication/Providers/login_provider.dart';
import 'package:owwn_coding_challenge/Constants/k_colors.dart';
import 'package:owwn_coding_challenge/Constants/k_images.dart';
import 'package:owwn_coding_challenge/MainPage/Screens/main_page_screen.dart';
import 'package:owwn_coding_challenge/Network/view_state.dart';
import 'package:owwn_coding_challenge/Shared/widgets/provider_listener.dart';
import 'package:owwn_coding_challenge/Shared/widgets/states_widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  /// The route name of this screen.
  static const String routeName = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    /// Using the ProviderListener widget to listen to the state and perform some context related actions
    return ProviderListener<LoginProvider>(
      listener: (context, p) {
        if (p.loginState == ViewState.loaded) {
          Navigator.of(context).pushReplacementNamed(MainPageScreen.routeName);
          log('Login Success');
        }
      },

      /// Using the Consumer widget to listen to the state and perform some context related actions
      child: Consumer<LoginProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: KColors.primaryColor,
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          Provider.of<LoginProvider>(context, listen: false)
                              .login(context),
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            filterQuality: FilterQuality.high,
                            image: AssetImage(
                              KImages.loginImage,
                            ),
                          ),
                        ),

                        /// Using the LoaderWidget to show a loader when the state is loading
                        child: const Center(
                          child: Text(
                            'Press to start',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: KColors.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    if (provider.loginState == ViewState.loading)
                      LoaderWidget(
                        height: 50,
                        width: 50,
                      )
                    else
                      const SizedBox(
                        height: 50,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
