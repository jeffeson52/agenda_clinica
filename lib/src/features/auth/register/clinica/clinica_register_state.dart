// ignore_for_file: public_member_api_docs, sort_constructors_first
enum ClinicaRegisterStateStatus { initial, success, error }

class ClinicaRegisterState {
  final ClinicaRegisterStateStatus status;
  final List<String> openingDays;
  final List<int> openingHours;

  ClinicaRegisterState.initial()
      : this(
          status: ClinicaRegisterStateStatus.initial,
          openingDays: <String>[],
          openingHours: <int>[],
        );

  ClinicaRegisterState({
    required this.status,
    required this.openingDays,
    required this.openingHours,
  });

  ClinicaRegisterState copyWith({
    ClinicaRegisterStateStatus? status,
    List<String>? openingDays,
    List<int>? openingHours,
  }) {
    return ClinicaRegisterState(
      status: status ?? this.status,
      openingDays: openingDays ?? this.openingDays,
      openingHours: openingHours ?? this.openingHours,
    );
  }
}
