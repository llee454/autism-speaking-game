import processing.sound.*;

Ship ship;
Star star;

final String leftWord = "cat";
final String rightWord = "mama";

final int DEST_CENTER = 0;
final int DEST_LEFT = 1;
final int DEST_RIGHT = 2;
int dest = DEST_CENTER;

PVector leftDest, rightDest, centerDest;

SoundFile backgroundMusic;
SoundFile chime;

PImage backgroundImage;

// Track spoken text.
int numLines = 0;
int numWords = 0;

void setup () {
  size (1000, 1000);
  frameRate (80);

  // Start the program that listens for verbal commands:
  println ("Start the Listen script in the background. It should be in the Sketch folder named listen.sh");
  println ("Say " + leftWord + " to fly left.");
  println ("Say " + rightWord + " to fly right.");

  leftDest = new PVector (width/5, 3*height/4);
  rightDest = new PVector (4*width/5, 3*height/4);
  centerDest = new PVector (width/2, 3*height/4);
  
  ship = new Ship ();
  star = new Star ();

  backgroundMusic = new SoundFile (this, "soundtrack.mp3");
  backgroundMusic.loop ();
  backgroundMusic.amp (0.5);
  backgroundMusic.play ();

  chime = new SoundFile (this, "chime.wav");

  backgroundImage = loadImage ("background.jpg");

  println ("Background image by: Image by cartoon-galaxy-background 14350820 Freepik");
}

void draw () {
  background (backgroundImage);

  ship.move ();
  ship.render ();  
  if (star.overlaps (ship.pos, ship.radius)) {
    chime.play ();
    star.reset ();
  }
  star.move ();
  star.render ();

  String[] lines = loadStrings ("/Users/larrylee/Documents/Processing/autism/transcript.txt");
  if (lines.length > 0) {
    String lastLine = lines [lines.length - 1];
    String[] words = lastLine.split (" ");
    if (words.length > 0) {
      String lastWord = words [words.length - 1];
      if (lines.length != numLines && words.length != numWords) {
        numLines = lines.length;
        numWords = words.length;
        println ("last word: " + lastWord);
        switch (lastWord.toLowerCase ()) {
          // go left
          case leftWord:
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
            break;
          // go right
          case rightWord:
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
            break;
        }
      }
    }
  }
}
