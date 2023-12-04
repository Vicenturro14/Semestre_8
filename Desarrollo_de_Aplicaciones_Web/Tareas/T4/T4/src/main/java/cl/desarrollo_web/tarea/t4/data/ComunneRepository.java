package cl.desarrollo_web.tarea.t4.data;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ComunneRepository extends JpaRepository<Comuna, Long> {
    Comuna findComunaById(Long id);
}
