package cl.desarrollo_web.tarea.t4.data;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDateTime;

@Entity
@Table(name = "comentario")
public class Comentario {
    @Id
    @SequenceGenerator(
            name = "comment_sequence",
            sequenceName = "comment_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "comment_sequence"
    )
    private Long id;

    @NotNull
    private String nombre;

    @NotNull
    private String email;

    @NotNull
    private LocalDateTime fecha;

    @NotNull
    private String comentario;

    private Long id_hincha;

    private Long id_artesano;

    public Comentario() {
    }

    public Comentario(String nombre, String email, LocalDateTime fecha, String comentario) {
        this.nombre = nombre;
        this.email = email;
        this.fecha = fecha;
        this.comentario = comentario;
    }

    public long getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public String getEmail() {
        return email;
    }

    public LocalDateTime getFecha() {
        return fecha;
    }

    public String getComentario() {
        return comentario;
    }

    public Long getId_hincha() {
        return id_hincha;
    }

    public Long getId_artesano() {
        return id_artesano;
    }

    public void setId_hincha(Long id_hincha) {
        this.id_hincha = id_hincha;
    }

    public void setId_artesano(Long id_artesano) {
        this.id_artesano = id_artesano;
    }
}
