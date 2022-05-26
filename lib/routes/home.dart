import 'package:flutter/material.dart';
import 'package:rho/widgets/empty_state.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isDialogShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(
        child: EmptyState(),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: _isDialogShown
          ? null
          : FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _isDialogShown = true;
                });

                showGeneralDialog(
                  context: context,
                  transitionBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 350),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return Dialog(
                      alignment: Alignment.bottomCenter,
                      insetPadding: EdgeInsets.zero,
                      elevation: 0.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0),
                        ),
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 420.0,
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 6.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text('Here\'d find the text input'),
                              const SizedBox(height: 8.0),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    primary:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: const Text('Done'),
                                  onPressed: () {
                                    setState(
                                      () {
                                        _isDialogShown = false;
                                      },
                                    );

                                    Navigator.pop(context);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
