import 'package:flutter/material.dart';
import 'package:rx_dart_tut/bloc/search_result.dart';
import 'package:rx_dart_tut/models/animal.dart';
import 'package:rx_dart_tut/models/person.dart';

class SearchResultView extends StatelessWidget {
  final Stream<SearchResult?> searchResult;
  const SearchResultView({super.key, required this.searchResult});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchResult?>(
      stream: searchResult,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final result = snapshot.data;
          if (result is SearchResultHasError) {
            return const Text("Got error");
          } else if (result is SearchResultLoading) {
            return const CircularProgressIndicator();
          } else if (result is SearchResultNoResult) {
            return const Text(
              "No results found for your search term. Try with another one!",
            );
          } else if (result is SearchResultWithResults) {
            final results = result.results;
            return Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final String title;
                  final item = results[index];
                  if (item is Animal) {
                    title = 'Animal';
                  } else if (item is Person) {
                    title = "Person";
                  } else {
                    title = "Unknown";
                  }
                  return ListTile(
                    title: Text(title),
                    subtitle: Text(item.toString()),
                  );
                },
              ),
            );
          } else {
            return const Text("Unknown state");
          }
        } else {
          return const Text("Waiting");
        }
      },
    );
  }
}
