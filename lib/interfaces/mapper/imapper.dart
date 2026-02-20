abstract class IMapper<DTO, Entity> {
  Entity toEntity(DTO dto);
  DTO fromEntity(Entity entity);
}
