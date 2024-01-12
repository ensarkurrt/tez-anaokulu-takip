import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/indicators/circle_indicator.dart';
import 'package:kindergarden_mobile/application_layer/features/no_connection/no_connection_view.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/providers/connection_management.dart';
import 'package:provider/provider.dart';

import '../../../service_layer/providers/state_management.dart';

class LoadingView extends StatefulWidget {
  final Widget child;
  final Future<bool?> Function()? onWillPop;
  final bool? loadingView;
  final Color? backgroundColor;

  const LoadingView({
    Key? key,
    required this.child,
    this.onWillPop,
    this.loadingView = true,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    return context.watch<ConnectionManagement>().state == ConnectState.Connected
        ? GestureDetector(
            onTap: () => context.hideKeyboard(),
            child: SizedBox(
              height: context.height,
              width: context.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  WillPopScope(
                    onWillPop: () async {
                      if (StateManagement.include.state == ViewStateEnum.Busy) return false;
                      context.hideKeyboard();

                      return Future.delayed(Duration(milliseconds: context.isKeyboardOpen ? 200 : 0), () async {
                        if (widget.onWillPop != null) {
                          bool? res = await widget.onWillPop!.call();
                          if (res != null) return res;
                        }
                        return true;
                      });
                    },
                    child: Container(
                        color: widget.backgroundColor ?? context.themeColors.background,
                        /* duration: DurationEnums.themeChange.duration, */
                        child: widget.child),
                  ),
                  (widget.loadingView ?? false)
                      ? context.state.state == ViewStateEnum.Busy && context.state.showLoader
                          ? Container(
                              color: Colors.black.withOpacity(StateManagement.include.transparent ? 0.9 : 1),
                              height: context.height,
                              width: context.width,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircleIndicator(),
                                    const SizedBox(width: 10),
                                    Text(
                                      StateManagement.include.message,
                                      style: const TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container()
                      : Container(),
                ],
              ),
            ),
          )
        : const NoConnectionView();
  }
}
