import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  LoaderWidget({
    this.hasTransparentBackground = true,
    this.height,
    this.width,
    super.key,
  });

  final bool hasTransparentBackground;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    height ??= MediaQuery.of(context).size.height;
    width ??= MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      color: hasTransparentBackground ? Colors.transparent : Colors.white,
      child: const Center(
        child: SizedBox(
          height: 60.0,
          width: 60.0,
          child: CupertinoActivityIndicator(
            radius: 25.0,
          ),
        ),
      ),
    );
  }
}

class AppLoader extends StatelessWidget {
  const AppLoader({
    required this.isLoading,
    this.hasTransparentBackground = true,
    this.height,
    this.width,
    required this.child,
    super.key,
  });

  final bool isLoading;
  final bool hasTransparentBackground;
  final Widget child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          LoaderWidget(
            hasTransparentBackground: hasTransparentBackground,
            height: height,
            width: width,
          )
        else
          Container(),
      ],
    );
  }
}
