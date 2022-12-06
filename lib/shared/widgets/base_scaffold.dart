import 'package:flutter/material.dart';
import 'package:mangadex/shared/widgets/bottom_navigation.dart';
import 'package:mangadex/shared/widgets/loading.dart';

/// Basic Scaffold to avoid boilerplate code in the application.
/// Contains a loader controlled by [_isLoading]
class BaseScaffold extends StatefulWidget {
  final AppBar? appBar;

  final Widget body;

  final FloatingActionButton? fab;

  final FloatingActionButtonLocation? fabPosition;

  final bool resizeToAvoidBottomInset;

  final bool _isLoading;

  final bool showBottomBar;

  /// If true, interactions with the UI is limited while loading.
  final bool isInteractionLimitedWhileLoading;

  const BaseScaffold(
      {super.key,
      this.appBar,
      required this.body,
      this.fab,
      this.fabPosition,
      bool isLoading = false,
      this.showBottomBar = false,
      this.isInteractionLimitedWhileLoading = true,
      this.resizeToAvoidBottomInset = false})
      : _isLoading = isLoading;

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        appBar: widget.appBar,
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              widget.body,
              if (widget._isLoading)
                Loading(
                    isInteractionLimited:
                        widget.isInteractionLimitedWhileLoading)
            ],
          ),
        ),
        floatingActionButton: widget.fab,
        floatingActionButtonLocation: widget.fabPosition,
        bottomNavigationBar: widget.showBottomBar ? const BottomNavigation() : null,
      );
}
