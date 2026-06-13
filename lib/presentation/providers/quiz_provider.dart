import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/models/quiz_model.dart';

class QuizProvider extends ChangeNotifier {
  List<QuizModel> _allQuestions = [];
  List<QuizModel> _activeQuestions = [];
  int _currentIndex = 0;
  int _score = 0;
  bool _isComplete = false;
  int? _selectedAnswer;
  bool _answered = false;
  String _selectedDifficulty = 'all';
  String _selectedCategory = 'all';
  bool _isLoading = false;

  List<QuizModel> get questions => _activeQuestions;
  int get currentIndex => _currentIndex;
  int get score => _score;
  bool get isComplete => _isComplete;
  int? get selectedAnswer => _selectedAnswer;
  bool get answered => _answered;
  String get selectedDifficulty => _selectedDifficulty;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  int get totalQuestions => _activeQuestions.length;
  QuizModel? get currentQuestion =>
      _activeQuestions.isEmpty ? null : _activeQuestions[_currentIndex];
  double get progressPercent =>
      _activeQuestions.isEmpty ? 0 : (_currentIndex + 1) / _activeQuestions.length;

  Future<void> loadQuestions({String difficulty = 'all', String category = 'all'}) async {
    _isLoading = true;
    _selectedDifficulty = difficulty;
    _selectedCategory = category;
    notifyListeners();

    if (_allQuestions.isEmpty) {
      final jsonString = await rootBundle.loadString('assets/data/quiz/all_questions.json');
      final jsonList = jsonDecode(jsonString) as List;
      _allQuestions = jsonList.map((e) => QuizModel.fromJson(e as Map<String, dynamic>)).toList();
    }

    _activeQuestions = _allQuestions.where((q) {
      final diffMatch = difficulty == 'all' || q.difficulty == difficulty;
      final catMatch = category == 'all' || q.fraudType == category;
      return diffMatch && catMatch;
    }).toList()..shuffle();

    if (_activeQuestions.length > 50) {
      _activeQuestions = _activeQuestions.take(10).toList();
    }

    _currentIndex = 0;
    _score = 0;
    _isComplete = false;
    _selectedAnswer = null;
    _answered = false;
    _isLoading = false;
    notifyListeners();
  }

  void selectAnswer(int index) {
    if (_answered) return;
    _selectedAnswer = index;
    _answered = true;
    if (index == _activeQuestions[_currentIndex].correctIndex) {
      _score++;
    }
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentIndex < _activeQuestions.length - 1) {
      _currentIndex++;
      _selectedAnswer = null;
      _answered = false;
    } else {
      _isComplete = true;
    }
    notifyListeners();
  }

  void resetQuiz() {
    loadQuestions(difficulty: _selectedDifficulty, category: _selectedCategory);
  }
}
