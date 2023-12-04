package cl.desarrollo_web.tarea.t4.data;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "comuna")
public class Comuna {
    @Id
    @SequenceGenerator(
            name = "comunne_sequence",
            sequenceName = "comunne_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "comunne_sequence"
    )
    private Long id;

    @NotNull
    private String nombre;

    @NotNull
    private long region_id;

    public Comuna(){}

    public long getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public long getRegion_id() {
        return region_id;
    }
}
