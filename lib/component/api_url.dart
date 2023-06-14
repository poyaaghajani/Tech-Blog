class ApiUrl {
  ApiUrl._();

  static const hostDlUrl = 'https://techblog.sasansafari.com';
  static const baseUrl = 'https://techblog.sasansafari.com/Techblog/api/';
  static const getHomeItems = '${baseUrl}home?command=index';
  static const getArticleList =
      '${baseUrl}article/get.php?command=new&user_id=1';
  static const postRegister = '${baseUrl}register/action.php';
  static const publishedByMe =
      '${baseUrl}article/get.php?command=published_by_me&user_id=';
  static const articlePost = '${baseUrl}article/post.php';
  static const podcastFiles =
      '${baseUrl}podcast/get.php?command=get_files&podcats_id=';
}
