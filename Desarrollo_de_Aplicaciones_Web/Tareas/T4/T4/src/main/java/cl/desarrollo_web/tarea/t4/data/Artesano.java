package cl.desarrollo_web.tarea.t4.data;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "artesano")
public class Artesano {

    @Id
    @SequenceGenerator(
            name = "artisan_sequence",
            sequenceName = "artisan_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "artisan_sequence"
    )
    private Long id;

    @NotNull
    private Long comuna_id;

    @NotNull
    private String nombre;

    @NotNull
    private String email;

    private String descripcion_artesania;

    private String celular;

    public Artesano() {}

    public Artesano(
            Long comuna_id,
            String nombre,
            String email,
            String descripcion_artesania,
            String celular
    ) {
        this.comuna_id = comuna_id;
        this.nombre = nombre;
        this.email = email;
        this.descripcion_artesania = descripcion_artesania;
        this.celular = celular;
    }

    public long getId() {
        return id;
    }

    public Long getComuna_id() {
        return comuna_id;
    }

    public String getNombre() {
        return nombre;
    }

    public String getEmail() {
        return email;
    }

    public String getDescripcion_artesania() {
        return descripcion_artesania;
    }

    public String getCelular() {
        return celular;
    }
}
