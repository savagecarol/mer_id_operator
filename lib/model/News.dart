class News {
  late String hindi;
  late String english;

  Language({required String english, required String hindi}) {
    this.english = english;
    this.hindi = hindi;
  }
}
// https://newsapi.org/v2/top-headlines?country=in&q=government&apiKey=b959933666884935be61f74caa1c9a9b
