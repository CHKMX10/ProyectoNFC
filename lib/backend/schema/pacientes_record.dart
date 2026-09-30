import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PacientesRecord extends FirestoreRecord {
  PacientesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "nume" field.
  String? _nume;
  String get nume => _nume ?? '';
  bool hasNume() => _nume != null;

  // "job" field.
  String? _job;
  String get job => _job ?? '';
  bool hasJob() => _job != null;

  // "instAfil" field.
  String? _instAfil;
  String get instAfil => _instAfil ?? '';
  bool hasInstAfil() => _instAfil != null;

  // "nss" field.
  String? _nss;
  String get nss => _nss ?? '';
  bool hasNss() => _nss != null;

  // "gener" field.
  String? _gener;
  String get gener => _gener ?? '';
  bool hasGener() => _gener != null;

  // "calleNum" field.
  String? _calleNum;
  String get calleNum => _calleNum ?? '';
  bool hasCalleNum() => _calleNum != null;

  // "colCp" field.
  String? _colCp;
  String get colCp => _colCp ?? '';
  bool hasColCp() => _colCp != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  bool hasCity() => _city != null;

  // "sangre" field.
  String? _sangre;
  String get sangre => _sangre ?? '';
  bool hasSangre() => _sangre != null;

  // "ahf" field.
  String? _ahf;
  String get ahf => _ahf ?? '';
  bool hasAhf() => _ahf != null;

  // "app" field.
  String? _app;
  String get app => _app ?? '';
  bool hasApp() => _app != null;

  // "apnp" field.
  String? _apnp;
  String get apnp => _apnp ?? '';
  bool hasApnp() => _apnp != null;

  // "birth" field.
  String? _birth;
  String get birth => _birth ?? '';
  bool hasBirth() => _birth != null;

  // "nameMod" field.
  String? _nameMod;
  String get nameMod => _nameMod ?? '';
  bool hasNameMod() => _nameMod != null;

  // "actualizacionDate" field.
  DateTime? _actualizacionDate;
  DateTime? get actualizacionDate => _actualizacionDate;
  bool hasActualizacionDate() => _actualizacionDate != null;

  // "alergias" field.
  String? _alergias;
  String get alergias => _alergias ?? '';
  bool hasAlergias() => _alergias != null;

  // "numeroEdit" field.
  String? _numeroEdit;
  String get numeroEdit => _numeroEdit ?? '';
  bool hasNumeroEdit() => _numeroEdit != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _nume = snapshotData['nume'] as String?;
    _job = snapshotData['job'] as String?;
    _instAfil = snapshotData['instAfil'] as String?;
    _nss = snapshotData['nss'] as String?;
    _gener = snapshotData['gener'] as String?;
    _calleNum = snapshotData['calleNum'] as String?;
    _colCp = snapshotData['colCp'] as String?;
    _city = snapshotData['city'] as String?;
    _sangre = snapshotData['sangre'] as String?;
    _ahf = snapshotData['ahf'] as String?;
    _app = snapshotData['app'] as String?;
    _apnp = snapshotData['apnp'] as String?;
    _birth = snapshotData['birth'] as String?;
    _nameMod = snapshotData['nameMod'] as String?;
    _actualizacionDate = snapshotData['actualizacionDate'] as DateTime?;
    _alergias = snapshotData['alergias'] as String?;
    _numeroEdit = snapshotData['numeroEdit'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('pacientes');

  static Stream<PacientesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PacientesRecord.fromSnapshot(s));

  static Future<PacientesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PacientesRecord.fromSnapshot(s));

  static PacientesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PacientesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PacientesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PacientesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PacientesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PacientesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPacientesRecordData({
  String? name,
  String? nume,
  String? job,
  String? instAfil,
  String? nss,
  String? gener,
  String? calleNum,
  String? colCp,
  String? city,
  String? sangre,
  String? ahf,
  String? app,
  String? apnp,
  String? birth,
  String? nameMod,
  DateTime? actualizacionDate,
  String? alergias,
  String? numeroEdit,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'nume': nume,
      'job': job,
      'instAfil': instAfil,
      'nss': nss,
      'gener': gener,
      'calleNum': calleNum,
      'colCp': colCp,
      'city': city,
      'sangre': sangre,
      'ahf': ahf,
      'app': app,
      'apnp': apnp,
      'birth': birth,
      'nameMod': nameMod,
      'actualizacionDate': actualizacionDate,
      'alergias': alergias,
      'numeroEdit': numeroEdit,
    }.withoutNulls,
  );

  return firestoreData;
}

class PacientesRecordDocumentEquality implements Equality<PacientesRecord> {
  const PacientesRecordDocumentEquality();

  @override
  bool equals(PacientesRecord? e1, PacientesRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.nume == e2?.nume &&
        e1?.job == e2?.job &&
        e1?.instAfil == e2?.instAfil &&
        e1?.nss == e2?.nss &&
        e1?.gener == e2?.gener &&
        e1?.calleNum == e2?.calleNum &&
        e1?.colCp == e2?.colCp &&
        e1?.city == e2?.city &&
        e1?.sangre == e2?.sangre &&
        e1?.ahf == e2?.ahf &&
        e1?.app == e2?.app &&
        e1?.apnp == e2?.apnp &&
        e1?.birth == e2?.birth &&
        e1?.nameMod == e2?.nameMod &&
        e1?.actualizacionDate == e2?.actualizacionDate &&
        e1?.alergias == e2?.alergias &&
        e1?.numeroEdit == e2?.numeroEdit;
  }

  @override
  int hash(PacientesRecord? e) => const ListEquality().hash([
        e?.name,
        e?.nume,
        e?.job,
        e?.instAfil,
        e?.nss,
        e?.gener,
        e?.calleNum,
        e?.colCp,
        e?.city,
        e?.sangre,
        e?.ahf,
        e?.app,
        e?.apnp,
        e?.birth,
        e?.nameMod,
        e?.actualizacionDate,
        e?.alergias,
        e?.numeroEdit
      ]);

  @override
  bool isValidKey(Object? o) => o is PacientesRecord;
}
