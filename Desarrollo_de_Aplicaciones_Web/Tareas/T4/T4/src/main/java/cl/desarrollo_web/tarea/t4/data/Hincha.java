package cl.desarrollo_web.tarea.t4.data;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "hincha")
public class Hincha {
    @Id
    @SequenceGenerator(
            name = "supporter_sequence",
            sequenceName = "supporter_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "supporter_sequence"
    )
    private Long id;

    @NotNull
    private Long comuna_id;

    @NotNull
    private String modo_transporte;

    @NotNull
    private String nombre;

    @NotNull
    private String email;

    private String celular;

    private String comentarios;

    public Hincha() {}

    public Hincha(
            Long comuna_id,
            String modo_transporte,
            String nombre,
            String email,
            String celular,
            String comentarios
    ) {
        this.comuna_id = comuna_id;
        this.modo_transporte = modo_transporte;
        this.nombre = nombre;
        this.email = email;
        this.celular = celular;
        this.comentarios = comentarios;
    }

    public long getId() {
        return id;
    }

    public Long getComuna_id() {
        return comuna_id;
    }

    public String getModo_transporte() {
        return modo_transporte;
    }

    public String getNombre() {
        return nombre;
    }

    public String getEmail() {
        return email;
    }

    public String getCelular() {
        return celular;
    }

    public String getComentarios() {
        return comentarios;
    }
}
