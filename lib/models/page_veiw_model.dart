class PagesViewModel {
  final String image;
  final String title;
  final String body;
  PagesViewModel(
      {required this.image, required this.title, required this.body});
}

List<PagesViewModel> items = [
  PagesViewModel(
      image: "assets/images/board1.png",
      title: "Purchase Your Items online",
      body:
          "Our new service makes it easy for you to shopping anywhere, these are new features will really help you"),
  PagesViewModel(
      image: "assets/images/board2.png",
      title: "Choose in store pick up",
      body:
          "Our new service makes it easy for you to shopping anywhere, these are new features will really help you"),
  PagesViewModel(
      image: "assets/images/board3.png",
      title: "Looking for items",
      body:
          "Our new service makes it easy for you to shopping anywhere, these are new features will really help you"),
];
