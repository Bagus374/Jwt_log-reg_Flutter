import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Movie extends Equatable {
  final String url;
  final int id;
  final String challengeMaker;
  final String title;
  final String titleSlug;
  final String reward;
  final String image;
  final bool isFeatured;
  final bool isCompleted;
  final double taskCount;

  Movie(
      {
      @required this.url,
      @required this.id,
      @required this.challengeMaker,
      @required this.title,
      @required this.titleSlug,
      @required this.reward,
      @required this.image,
      @required this.isFeatured,
      @required this.isCompleted,
      @required this.taskCount,
      });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
      url: json['url'],
      id: json['id'],
      challengeMaker: json['challengeMaker'],
      title: json['title'],
      titleSlug: json['titleSlug'],
      reward: json['reward'],
      image: json['image'],
      isFeatured: json['isFeatured'],
      isCompleted: json['isCompleted'],
      taskCount: (json['taskCount'] as num).toDouble(),
      );

  @override
  List<Object> get props =>
      [url, id, challengeMaker, title, titleSlug, reward, image, isFeatured, isCompleted, taskCount];

}
