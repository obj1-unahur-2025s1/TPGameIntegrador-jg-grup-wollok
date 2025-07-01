import carteles.*
import Menu.*
import niveles.*
import NotasyBotones.*
import player.*
import teclado.*

object juego {
    var property notasActivas = []
    var property nivelElegido = cancion1
    method estado() = "jugando"
    method añadirVisuals() {
        game.addVisual(botonVerde)
        game.addVisual(botonRojo)
        game.addVisual(botonAmarillo)
        game.addVisual(botonAzul)
        game.addVisual(imagenPuntos)
        game.addVisual(cartelFallos)
        game.addVisual(cartelPuntuacion)
        cartelVida.mostrarVidas()
    }
    method iniciar() {
        
        self.añadirVisuals()

        nivelElegido.iniciar()
        teclado.iniciar()
        
        game.onTick(50, "verificarFallos", { => self.verificarNotasFalladas() })
        menu.cambiarEstado("jugando")
    }

    method eliminarVisuals() {
        game.removeVisual(botonAmarillo)
        game.removeVisual(botonAzul)
        game.removeVisual(botonRojo)
        game.removeVisual(botonVerde)
        game.removeVisual(imagenPuntos)
        game.removeVisual(cartelPuntuacion)
        game.removeVisual(cartelFallos)
        game.removeVisual(cartelVida)
        cartelVida.ocultarVidas()

    }
    method eliminarNotasActivas() {
        notasActivas.forEach({ n =>
            game.removeVisual(n)
        })
        notasActivas = []
        
    }
    //////////nuevo
    method pulsarNotaEn(unBoton) {
        const notaCercana = self.buscarNotaCercanaA(unBoton)

        if (notaCercana != null) {
            self.acertarNota(notaCercana)
        } else {
            self.fallarNota()
        }
    }
    method buscarNotaCercanaA(unBoton) {
        return notasActivas.findOrElse({ n => n.esCercanaA(unBoton) }, { null })
    }
    method acertarNota(nota) {
        nota.hit()
        notasActivas.remove(nota)
        player.sumarHit()
        cartelPuntuacion.actualizar(player.puntuacion())
    }   

    method fallarNota() {
        game.sound("sonido2.mp3").play()
        player.sumarFallo()
        player.reiniciarMultiplicador()
        cartelFallos.actualizarFallo(player.fallos())
        player.restarVida()
    }
    
    method verificarNotasFalladas() {
         const notasFalladas = notasActivas.filter({ n =>
            n.position().y() < (n.botonAsignado().position().y() - 2)
        })
        notasFalladas.forEach({ n =>
            game.sound("sonido2.mp3").play()
            n.fail()
            notasActivas.remove(n)
            game.removeVisual(n)
            cartelFallos.actualizarFallo(player.fallos())
            player.restarVida()
        })
    }

    method crearNota(color, velocidad) {
    if (cancion1.tecla()) {
        const notaNueva = new Notas(image = color.imagen(), position = color.posicion(), botonAsignado = color.boton())
        game.addVisual(notaNueva)
        notaNueva.queCaiga(velocidad)
        notasActivas.add(notaNueva)
        }   
    }
}


object verde {
    method imagen() = "note1.png"
    method posicion() = game.at(2, 18)
    method boton() = botonVerde
}

object rojo {
    method imagen() = "note2.png"
    method posicion() = game.at(5, 18)
    method boton() = botonRojo
}

object amarillo {
    method imagen() = "note3.png"
    method posicion() = game.at(8, 18)
    method boton() = botonAmarillo
}

object azul {
    method imagen() = "note4.png"
    method posicion() = game.at(11, 18)
    method boton() = botonAzul
}