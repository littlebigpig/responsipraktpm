import 'package:flutter/material.dart';
import 'package:tugas3prak/models/movie_model.dart';
import 'package:tugas3prak/presenter/movie_presenter.dart';
import 'package:tugas3prak/views/movie_detail.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen>
    implements MovieView {
  late MoviePresenter _presenter;
  bool _isLoading = false;
  List<Movie> _movieList = [];
  String? _errorMessage;
  final String _currentEndpoint = 'movie';

  @override
  void initState() {
    super.initState();
    _presenter = MoviePresenter(this);
    _presenter.loadMovieData(_currentEndpoint);
  }

  //void _fetchData(String endpoint) {
  //  setState(() {
  //    _currentEndpoint = endpoint;
  //    _presenter.loadMovieData(endpoint);
  //  });
  //}

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showMovieList(List<Movie> movieList) {
    setState(() {
      _movieList = movieList;
    });
  }

  @override
  void showError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movie List")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //children: [
            //  ElevatedButton(onPressed: () => _fetchData('characters'), child: Text("Characters")),
            //   SizedBox(width: 10,),
            //  ElevatedButton(onPressed: () => _fetchData('akatsuki'), child: Text("Akatsuki")),
            //   SizedBox(width: 10,),
            //   ElevatedButton(onPressed: () => _fetchData('kara'), child: Text("Kara"))
            // ]
          ),

          Expanded(
            child:
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _errorMessage != null
                    ? Center(child: Text("Error ${_errorMessage}"))
                    : ListView.builder(
                      itemCount: _movieList.length,
                      itemBuilder: (context, index) {
                        final movie = _movieList[index];
                        return ListTile(
                          leading:
                              movie.imgUrl.isNotEmpty
                                  ? Image.network(movie.imgUrl)
                                  : Image.network(
                                    'https:/placehold.co/600x400',
                                  ),
                          title: Text(movie.title),
                          subtitle: Text(movie.rating),
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(id: "movie.id", endpoint: _currentEndpoint)));
                          },
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
