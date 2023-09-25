final int avatarImageHeight = 100;

final int maxTextBubbleCounter = 500;
int textBubbleCounter = maxTextBubbleCounter;

class TextBubble {
  PImage avatar;
  String message;
  
  TextBubble (PImage avatar, String message) {
    this.avatar = avatar;
    this.message = message;
  }

  void render () {
    if (textBubbleCounter > 0) {
      final int textBubbleWidth = 300;
      final int textBubbleHeight = 500;
      final int padding = 30;
      pushMatrix ();
      translate (width - textBubbleWidth - padding, padding);
      fill (40, 4, 102);
      rect (0, 0, textBubbleWidth, textBubbleHeight);
      imageMode (CENTER);
      image (this.avatar, textBubbleWidth/2, 2 * padding + (avatarImageHeight / 2));
      fill (96, 37, 157);
      rect (padding, 2*padding + avatarImageHeight, textBubbleWidth - 2*padding, textBubbleHeight - 3*padding - avatarImageHeight);
      fill (255);
      textSize(24);
      text (this.message, 2*padding,
        3*padding + avatarImageHeight,
        textBubbleWidth - 4*padding,
        textBubbleHeight - 4*padding - avatarImageHeight
      );
      popMatrix ();
      textBubbleCounter --;
    }
  }
}
