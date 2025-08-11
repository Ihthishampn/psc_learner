import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../features/profile/providers/provider_sort.dart';

// Provider to handle anonymous sign-in and ensure user is authenticated
final firebaseAuthProvider = FutureProvider<User>((ref) async {
  final auth = FirebaseAuth.instance;

  if (auth.currentUser == null) {
    final userCredential = await auth.signInAnonymously();
    return userCredential.user!;
  }
  return auth.currentUser!;
});

final fetchProgressProvider = StateProvider<double>((ref) => 0);

final questionsProvider = FutureProvider.family<List<Map<String, dynamic>>, Level>((ref, level) async {
  final box = await Hive.openBox('questions');
  final key = level.name;

  // Try to get from Hive first
  if (box.containsKey(key)) {
    final cachedData = box.get(key);
    if (cachedData != null && cachedData is List && cachedData.isNotEmpty) {
      print("📦 Using cached questions for $key");
      return List<Map<String, dynamic>>.from(cachedData);
    }
  }

  // If not in Hive or empty, fetch from Firebase
  print("🔥 Fetching questions from Firebase for $key");
  ref.read(fetchProgressProvider.notifier).state = 0;
  
  try {
    final firestore = FirebaseFirestore.instance;
    final querySnapshot = await firestore
        .collection('questions_$key')
        .orderBy('id')
        .get();

    final questions = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'question': data['question'] ?? '',
        'options': List<String>.from(data['options'] ?? []),
        'answer': data['answer'] ?? '',
        'id': doc.id, // Include document ID if needed
      };
    }).toList();

    // Update progress
    ref.read(fetchProgressProvider.notifier).state = 100;
    
    // Save to Hive
    await box.put(key, questions);
    print("💾 Saved ${questions.length} questions to Hive for $key");
    
    return questions;
  } catch (e) {
    print("❌ Error fetching questions: $e");
    ref.read(fetchProgressProvider.notifier).state = 0;
    throw Exception('Failed to load questions');
  }
});