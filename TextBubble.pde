final int avatarImageHeight = 100;

String[] textBubbleMessages = {
  "The race is on! May the best space pilot win!",
  "Bah! You have passed many racers, but you won't catch me!",
  "I see that you have made it! Finally, we can see who's the better pilot!",
  "No!!! How have you beat me!?"
};

int textBubbleCounter = 500;

class TextBubble {
  int currentMessage = 0;
  PImage avatar = loadImage ("boss_avatar.png");
 
  void render () {
    if (currentMessage < textBubbleMessages.length) {
      final int textBubbleWidth = 300;
      final int textBubbleHeight = 500;
      final int padding = 30;
      pushMatrix ();
      translate (width - textBubbleWidth - padding, padding);
      fill (40, 4, 102);
      rect (0, 0, textBubbleWidth, textBubbleHeight);
      imageMode (CENTER);
      image (avatar, textBubbleWidth/2, 2 * padding + (avatarImageHeight / 2));
      fill (96, 37, 157);
      rect (padding, 2*padding + avatarImageHeight, textBubbleWidth - 2*padding, textBubbleHeight - 3*padding - avatarImageHeight);
      fill (255);
      textSize(24);
      text (textBubbleMessages [this.currentMessage], 2*padding,
        3*padding + avatarImageHeight,
        textBubbleWidth - 4*padding,
        textBubbleHeight - 4*padding - avatarImageHeight
      );
      popMatrix ();
    }
  }
}