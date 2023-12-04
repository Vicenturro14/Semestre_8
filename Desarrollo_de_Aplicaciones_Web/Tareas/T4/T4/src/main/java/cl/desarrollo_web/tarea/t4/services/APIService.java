package cl.desarrollo_web.tarea.t4.services;

import cl.desarrollo_web.tarea.t4.data.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class APIService {
    private final CommentRepository commentRepository;
    private final ComunneRepository comunneRepository;
    private final ArtisanRepository artisanRepository;
    private final SupporterRepository supporterRepository;

    @Autowired
    public APIService(
            CommentRepository commentRepository,
            ComunneRepository comunneRepository,
            ArtisanRepository artisanRepository,
            SupporterRepository supporterRepository
    ) {
        this.commentRepository = commentRepository;
        this.comunneRepository = comunneRepository;
        this.artisanRepository = artisanRepository;
        this.supporterRepository = supporterRepository;
    }

    List<Map<String, String>> get_supporters_data_by_name_prefix(String name_prefix) {
        // Se obtienen los hinchas con nombres que parten con name_prefix
        List<Hincha> match_supporters = supporterRepository.findAllByNombreStartingWith(name_prefix);

        List<Map<String, String>> match_supporters_data = new ArrayList<>();
        String comunne_name;
        int comments_num;
        for (Hincha supporter : match_supporters) {
            Map<String, String> supporter_data = new HashMap<>();
            supporter_data.put("name", supporter.getNombre());
            supporter_data.put("email", supporter.getEmail());

            // Se obtiene el nombre de la comuna del hincha
            comunne_name = comunneRepository.findComunaById(supporter.getComuna_id()).getNombre();
            supporter_data.put("comunne", comunne_name);

            // Se obtiene el número de comentarios
            comments_num = commentRepository.countById_hincha(supporter.getId());
            supporter_data.put("comments_num", String.valueOf(comments_num));

            // Se agrega a la lista
            match_supporters_data.add(supporter_data);
        }

        return  match_supporters_data;
    }

    List<Map<String, String>> get_artisans_data_by_name_prefix(String name_prefix) {
        // Se obtienen los artesanos con nombres que parten con name_prefix
        List<Artesano> match_artisans = artisanRepository.findAllByNombreStartingWith(name_prefix);

        List<Map<String, String>> match_artisans_data = new ArrayList<>();
        String comunne_name;
        int comments_num;
        for (Artesano artisan : match_artisans) {
            Map<String, String> artisan_data = new HashMap<>();
            artisan_data.put("name", artisan.getNombre());
            artisan_data.put("email", artisan.getEmail());

            // Se ontiene el nombre de la comuna del artesano
            comunne_name = comunneRepository.findComunaById(artisan.getComuna_id()).getNombre();
            artisan_data.put("comunne", comunne_name);

            // Se obtiene el número de comentarios
            comments_num = commentRepository.countById_artesano(artisan.getId());
            artisan_data.put("comments_num", String.valueOf(comments_num));

            // Se agrega a la lista
            match_artisans_data.add(artisan_data);
        }

        return match_artisans_data;
    }

    List<Comentario> get_comments_by_artisan_id(Long id) {
        return commentRepository.findAllById_artesanoOrderByFechaDesc(id);
    }

    List<Comentario> get_comments_by_supporter_id(Long id) {
        return commentRepository.findAllById_hinchaOrderByFechaDesc(id);
    }
}
