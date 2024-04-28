class Quote {
  String text;
  String author;

  Quote({required this.text, required this.author});
}

List<String> quotes = [
  "If the Negro cannot stand on his own two feet, then let him fall",
  "It is better to die on our feet than live on our knees for fear of colonial rule",
  "The only legitimate antidote for self-doubt and the shameful weakness it breeds is joyful self-acceptance",
  "It is much easier to show compassion to animals. They are never wicked",
  "A deception that elevates us is dearer than a host of low truths",
  "What I've come to learn in my long life is that ignorance is not bliss; it is time consuming and costly as hell",
  "I am not proud, but I am happy; and happiness blinds, I think, more than pride",
  "I have never understood why it is \"greed\" to want to keep the money you have earned but not greed to want to take somebody else's money",
  "The Black skin is not a badge of shame, but rather a glorious symbol of national greatness",
  'Mũceera na mũkũndũ akũndũkaga o ta guo',
  "You're not to be so blind with patriotism that you can't face reality. Wrong is wrong, no matter who does it or says it",
  "The white man is very clever. He came quietly and peaceably with his religion. We were amused at his foolishness and allowed him to stay. Now he has won our brothers, and our clan can no longer act like one. He has put a knife on the things that held us together and we have fallen apart",
  "Mtoto wa nyoka ni nyoka",
  "Gĩkũyũ kĩũĩ kũhitha ndĩa; gĩtiũĩ kũhitha ũhoro",
];
List<String> authors = [
  "Fredrick Douglass",
  "Dedan Kĩmathi",
  "Idi Amin",
  "Haile Selassie",
  "Alexander Pushkin",
  "Dick Gregory",
  "Alexandre Dumas",
  "Thomas Sowell",
  "Marcus Garvey",
  "Gĩkũyũ Proverb",
  "Malcom X",
  "Chinua Achebe",
  "Swahili Proverb",
  "Gĩkũyũ Proverb",
];
createArrayOfObjects(List<String> texts, List<String> authors){
  assert(texts.length==authors.length, "both arrays must be of the same length");
  Iterator<String> textIterator = texts.iterator;
  Iterator<String> authorIterator = authors.iterator;
  List<Map<String, String>> result = [];

  while(textIterator.moveNext() && authorIterator.moveNext()){
    result.add({
      "text": textIterator.current,
      "author": authorIterator.current,
    });
  }
  return result;
}

createArrayOfQuotesUsingClass(List<String> texts, List<String> authors){
  assert(texts.length==authors.length, "both arrays must be of the same length");
  Iterator<String> textIterator = texts.iterator;
  Iterator<String> authorIterator = authors.iterator;
  List<Quote> result = [];

  while(textIterator.moveNext() && authorIterator.moveNext()){
    result.add(Quote(text: textIterator.current, author: authorIterator.current));
  }
  return result;
}

List<Map<String, String>> testQuotes = createArrayOfObjects(quotes, authors);
List<Quote> testQuotesUsingClass = createArrayOfQuotesUsingClass(quotes, authors);
