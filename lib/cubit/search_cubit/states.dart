abstract class SearchStates {}

class SearchInitalState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessgState extends SearchStates {}

class SearchErrorState extends SearchStates {
  String? error;
  SearchErrorState(this.error);
}
