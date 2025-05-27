import 'package:flutter/material.dart';
import 'package:tugas3prak/models/movie_model.dart';
import 'package:tugas3prak/network/base_network.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final String endpoint;

  const DetailScreen({
    Key? key,
    required this.id,
    required this.endpoint,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isLoading = true;
  Movie? _movie;
  String? _errorMessage;
  Map<String, dynamic>? _rawData;

  @override
  void initState() {
    super.initState();
    _loadMovieDetail();
  }

  Future<void> _loadMovieDetail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final data = await BaseNetwork.getDetailData(widget.endpoint, widget.id);
      _rawData = data;
      setState(() {
        try {
          _movie = Movie.fromJson(data);
        } catch (e) {
          throw Exception('Failed to parse movie data: $e');
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(_movie?.title ?? 'Movie Detail')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.grey))
          : _errorMessage != null
              ? Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Error: $_errorMessage',
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      SizedBox(height: 16),
                      if (_rawData != null)
                        Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.grey[100],
                          child: Text(
                            'Raw Data: $_rawData',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[400],
                          foregroundColor: Colors.black,
                        ),
                        onPressed: _loadMovieDetail,
                        child: Text("Try Again"),
                      )
                    ],
                  ),
                )
              : _buildDetailContent(),
    );
  }

  Widget _buildDetailContent() {
    if (_movie == null) {
      return Center(
        child: Text(
          "No data",
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.all(12),
      children: [
        Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey[200],
          child: _movie!.imgUrl.isNotEmpty
              ? Image.network(
                  _movie!.imgUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: Text(
                          'No Image',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'No Image',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
        ),

        SizedBox(height: 16),

        Text(
          _movie!.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        
        SizedBox(height: 8),
        
        Text(
          'Rating: ${_movie!.rating}',
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),

        SizedBox(height: 16),

        // Basic info
        Container(
          padding: EdgeInsets.all(8),
          color: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Release: ${_movie!.createdAt}', style: TextStyle(fontSize: 13)),
              Text('Duration: ${_movie!.duration}', style: TextStyle(fontSize: 13)),
              Text('Language: ${_movie!.language}', style: TextStyle(fontSize: 13)),
            ],
          ),
        ),

        SizedBox(height: 16),

        Text(
          'Director:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(
          _movie!.director,
          style: TextStyle(fontSize: 14),
        ),

        SizedBox(height: 12),

        Text(
          'Genre:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(
          _movie!.genre.join(', '),
          style: TextStyle(fontSize: 14),
        ),

        SizedBox(height: 12),

        Text(
          'Cast:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(
          _movie!.cast.join(', '),
          style: TextStyle(fontSize: 14),
        ),

        SizedBox(height: 12),

        Text(
          'Description:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.all(8),
          color: Colors.grey[50],
          child: Text(
            _movie!.description,
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}