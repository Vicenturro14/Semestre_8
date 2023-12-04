package cl.desarrollo_web.tarea.t4.data;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comentario, Long> {
    List<Comentario> findAllById_artesanoOrderByFechaDesc(Long artisan_id);

    List<Comentario> findAllById_hinchaOrderByFechaDesc(Long supporter_id);

    int countById_artesano(Long artisan_id);

    int countById_hincha(Long supporter_id);
}
