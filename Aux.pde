
boolean array_contains (String[] xs, String x) {
  for (int i = 0; i < xs.length - 1; i ++) {
    if (x.equals (xs [i])) { return true; }
  }
  return false;
}

String interpolate (String[] xs, String delimiter) {
  String result = "";
  for (int i = 0; i < xs.length; i ++) {
    result = result + xs [i] + (i < xs.length - 1 ? delimiter : ""); 
  }
  return result;
}

String[] prepend (String[] xs, String x) {
  String[] result = new String [xs.length + 1];
  result[0] = x;
  for (int i = 0; i < xs.length; i ++) {
    result[i + 1] = xs[i]; 
  }
  return result;
}

/*
  Accepts two phonemes and returns true iff they sound alike.
*/
boolean phonemeSoundsLike (String x, String y) {
  switch (x) {
    case "d":
    case "t":
      return y.equals ("d") || y.equals ("t");
    case "ae":
    case "eh":
      return y.equals ("ae") || y.equals ("eh");
  };
  return x.equals (y);
}

/*
  Accepts the phonemes of two different words and returns true
  iff they "sound alike."
*/
boolean wordSoundsLike (float threshold, String[] reference, String[] phonemes) {
  int numMatching = 0;
  int numPhonemes = reference.length;
  for (int i = 0; i < min (numPhonemes, phonemes.length); i ++) {
    if (phonemeSoundsLike (reference[i], phonemes[i])) {
      numMatching ++;
    }
  }
  return threshold <= (numMatching / numPhonemes);
}
