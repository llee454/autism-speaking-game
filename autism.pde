/*
  Progress bar - how far in match
  Pause Button for game
  Menu for game save game status
  Greatest Scores
  Menu let the adult choose the word with a audio sample to let the parent hear the prounciation.
  Let parents change the pronunciation at any time. Make a modal window.
*/
import processing.sound.*;
import rita.*;

Game game;

final float difficulty = 0.5;
final String leftWord  = "left";
final String rightWord = "right";
final String zoomAbilityWord = "zoom";
final String timeAbilityWord = "slow";
final int zoomSpeed = 4;

String[] leftWordPhonemes = split (RiTa.phones (leftWord), "-");
String[] rightWordPhonemes = split (RiTa.phones (rightWord), "-");
String[] zoomAbilityWordPhonemes = split (RiTa.phones (zoomAbilityWord), "-");
String[] timeAbilityWordPhonemes = split (RiTa.phones (timeAbilityWord), "-");

SoundFile backgroundMusic;
SoundFile chime;

void setup () {
  size (1000, 1000);
  frameRate (100);
  
  game = new Game ();

  // Start the program that listens for verbal commands:
  println ("Start the Listen script in the background. It should be in the Sketch folder named listen.sh");
  println ("Say " + leftWord + " to fly left.");
  println ("Say " + rightWord + " to fly right.");

  backgroundMusic = new SoundFile (this, "soundtrack.mp3");
  backgroundMusic.loop ();
  backgroundMusic.amp (0.05);
  backgroundMusic.play ();

  chime = new SoundFile (this, "chime.wav");

  println ("Background image by: Image by cartoon-galaxy-background 14350820 Freepik");
}

void draw () {
  game.render ();
}

void keyReleased () {
  if (key == 'p' || key == 'P') {
    game.isPaused = !game.isPaused;
  }
}
