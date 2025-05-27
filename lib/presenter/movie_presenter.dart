import 'package:tugas3prak/models/movie_model.dart';
import 'package:tugas3prak/network/base_network.dart';

abstract class MovieView{
  void showLoading();
  void hideLoading();
  void showMovieList(List<Movie> movieList);
  void showError(String message);
}

class MoviePresenter {
  final MovieView view;
  MoviePresenter(this.view);

  Future<void>loadMovieData(String endpoint) async{
    try {
      view.showLoading();
      final List<dynamic> data = await BaseNetwork.getData(endpoint);
      final movieList = data.map((json)=> Movie.fromJson(json)).toList();
      view.showMovieList(movieList);
    } catch (e) {
      view.showError(e.toString());
    } finally {
      view.hideLoading();
    }
  }
}
