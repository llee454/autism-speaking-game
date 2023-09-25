/*
  This class defines the Game state.
*/

// Track spoken text.
int numLines = 0;
int numWords = 0;

final int numRacersPerMessage = 3;

final int PHASE_INTRO = 0;
final int PHASE_GAME = 1;
final int PHASE_CLOSE = 2;
int phase = PHASE_INTRO;

final int DEST_CENTER = 0;
final int DEST_LEFT = 1;
final int DEST_RIGHT = 2;
int dest = DEST_CENTER;

final int zoomAbilityThreshold = 5;
final int timeAbilityThreshold = 10;

final int maxZoomAbilityCounter = 500;
final int maxTimeAbilityCounter = 500;

int zoomAbilityCounter = 0;
int timeAbilityCounter = 0;

class Game {
  JSONObject missions = loadJSONObject ("missions.json");
  JSONObject currMission;
  JSONObject currLevel;
  int missionIndex = 0;
  
  final PVector leftDest = new PVector (width/5, 3*height/4);
  final PVector rightDest = new PVector (4*width/5, 3*height/4);
  final PVector centerDest = new PVector (width/2, 3*height/4);
  
  PImage backgroundImage = loadImage ("background.jpg");
  Background starBackground  = new Background ();
  Slide intro;
  Slide closing;
  
  Ship ship;
  Star star = new Star ();
  AIShip aiShip;
  TextBubble textBubble;
  
  int level = 0;
  int health = 5;
  int score = 0;
  PImage zoomAbilityIcon;
  PImage timeAbilityIcon;
  boolean hasZoomAbility = false;
  boolean hasTimeAbility = false;
  boolean usingZoomAbility = false;
  boolean usingTimeAbility = false;

  Game () {
    this.zoomAbilityIcon = loadImage ("zoom_icon.png");
    this.timeAbilityIcon = loadImage ("time_icon.png");
    startChapter ();
  }

  void startLevel () {
    textBubbleCounter = maxTextBubbleCounter;
    this.currLevel = currMission.getJSONArray ("levels").getJSONObject (level);
    if (!this.currLevel.isNull ("ai_ship")) {
      this.aiShip = new AIShip (loadImage (this.currLevel.getString ("ai_ship")));
    }
    if (!this.currLevel.isNull ("message")) {
      this.textBubble = new TextBubble (
        loadImage (this.currLevel.getString ("avatar")),
        this.currLevel.getString ("message")
      );
    }
  }
  
  int getNumLevels () {
    return currMission.getJSONArray ("levels").size ();
  }
  
  boolean isLastLevel () {
    return this.level == getNumLevels () - 1;
  }
  
  void nextLevel () {
    if (this.level < getNumLevels ()) {
      this.level ++;
      startLevel ();
    }
  }
  
  void startChapter () {
    this.level = 0;
    this.score = 0;
    this.currMission = missions.getJSONArray ("missions").getJSONObject (missionIndex);
    this.currLevel = currMission.getJSONArray ("levels").getJSONObject (level);
    this.ship = new Ship (loadImage (currMission.getString ("ship")));
    this.intro = new Slide (currMission.getJSONArray ("intro"));
    this.closing = new Slide (currMission.getJSONArray ("closing"));
    this.startLevel ();
  }
  
  void nextChapter () {
    if (this.missionIndex <= this.missions.size () - 1) {
      phase = PHASE_INTRO;
      this.missionIndex ++;
      startChapter ();
    }
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
        if (zoomAbilityCounter > 0) {
          fill (this.usingZoomAbility ? color (255, 150, 150) : 255);
          circle (0, 0, 50);
        }
  
        image (this.zoomAbilityIcon, 0, 0, 30, 30);
      }
      translate (80, 0);
      if (this.hasTimeAbility) {
        if (timeAbilityCounter > 0) {
          fill (this.usingTimeAbility ? color (255, 150, 150) : 255);
          circle (0, 0, 50);
        }
        image (this.timeAbilityIcon, 0, 0, 30, 30);
      }
    popMatrix ();
  }
  
  void loop () {
    background (this.backgroundImage);

    this.starBackground.move (this.usingZoomAbility);
    this.starBackground.render ();

    if (this.aiShip != null) {
      this.aiShip.move (this.usingZoomAbility);
      this.aiShip.render ();
    }
    this.ship.move (this.usingZoomAbility);
    this.ship.render (this.usingZoomAbility);

    if (this.star.overlaps (this.ship.pos, this.ship.radius)) {
      chime.play ();
      this.star.reset ();
      if (this.aiShip != null) {
        this.aiShip.moveDown ();
      }
      this.health = min (5, this.health + 1);
      this.score ++;
    
      if (this.score % zoomAbilityThreshold == 0 && zoomAbilityCounter <= 0) {
        this.hasZoomAbility = true;
        zoomAbilityCounter = maxZoomAbilityCounter;
      }
      if (this.score % timeAbilityThreshold == 0 && timeAbilityCounter <= 0) {
        this.hasTimeAbility = true;
        timeAbilityCounter = maxTimeAbilityCounter;
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
        zoomAbilityCounter = 0;
        timeAbilityCounter = 0;
      }
    }
    this.star.move (this.usingTimeAbility);
    this.star.render ();

    if (this.textBubble != null) {  this.textBubble.render (); }

    this.drawHealth ();
    this.drawScore ();
    this.drawChapter ();
    this.drawAbilityIcons ();

    if (this.usingTimeAbility && timeAbilityCounter > 0) {
      timeAbilityCounter --;
      if (timeAbilityCounter == 0) {
        this.usingTimeAbility = false;
        this.hasTimeAbility = false;
      }
    }
    if (this.usingZoomAbility && zoomAbilityCounter > 0) {
      zoomAbilityCounter --;
      if (zoomAbilityCounter == 0) {
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
          } else if (this.hasTimeAbility && wordSoundsLike (difficulty, timeAbilityWordPhonemes, lastWordPhonemes)) {
            this.usingTimeAbility = true;
          } else if (this.hasZoomAbility && wordSoundsLike (difficulty, zoomAbilityWordPhonemes, lastWordPhonemes)) {
            this.usingZoomAbility = true;
          }
        }
      }
    }
    if (this.aiShip != null && this.aiShip.pos.y > height + this.aiShip.radius) {
      this.nextLevel ();
    }
  }
  
  void render () {

    switch (phase) {
      case PHASE_INTRO:
        this.intro.render ();
        if (slideCounter == 0) {
          if (this.intro.currentMessage >= this.intro.slides.size () - 1) {
            phase ++;
          }
          this.intro.next ();
          slideCounter = maxSlideCounter;
        } else {
          slideCounter --;
        }
        break;
      case PHASE_GAME:
        if (this.isLastLevel () && textBubbleCounter == 0) {
          phase ++;
        } else {
          this.loop ();
        }
        break;
      default:
        this.closing.render ();
        if (slideCounter == 0) {
            println ("Done slide");
          if (this.closing.currentMessage == this.closing.slides.size () - 1) {
            println ("Next chapter");
            this.nextChapter ();
          } else {
            this.closing.next ();
            slideCounter = 10;
          }
        } else {
          slideCounter --;
        }
   }
  }
}
