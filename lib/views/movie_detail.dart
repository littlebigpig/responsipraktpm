import 'package:flutter/material.dart';
import 'package:tugas3prak/network/base_network.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final String endpoint;
  const DetailScreen({super.key, required this.id, required this.endpoint});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _detailData;
  String? _errorMessage; 
  
  @override
  void initState(){
    super.initState();
    _fetchDetailData();
  }

  Future<void> _fetchDetailData() async{
    try {
      final data = await BaseNetwork.getDetailData(widget.endpoint, widget.id as String);
      setState(() {
        _detailData = data;
        _isLoading = false;
      });
    } catch(e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Detail"),),
    body: _isLoading
    ? Center(child: CircularProgressIndicator())
    : _errorMessage != null
    ? Center(child: Text("Errorp ${_errorMessage}"))
    :_detailData != null
    ?Column(
      children: [
        Image.network(_detailData!['images'] [0] ?? 'https:/placehold.co/600x400'),
        Text("Name : ${_detailData!['name']}"),
        Text("Kekkei Genkai :  ${_detailData!['personal'] ["kekkaiGenkai"] ?? 'Empty'}"),
        Text("Titles : ${_detailData!['personal'] ['titles'] ?? 'Empty'}"),
        Text("Family : ${_detailData!['family'] ?? 'Empty'}"),
        Text("Appears In : ${_detailData!['debut'] ['appearsIn']}")
      ],
    ) 
    : Text("No Data")
    
    );
  }
}