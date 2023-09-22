import processing.sound.*;
import rita.*;

final float difficulty = 0.5;
final String leftWord  = "left";
final String rightWord = "right";
final String zoomAbilityWord = "zoom";
final String timeAbilityWord = "slow";

String[] leftWordPhonemes = split (RiTa.phones (leftWord), "-");
String[] rightWordPhonemes = split (RiTa.phones (rightWord), "-");
String[] zoomAbilityWordPhonemes = split (RiTa.phones (zoomAbilityWord), "-");
String[] timeAbilityWordPhonemes = split (RiTa.phones (timeAbilityWord), "-");

Ship ship;
Star star;
AIShip aiShip;
TextBubble textBubble;

final int DEST_CENTER = 0;
final int DEST_LEFT = 1;
final int DEST_RIGHT = 2;
int dest = DEST_CENTER;

PVector leftDest, rightDest, centerDest;

SoundFile backgroundMusic;
SoundFile chime;

PImage backgroundImage;
Background starBackground;

// Track spoken text.
int numLines = 0;
int numWords = 0;

void setup () {
  size (1000, 1000);
  frameRate (100);

  Game.zoomAbilityIcon = loadImage ("zoom_icon.png");
  Game.timeAbilityIcon = loadImage ("time_icon.png");  
  
  // Start the program that listens for verbal commands:
  println ("Start the Listen script in the background. It should be in the Sketch folder named listen.sh");
  println ("Say " + leftWord + " to fly left.");
  println ("Say " + rightWord + " to fly right.");

  leftDest = new PVector (width/5, 3*height/4);
  rightDest = new PVector (4*width/5, 3*height/4);
  centerDest = new PVector (width/2, 3*height/4);
  
  ship = new Ship ();
  star = new Star ();
  aiShip = new AIShip ();
  textBubble = new TextBubble ();

  backgroundMusic = new SoundFile (this, "soundtrack.mp3");
  backgroundMusic.loop ();
  backgroundMusic.amp (0.05);
  backgroundMusic.play ();

  chime = new SoundFile (this, "chime.wav");

  backgroundImage = loadImage ("background.jpg");
  starBackground = new Background ();

  println ("Background image by: Image by cartoon-galaxy-background 14350820 Freepik");
}

void draw () {
  background (backgroundImage);

  starBackground.move ();
  starBackground.render ();

  aiShip.move ();
  aiShip.render ();
  
  ship.move ();
  ship.render ();
  
  if (star.overlaps (ship.pos, ship.radius)) {
    chime.play ();
    star.reset ();
    aiShip.moveDown ();
    Game.health = min (5, Game.health + 1);
    Game.score ++;
    
    if (Game.score % zoomAbilityThreshold == 0 && Game.zoomAbilityCounter <= 0) {
      Game.hasZoomAbility = true;
      Game.zoomAbilityCounter = 500;
    }
    if (Game.score % timeAbilityThreshold == 0 && Game.timeAbilityCounter <= 0) {
      Game.hasTimeAbility = true;
      Game.timeAbilityCounter = 500;
    }
  }
  if (star.pos.y > height + 100) {
    star.reset ();
    aiShip.moveUp ();
    Game.health = max (0, Game.health - 1);
    Game.score = max (0, Game.score - 1);
    if (Game.health <= 0) {
      Game.hasZoomAbility = false;
      Game.hasTimeAbility = false;
      Game.zoomAbilityCounter = 0;
      Game.timeAbilityCounter = 0;
    }
  }
  if (aiShip.pos.y > height + aiShip.radius) {
    aiShip.reset ();
    Game.level ++;
    if (Game.level % 5 == 0) {
      textBubble.currentMessage ++;
      textBubbleCounter = 500;
    }
  }
  star.move ();
  star.render ();

  if (textBubbleCounter > 0) {  textBubble.render (); }
  textBubbleCounter --;

  drawHealth ();
  drawScore ();
  drawChapter ();
  drawAbilityIcons ();
  
  if (Game.usingTimeAbility && Game.timeAbilityCounter > 0) {
    Game.timeAbilityCounter --;
    if (Game.timeAbilityCounter <= 0) {
      Game.usingTimeAbility = false;
      Game.hasTimeAbility = false;
    }
  }
  if (Game.usingZoomAbility && Game.zoomAbilityCounter > 0) {
    Game.zoomAbilityCounter --;
    if (Game.zoomAbilityCounter <= 0) {
      Game.usingZoomAbility = false;
      Game.hasZoomAbility = false;
    }
  }

  String[] lines = loadStrings ("/Users/larrylee/Documents/Processing/autism/transcript.txt");
  if (lines.length > 0) {
    String lastLine = lines [lines.length - 1];
    String[] words = lastLine.split (" ");
    if (words.length > 0) {
      String lastWord = (words [words.length - 1]);
      if (lines.length != numLines && words.length != numWords) {
        numLines = lines.length;
        numWords = words.length;
        String[] lastWordPhonemes = split (RiTa.phones (lastWord), "-");

        println ("last word: \"" + lastWord + "\" phonemes: " + interpolate (lastWordPhonemes, ", ") + ".");
        if (wordSoundsLike (difficulty, leftWordPhonemes, lastWordPhonemes)) {
          // go left
          switch (dest) {
            case DEST_CENTER:
              dest = DEST_LEFT;
              ship.dest = leftDest;
              break;
            case DEST_RIGHT:
              dest = DEST_CENTER;
              ship.dest = centerDest;
              break;
            default:
          }
        } else if (wordSoundsLike (difficulty, rightWordPhonemes, lastWordPhonemes)) {
          // go right
          switch (dest) {
            case DEST_CENTER:
              dest = DEST_RIGHT;
              ship.dest = rightDest;
              break;
            case DEST_LEFT:
              dest = DEST_CENTER;
              ship.dest = centerDest;
              break;
            default:
          }
        } else if (wordSoundsLike (difficulty, timeAbilityWordPhonemes, lastWordPhonemes)) {
          Game.usingTimeAbility = true;
        } else if (wordSoundsLike (difficulty, zoomAbilityWordPhonemes, lastWordPhonemes)) {
          Game.usingZoomAbility = true;
        }
      }
    }
  }
}
