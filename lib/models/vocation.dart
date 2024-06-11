import 'package:cloud_firestore/cloud_firestore.dart';

class Vocation {
  Vocation(
      {required this.id,
      required this.name,
      required this.title,
      required this.description,
      required this.image,
      required this.weapon,
      required this.ability,
      this.skillIds = const []});

  final String id;
  final String name;
  final String title;
  final String description;
  final String image;
  final String weapon;
  final String ability;
  List<String> skillIds;

  // vocation for firebase (map)
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'description': description,
      'weapon': weapon,
      'ability': ability,
      'image': image,
      'skillIds': skillIds
    };
  }

  // vocation from firestore
  factory Vocation.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    // get data from snapshot
    final data = snapshot.data()!;

    // make vocation instance
    Vocation vocation = Vocation(
        id: snapshot.id,
        name: data['name'],
        title: data['title'],
        description: data['description'],
        weapon: data['weapon'],
        ability: data['ability'],
        image: data['image'],
        skillIds: data['skillIds'].cast<String>());

    print('returning vocation: $vocation');

    return vocation;
  }

  @override
  String toString() {
    return 'name: $name';
  }
}

final List<Vocation> vocationsPredefined = [
  Vocation(
      id: '4',
      name: 'wizard',
      title: 'Wizard',
      description: 'fooo',
      weapon: 'terminal',
      ability: 'shell shock',
      image: 'algo_wizard.jpg',
      skillIds: ['1', '2', '3', '4']),
  Vocation(
      id: '1',
      name: 'raider',
      title: 'Terminal Raider',
      description: 'fooo',
      weapon: 'terminal',
      ability: 'shell shock',
      image: 'terminal_raider.jpg',
      skillIds: ['5', '6', '7', '8']),
  Vocation(
      id: '2',
      name: 'junkie',
      title: 'Code junkie',
      description: 'fooo',
      weapon: 'terminal',
      ability: 'shell shock',
      image: 'code_junkie.jpg',
      skillIds: ['9', '10', '11', '12']),
  Vocation(
      id: '3',
      name: 'ninja',
      title: 'UX Nija',
      description: 'fooo',
      weapon: 'terminal',
      ability: 'shell shock',
      image: 'ux_ninja.jpg',
      skillIds: ['13', '14', '15', '16']),
];
