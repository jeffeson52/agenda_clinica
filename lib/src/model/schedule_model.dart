// ignore_for_file: public_member_api_docs, sort_constructors_first
class ScheduleModel {
  final int id;
  final int clinicaId;
  final int userId;
  final String clientName;
  final DateTime date;
  final int hour;
  ScheduleModel({
    required this.id,
    required this.clinicaId,
    required this.userId,
    required this.clientName,
    required this.date,
    required this.hour,
  });

  factory ScheduleModel.fromMap(Map<String, dynamic> json) {
    switch (json) {
      case {
          'id': int id,
          'clinica_id': int clinicaId,
          'user_id': int userId,
          'client_name': String clientName,
          'date': String scheduleDate,
          'time': int hour,
        }:
        return ScheduleModel(
            id: id,
            clinicaId: clinicaId,
            userId: userId,
            clientName: clientName,
            date: DateTime.parse(scheduleDate),
            hour: hour);
      case _:
        throw ArgumentError('Invalid JSON');
    }
  }
}
