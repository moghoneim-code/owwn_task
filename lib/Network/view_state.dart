
import 'package:flutter/material.dart';


enum ViewState { initial, loading, empty, error, loaded, submit }

extension ViewStateHandling on ViewState {
  Widget handleViewState({
    required void Function() fetchRequest,
    required String emptyMessage,
    required Widget child,
    bool showLoading = true,
  }) {
    switch (this) {
      case ViewState.initial:
        fetchRequest();
        return showLoading ? const Text('loading') : Container();

      case ViewState.loading:
        return showLoading ? const Text('loading') : Container();

      // case ViewState.empty:
      //   return EmptyWidget(text: emptyMessage);
      //
      // case ViewState.error:
      //   return const ErrorLoadingWidget();

      default:
        return child;
    }
  }
}

