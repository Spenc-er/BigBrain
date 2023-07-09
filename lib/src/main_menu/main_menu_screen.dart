// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../games_services/games_services.dart';
import '../player_progress/player_progress.dart';
import '../settings/settings.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  SMIInput<bool>? bounce;
  SMIInput<bool>? spin;
  Artboard? artboardButton;

  void bounceAnimation() => bounce?.change(true);

  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/images/slime1.riv').then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller =
          StateMachineController.fromArtboard(artboard, 'State Machine 1');
      if (controller != null) {
        artboard.addController(controller);
        bounce = controller.findInput('bounce');
        spin = controller.findInput('spin');
      }
      setState(() => artboardButton = artboard);
    });
  }

  StateMachineController? controller;
  void _onRiveInit(Artboard artboard) {
    controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);

    bounce = controller?.findInput('bounce');
    spin = controller?.findInput('spin');
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();
    Size size = MediaQuery.of(context).size;
    final playerProgress = context.watch<PlayerProgress>();
    var number = playerProgress.highestLevelReached > 0 ? "1" : "0";
    return Scaffold(
      backgroundColor: palette.backgroundMain,
      body: ResponsiveScreen(
        mainAreaProminence: 0.3,
        squarishMainArea: Center(
          child: Align(
            // bigbrainlowresolutionlogowhite (39:11)
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 184,
              height: 162,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            artboardButton == null
                ? SizedBox()
                : GestureDetector(
                    onTap: () => bounce?.change(true),
                    onLongPress: () => spin?.change(true),
                    child: SizedBox(
                      width: size.width,
                      height: 280,
                      child: RiveAnimation.asset(
                        'assets/images/slime' + number + '.riv',
                        // stateMachines: ['State Machine 1'],
                        // animations: const ['Idle'],
                        onInit: (art) {
                          _onRiveInit(art);
                        },
                      ),
                    )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilledButton(
                  onPressed: () => GoRouter.of(context).push('/settings'),
                  child: const Text('Settings'),
                ),
                FilledButton(
                  onPressed: () {
                    audioController.playSfx(SfxType.buttonTap);
                    GoRouter.of(context).go('/play');
                  },
                  child: const Text('Play'),
                ),
                FilledButton(
                  onPressed: () {
                    audioController.playSfx(SfxType.buttonTap);
                    GoRouter.of(context).go('/profile');
                  },
                  child: const Text('Profile'),
                ),
              ],
            ),
            _gap,
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ValueListenableBuilder<bool>(
                valueListenable: settingsController.muted,
                builder: (context, muted, child) {
                  return IconButton(
                    onPressed: () => settingsController.toggleMuted(),
                    icon: Icon(muted ? Icons.volume_off : Icons.volume_up),
                  );
                },
              ),
            ),
            const Text('Music by Mr Smith'),
          ],
        ),
      ),
    );
  }

  /// Prevents the game from showing game-services-related menu items
  /// until we're sure the player is signed in.
  ///
  /// This normally happens immediately after game start, so players will not
  /// see any flash. The exception is folks who decline to use Game Center
  /// or Google Play Game Services, or who haven't yet set it up.
  Widget _hideUntilReady({required Widget child, required Future<bool> ready}) {
    return FutureBuilder<bool>(
      future: ready,
      builder: (context, snapshot) {
        // Use Visibility here so that we have the space for the buttons
        // ready.
        return Visibility(
          visible: snapshot.data ?? false,
          maintainState: true,
          maintainSize: true,
          maintainAnimation: true,
          child: child,
        );
      },
    );
  }

  static const _gap = SizedBox(height: 10);
}
