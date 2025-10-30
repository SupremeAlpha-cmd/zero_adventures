import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:zero_adventures/mock_data.dart';

class Api {
  Future<List<Story>> getTopRatedStories() async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));

    // In a real app, you would make an API call here.
    // For now, we'll just return the mock data.
    return topRatedStories;
  }

  Future<List<Story>> getLatestReleases() async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));

    // In a real app, you would make an API call here.
    // For now, we'll just return the mock data.
    return latestReleases;
  }

  Future<List<Story>> getStoriesBySubCategory(String subCategory) async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Filter the stories based on the sub-category
    return allStories
        .where((story) =>
            story.subCategory.toLowerCase() == subCategory.toLowerCase())
        .toList();
  }
}
