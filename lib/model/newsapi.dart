class Article {
 late String author;
  late String title;
  late String description;
  late String url;
  late String urlToImage;
  late String publishedAt;
 late String content;

  Article( this.author, this.title, this.description, this.url,
      this.urlToImage, this.publishedAt, this.content);
}



// class NewsApi {
// late String status;
// late bool totalResults;
// late List<Article> articles;
// NewsApi(this.status,this.totalResults,this.articles);
// }


// class Source {
//   String? id;
//   String? name;
//
//   Source(this.id, this.name);
// }