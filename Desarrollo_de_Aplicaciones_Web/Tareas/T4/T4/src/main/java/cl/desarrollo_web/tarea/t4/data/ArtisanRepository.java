package cl.desarrollo_web.tarea.t4.data;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ArtisanRepository extends JpaRepository<Artesano, Long> {
    List<Artesano> findAllByNombreStartingWith(String name_prefix);
}
