final int avatarImageHeight = 100;

final int maxTextBubbleCounter = 500;
int textBubbleCounter = maxTextBubbleCounter;


class TextBubble {
  int currentMessage = 0;
  String[] textBubbleMessages;
  PImage[] avatars;
  
  TextBubble (JSONArray prompts) {
    textBubbleMessages = new String [prompts.size ()];
    avatars = new PImage [prompts.size ()];
    for (int i = 0; i < prompts.size (); i ++) {
      JSONObject prompt = prompts.getJSONObject (i);
      textBubbleMessages[i] = prompt.getString ("message");
      avatars[i] = loadImage (prompt.getString ("avatar"));
    }
  }
  
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
      image (avatars [this.currentMessage], textBubbleWidth/2, 2 * padding + (avatarImageHeight / 2));
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
