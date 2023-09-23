/*
  This class defines the Game state.
*/

// Track spoken text.
int numLines = 0;
int numWords = 0;

final int DEST_CENTER = 0;
final int DEST_LEFT = 1;
final int DEST_RIGHT = 2;
int dest = DEST_CENTER;


final int zoomAbilityThreshold = 5;
final int timeAbilityThreshold = 10;

class Game {
  JSONObject missions = loadJSONObject ("missions.json");
  
  final PVector leftDest = new PVector (width/5, 3*height/4);
  final PVector rightDest = new PVector (4*width/5, 3*height/4);
  final PVector centerDest = new PVector (width/2, 3*height/4);
  
  PImage backgroundImage = loadImage ("background.jpg");
  Background starBackground  = new Background ();
  TextBubble textBubble;
  Slide closing;
  
  Ship ship = new Ship ();
  Star star = new Star ();
  AIShip aiShip = new AIShip ();
  
  int level = 0;
  int health = 5;
  int score = 0;
  PImage zoomAbilityIcon;
  PImage timeAbilityIcon;
  boolean hasZoomAbility = false;
  boolean hasTimeAbility = false;
  boolean usingZoomAbility = false;
  boolean usingTimeAbility = false;
  int zoomAbilityCounter = 0;
  int timeAbilityCounter = 0;

  Game (int missionIndex) {
    this.zoomAbilityIcon = loadImage ("zoom_icon.png");
    this.timeAbilityIcon = loadImage ("time_icon.png");
    
    JSONObject mission = missions.getJSONArray ("missions").getJSONObject (missionIndex);    
    textBubble = new TextBubble (mission.getJSONArray ("mission"));
    closing = new Slide (mission.getJSONArray ("closing"));
  }

  // Draw the health meter.
  void drawHealth () {
    pushMatrix ();
    for (int i = 0; i < this.health; i ++) {
      fill ( color (200, 200, 255));
      rect (30, 30, 30, 30);
      translate (40, 0);
    }
    popMatrix ();
  }

  void drawScore () {
    pushMatrix ();
    textSize(64);
    fill (color (255, 255, 255));
    text ("Score " + nf (this.score), width - 250, height - 30);
    popMatrix ();
  }

  void drawChapter () {
    pushMatrix ();
    textSize(64);
    fill (color (255, 255, 255));
    text ("Level " + nf (this.level + 1), 30, height - 30);
    popMatrix ();
  }

  void drawAbilityIcons () {
    pushMatrix ();
      imageMode(CENTER);
      ellipseMode(CENTER);
      translate (50, 100);
      if (this.hasZoomAbility) {
        if (this.zoomAbilityCounter > 0) {
          fill (this.usingZoomAbility ? color (255, 150, 150) : 255);
          circle (0, 0, 50);
        }
  
        image (this.zoomAbilityIcon, 0, 0, 30, 30);
      }
      translate (80, 0);
      if (this.hasTimeAbility) {
        if (this.timeAbilityCounter > 0) {
          fill (this.usingTimeAbility ? color (255, 150, 150) : 255);
          circle (0, 0, 50);
        }
        image (this.timeAbilityIcon, 0, 0, 30, 30);
      }
    popMatrix ();
  }
  
  void loop () {
    background (this.backgroundImage);

    this.starBackground.move ();
    this.starBackground.render ();

    this.aiShip.move (this.usingZoomAbility);
    this.aiShip.render ();
  
    this.ship.move (this.usingZoomAbility);
    this.ship.render ();

    if (this.star.overlaps (this.ship.pos, this.ship.radius)) {
      chime.play ();
      this.star.reset ();
      this.aiShip.moveDown ();
      this.health = min (5, this.health + 1);
      this.score ++;
    
      if (this.score % zoomAbilityThreshold == 0 && this.zoomAbilityCounter <= 0) {
        this.hasZoomAbility = true;
        this.zoomAbilityCounter = 500;
      }
      if (this.score % timeAbilityThreshold == 0 && this.timeAbilityCounter <= 0) {
        this.hasTimeAbility = true;
        this.timeAbilityCounter = 500;
      }
    }
    if (this.star.pos.y > height + 100) {
      this.star.reset ();
      this.aiShip.moveUp ();
      this.health = max (0, this.health - 1);
      this.score = max (0, this.score - 1);
      if (this.health <= 0) {
        this.hasZoomAbility = false;
        this.hasTimeAbility = false;
        this.zoomAbilityCounter = 0;
        this.timeAbilityCounter = 0;
      }
    }
    if (this.aiShip.pos.y > height + this.aiShip.radius) {
      this.aiShip.reset ();
      this.level ++;
      if (this.level % 5 == 0) {
        this.textBubble.currentMessage ++;
        textBubbleCounter = 500;
      }
    }
    this.star.move (this.usingTimeAbility);
    this.star.render ();

    if (textBubbleCounter > 0) {  this.textBubble.render (); }
    textBubbleCounter --;

    this.drawHealth ();
    this.drawScore ();
    this.drawChapter ();
    this.drawAbilityIcons ();

    if (this.usingTimeAbility && this.timeAbilityCounter > 0) {
      this.timeAbilityCounter --;
      if (this.timeAbilityCounter <= 0) {
        this.usingTimeAbility = false;
        this.hasTimeAbility = false;
      }
    }
    if (this.usingZoomAbility && this.zoomAbilityCounter > 0) {
      this.zoomAbilityCounter --;
      if (this.zoomAbilityCounter <= 0) {
        this.usingZoomAbility = false;
        this.hasZoomAbility = false;
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
            println ("going left");
            // go left
            switch (dest) {
              case DEST_CENTER:
                dest = DEST_LEFT;
                println ("left dest: " + nf (leftDest.x) + ", " + nf (leftDest.y));
                this.ship.dest = leftDest;
                break;
              case DEST_RIGHT:
                dest = DEST_CENTER;
                this.ship.dest = centerDest;
                break;
              default:
            }
          } else if (wordSoundsLike (difficulty, rightWordPhonemes, lastWordPhonemes)) {
            println ("going right");
            // go right
            switch (dest) {
              case DEST_CENTER:
                dest = DEST_RIGHT;
                this.ship.dest = rightDest;
                break;
              case DEST_LEFT:
                dest = DEST_CENTER;
                this.ship.dest = centerDest;
                break;
              default:
            }
          } else if (wordSoundsLike (difficulty, timeAbilityWordPhonemes, lastWordPhonemes)) {
            this.usingTimeAbility = true;
          } else if (wordSoundsLike (difficulty, zoomAbilityWordPhonemes, lastWordPhonemes)) {
            this.usingZoomAbility = true;
          }
        }
      }
    }
  }
  
  void render () {
    if (this.level < 16) {
      this.loop ();
    } else {
      this.closing.render ();
      if (slideCounter == 0) {
        this.closing.next ();
        slideCounter = 500;
      } else {
        slideCounter --;
      }
    }
  }
}
