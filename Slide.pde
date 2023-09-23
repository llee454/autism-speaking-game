int slideCounter = 500;

class Slide {
  int currentMessage = 0;
  JSONArray slides;
  
  Slide (JSONArray slides) {
    this.slides = slides;
  }
  
  void next () {
    if (this.currentMessage < this.slides.size () - 1) {
      this.currentMessage ++;
    }
  }
  
  void render () {
    JSONObject slide = this.slides.getJSONObject (this.currentMessage);
    pushMatrix ();
    if (slide.isNull ("background")) {
      background (40, 4, 102);
    } else {
      background (loadImage (slide.getString ("background")));
    }
    if (!slide.isNull ("avatar")) {
      imageMode (CORNER);
      image (loadImage (slide.getString ("avatar")), 100, 100);
    }
    if (!slide.isNull ("message")) {
      int leftPadding = slide.isNull ("avatar") ? 100 : 400;
      fill (255);
      textSize (24);
      text (slide.getString ("message"), leftPadding + 50, 150, width - 200 - leftPadding, height - 300);
    }
    popMatrix ();
  }
}
