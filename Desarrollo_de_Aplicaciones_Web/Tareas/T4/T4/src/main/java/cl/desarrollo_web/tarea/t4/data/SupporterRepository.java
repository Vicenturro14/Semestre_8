package cl.desarrollo_web.tarea.t4.data;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SupporterRepository extends JpaRepository<Hincha, Long> {
    List<Hincha> findAllByNombreStartingWith(String name_prefix);
}
