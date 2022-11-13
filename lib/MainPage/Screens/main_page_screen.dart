import 'package:flutter/material.dart';
import 'package:owwn_coding_challenge/Constants/k_colors.dart';
import 'package:owwn_coding_challenge/MainPage/Providers/main_page_provider.dart';
import 'package:owwn_coding_challenge/MainPage/Widgets/main_page_widget.dart';
import 'package:owwn_coding_challenge/Network/view_state.dart';
import 'package:owwn_coding_challenge/Shared/widgets/states_widgets/error_loading_widget.dart';
import 'package:owwn_coding_challenge/Shared/widgets/states_widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key});

  static const String routeName = 'MainPageScreen';

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  /// scroll controller for the [ListView]
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    /// loads the data from the [MainPageProvider] and sets the [MainPageProvider] to the [MainPageWidget] for the first time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MainPageProvider>(context, listen: false).getUsers(context);
    });

    /// adds a listener to the scroll controller to load more data when the user reaches the end of the list
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provider.of<MainPageProvider>(context, listen: false)
            .getMoreUsers(context);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: KColors.primaryColor,
      body: Consumer<MainPageProvider>(
        builder: (context, mainPageProvider, child) {
          if (mainPageProvider.mainPageViewState == ViewState.loading) {
            return Center(
              child: LoaderWidget(
                height: 50,
                width: 50,
              ),
            );
          }
          if (mainPageProvider.mainPageViewState == ViewState.error) {
            /// Using the ErrorLoadingWidget to show an error message when the state is error and a button to reload the data
            return ErrorLoadingWidget(
              onTryAgain: () => mainPageProvider.getUsers(context),
            );
          }

          /// Custom ListView That i created instead of using the ready pagination Plugins to show the pagination logic
          return ListView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: size.width,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/image.png',
                          width: size.width,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.darken,
                        ),
                        Container(
                          width: size.width,
                          height: size.height * 0.8,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                KColors.primaryColor,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 300),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: mainPageProvider.page - 1,
                      itemBuilder: (context, index) {
                        return MainPageWidget(
                          users: mainPageProvider.users.toList(),
                        );
                      },
                    ),
                  ),

                  /// The [LoaderWidget] that shows when the [MainPageProvider] is loading more data
                  if (mainPageProvider.loadMoreState == ViewState.loading)
                    LoaderWidget(
                      height: 50,
                      width: 50,
                    )
                  else
                    Container(),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
