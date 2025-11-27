import 'package:fuoday/features/home/domain/entities/checkin_entity.dart';
import 'package:fuoday/features/home/domain/repositories/checkin_repository.dart';

class CheckInUseCase {
  final CheckInRepository checkInRepository;

  CheckInUseCase({required this.checkInRepository});

  Future<CheckInEntity?> call(CheckInEntity checkInEntity) async {
    return await checkInRepository.checkIn(checkInEntity);
  }
}

class CheckOutUseCase {
  final CheckInRepository repository;

  CheckOutUseCase({required this.repository});

  Future<CheckInEntity?> call(CheckInEntity checkOutEntity) async {
    return await repository.checkOut(checkOutEntity);
  }
}
