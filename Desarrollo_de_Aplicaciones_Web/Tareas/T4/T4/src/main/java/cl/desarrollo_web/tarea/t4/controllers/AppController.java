package cl.desarrollo_web.tarea.t4.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AppController {
    @GetMapping("/")
    public String index(Model model, @RequestParam(value = "code", defaultValue = "0") int code) {
        String[] messages = {null, "El artesano se ha registrado con éxito", "El hincha se ha registrado con éxito"};
        int i = (0 <= code && code <= 2) ? code : 0;
        model.addAttribute("message", messages[i]);
        return "index";
    }

    @GetMapping("/buscador")
    public String buscador() {
        return "buscador";
    }
    /*
    // Artesanos
    @GetMapping("/agregar_artesano")
    public String agregar_artesano(Model model) {
        model.addAttribute("errors", null);
        return "agregar-artesano";
    }

    @PostMapping("/agregar_artesano")
    public String post_artesano(Model model){
        return "h";
    }
    */
}
