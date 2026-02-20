import '../../interfaces/mapper/imapper.dart';
// Sửa lại đường dẫn import đúng vị trí thực tế của UserDto
import '../../data/dtos/login/user_dto.dart';
import '../../domain/entities/user.dart';

class AuthMapper implements IMapper<UserDto, User> {
  @override
  User toEntity(UserDto dto) {
    return User(
      id: dto.id ?? 0,
      fullName: dto.fullName,
      email: dto.email,
      dob: dto.dob,
    );
  }

  @override
  UserDto fromEntity(User entity) {
    // Thường không cần map ngược từ Entity về Dto có password
    // Nên hàm này có thể vứt lỗi UnimplementedError hoặc làm tạm như sau
    throw UnimplementedError("Không map ngược từ Entity -> DTO trong Auth");
  }
}
