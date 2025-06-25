import carteles.*
import Menu.*
import niveles.*
import NotasyBotones.*
import player.*
import teclado.*

object juego {
    var property notasActivas = []
    var property nivelElegido = cancion1
    
    method añadirVisuals() {
        game.addVisual(botonVerde)
        game.addVisual(botonRojo)
        game.addVisual(botonAmarillo)
        game.addVisual(botonAzul)
        game.addVisual(imagenPuntos)
        game.addVisual(cartelFallos)
        game.addVisual(cartelPuntuacion)
        game.addVisual(vida1)
        game.addVisual(vida2)
        game.addVisual(vida3)
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
        game.removeVisual(vida1)
        game.removeVisual(vida2)
        game.removeVisual(vida3)

    }
    method eliminarNotasActivas() {
        notasActivas.forEach({ n =>
            game.removeVisual(n)
        })
        notasActivas = []
        
    }
    method pulsarNotaEn(unBoton) {
        const notaCercana = notasActivas.findOrElse({n =>
        (n.botonAsignado() == unBoton) && ((n.position().y() == unBoton.position().y() + 1 ||
        n.botonAsignado() == unBoton &&  (n.position().equals(unBoton.position()))))
            },{null})
        if (notaCercana != null) {
            notaCercana.hit()
            notasActivas.remove(notaCercana)
            player.sumarHit()
            cartelPuntuacion.actualizar(player.puntuacion())
        } else {
            game.sound("sonido2.mp3").play()
            player.sumarFallo()
            player.reiniciarMultiplicador()
            notasActivas.remove(notaCercana)
            cartelFallos.actualizarFallo(player.fallos())
            player.restarVida()
        }
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

    method crearNotaVerde(velocidad) {
        const notaNueva = new Notas(image = "note1.png",  position = game.at(2,18), botonAsignado = botonVerde)
        game.addVisual(notaNueva)
        notaNueva.queCaiga(velocidad)
        notasActivas.add(notaNueva)
    }
    method crearNotaRoja(velocidad) {
        const notaNueva = new Notas(image = "note2.png", position = game.at(5,18), botonAsignado = botonRojo)
        game.addVisual(notaNueva)
        notaNueva.queCaiga(velocidad)
        notasActivas.add(notaNueva)
    }
    method crearNotaAmarilla(velocidad) {
        const notaNueva = new Notas(image = "note3.png", position = game.at(8,18), botonAsignado = botonAmarillo)
        game.addVisual(notaNueva)
        notaNueva.queCaiga(velocidad)
        notasActivas.add(notaNueva)
    }
    method crearNotaAzul(velocidad) {
        const notaNueva = new Notas(image = "note4.png", position = game.at(11,18), botonAsignado = botonAzul)
        game.addVisual(notaNueva)
        notaNueva.queCaiga(velocidad)
        notasActivas.add(notaNueva)
    }
}