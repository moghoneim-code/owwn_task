import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef EventListener<T extends ChangeNotifier> = void Function(
  BuildContext context,
  T provider,
);

class ProviderListener<A extends ChangeNotifier> extends StatefulWidget {
  final EventListener<A> listener;
  final Widget child;

  const ProviderListener({
    super.key,
    required this.listener,
    required this.child,
  });

  @override
  State<ProviderListener> createState() => _ProviderListenerState<A>();
}

class _ProviderListenerState<A extends ChangeNotifier>
    extends State<ProviderListener<A>> {
  A? provider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = context.read<A>();
      provider?.addListener(listener);
    });
    super.initState();
  }

  @override
  void dispose() {
    provider?.removeListener(listener);
    super.dispose();
  }

  void listener() => widget.listener(context, context.read<A>());

  @override
  Widget build(BuildContext context) => widget.child;
}
