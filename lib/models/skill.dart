import 'package:cloud_firestore/cloud_firestore.dart';

class Skill {
  final String id;
  final String name;
  final String image;

  Skill({required this.id, required this.name, required this.image});

  // vocation for firebase (map)
  Map<String, dynamic> toFirestore() {
    return {'id': id, 'name': name, 'image': image};
  }

  // skill from firestore
  factory Skill.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    // get data from snapshot
    final data = snapshot.data()!;

    // make skill instance
    Skill skill =
        Skill(id: snapshot.id, name: data['name'], image: data['image']);

    print('returning skill: $skill');

    return skill;
  }

  @override
  String toString() {
    return 'name: $name';
  }
}

final List<Skill> predefinedSkills = [
  // algo wizard skills
  Skill(id: '1', name: 'Brute Force Bolt', image: 'bf_bolt.jpg'),
  Skill(id: '2', name: 'Recursive Wave', image: 'r_wave.jpg'),
  Skill(id: '3', name: 'Hash Beam', image: 'h_beam.jpg'),
  Skill(id: '4', name: 'Backtrack', image: 'backtrack.jpg'),

  // terminal raider skills
  Skill(id: '5', name: 'Lethal Touch', image: 'l_touch.jpg'),
  Skill(id: '6', name: 'Sudo Blast', image: 's_blast.jpg'),
  Skill(id: '7', name: 'Full Clear', image: 'f_clear.jpg'),
  Skill(id: '8', name: 'Support Shell', image: 's_shell.jpg'),

  // code junkie skills
  Skill(id: '9', name: 'Infinite Loop', image: 'i_loop.jpg'),
  Skill(id: '10', name: 'Type Cast', image: 't_cast.jpg'),
  Skill(id: '11', name: 'Encapsulate', image: 'encapsulate.jpg'),
  Skill(id: '12', name: 'Copy & Paste', image: 'c_paste.jpg'),

  // ux ninja skills
  Skill(id: '13', name: 'Gamify', image: 'gamify.jpg'),
  Skill(id: '14', name: 'Heat Map', image: 'h_map.jpg'),
  Skill(id: '15', name: 'Wireframe', image: 'wireframe.jpg'),
  Skill(id: '16', name: 'Dark Pattern', image: 'd_pattern.jpg'),
];
