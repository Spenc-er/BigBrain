import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import 'levels.dart';

class AudioLevelSelection extends StatelessWidget {
  const AudioLevelSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();

    Future<void> saveDifficulty(String level) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('difficulty', level);
    }

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'SELECT LEVEL',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: gameLevels.length,
                itemBuilder: (context, index) {
                  final level = gameLevels[index];
                  final isLevelEnabled =
                      playerProgress.highestLevelReached >= level.number - 1;

                  return AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: isLevelEnabled ? 1.0 : 0.5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          if (isLevelEnabled) {
                            final audioController =
                                context.read<AudioController>();
                            audioController.playSfx(SfxType.buttonTap);
                            saveDifficulty(level.level);
                            GoRouter.of(context)
                                .go('/play/audio/${level.number}');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: isLevelEnabled
                              ? palette.buttonColor
                              : palette.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 8,
                        ),
                        child: ListTile(
                          enabled: playerProgress.highestLevelReached >=
                              level.number - 1,
                          title: Center(
                            child: Text(
                              level.level,
                              style: TextStyle(
                                color: palette.trueWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        rectangularMenuArea: FilledButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
          onPressed: () {
            GoRouter.of(context).go('/');
          },
          child: Text(
            'BACK',
            style: TextStyle(
              fontSize: 20,
              color: palette.backgroundLevelSelection,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
