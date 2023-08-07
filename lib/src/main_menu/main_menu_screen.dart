// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

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
    var name = playerProgress.pet;

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
                        'assets/images/' + name + number + '.riv',
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
                ClipOval(
                  child: Material(
                    color: Colors.white, // Change to your desired color
                    child: InkWell(
                      onTap: () {
                        audioController.playSfx(SfxType.buttonTap);
                        GoRouter.of(context).go('/settings');
                      },
                      child: SizedBox(
                        width: 70, // Adjust the size as needed
                        height: 70, // Adjust the size as needed
                        child: Container(
                          width: 70, // Adjust the width as needed
                          height: 70, // Adjust the height as needed
                          child: Icon(
                            Icons.settings,
                            color: palette.backgroundMain,
                            size: 40, // Adjust the icon size as needed
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ClipOval(
                  child: Material(
                    color: Colors.white, // Change to your desired color
                    child: InkWell(
                      onTap: () {
                        audioController.playSfx(SfxType.buttonTap);
                        GoRouter.of(context).go('/play');
                      },
                      child: SizedBox(
                        width: 100, // Adjust the size as needed
                        height: 100, // Adjust the size as needed
                        child: Center(
                          child: Text(
                            'PLAY',
                            style: TextStyle(
                                color: palette.backgroundMain,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ClipOval(
                  child: Material(
                    color: Colors.white, // Change to your desired color
                    child: InkWell(
                      onTap: () {
                        audioController.playSfx(SfxType.buttonTap);
                        GoRouter.of(context).go('/profile');
                      },
                      child: SizedBox(
                        width: 70, // Adjust the size as needed
                        height: 70, // Adjust the size as needed
                        child: Container(
                          width: 70, // Adjust the width as needed
                          height: 70, // Adjust the height as needed
                          child: Icon(
                            Icons.person,
                            color: palette.backgroundMain,
                            size: 40, // Adjust the icon size as needed
                          ),
                        ),
                      ),
                    ),
                  ),
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

  static const _gap = SizedBox(height: 10);
}
