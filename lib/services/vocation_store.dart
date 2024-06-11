import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rpg/services/firestore_service.dart';

class VocationStore extends ChangeNotifier {
  final List<Vocation> _predefinedVocations = vocationsPredefined;
  final List<Vocation> _userdefinedVocations = [];

  List<Vocation> get vocations =>
      [..._predefinedVocations, ..._userdefinedVocations];
  List<Vocation> get userdefinedVocations => _userdefinedVocations;

  // VOCATIONS

  // initially fetch vocations
  void fetchVocationsOnce() async {
    if (userdefinedVocations.isEmpty) {
      final snapshot = await FirestoreService.getVocations();

      for (var doc in snapshot.docs) {
        _userdefinedVocations.add(doc.data());
      }

      notifyListeners();
    }
  }

  // create vocation
  Vocation addVocation(Vocation vocation) {
    FirestoreService.addVocation(vocation);
    _userdefinedVocations.add(vocation);
    notifyListeners();
    return vocation;
  }

  // remove vocation
  void removeVocation(Vocation vocation) async {
    await FirestoreService.deleteVocation(vocation);

    _userdefinedVocations.remove(vocation);
    notifyListeners();
  }
}
