import Menu.*
import teclado.*
import player.*
import carteles.*
import niveles.*
object juego {
    var property notasActivas = []
    // var property tecladoEnUso = tecladoMenu
    var property nivelElegido = cancion1
    
    method iniciar() {
        
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
        game.removeVisual(cartelHits)
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
            cartelPuntuacion.actualizar(player.puntuacion())
            cartelHits.actualizarHits(player.sumarHit())
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

        // const notasFalladas = notasActivas.filter({ n =>
        //     n.position().y() < (n.botonAsignado().position().y() + posicionParaFallo)
        // })
        // cambie este código para poder acertar las notas 
        // si estan en +1 posición arriba del botón porque sino
        // era muy difícil acertar las notas en el juego
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

class Notas {
    var property image   
    var property puntuacion = 2
    var property position
    var property botonAsignado


     //ELIMINA LA NOTA
    method eliminar() {
        game.removeVisual(self)
        
    }
    method queCaiga(velocidad) {
        game.onTick(velocidad,"caerse", {self.position(self.position().down(1))})
    }

    //SISTEMA DE PUNTUACION
    method hit() {
        player.sumarPuntuacion(puntuacion * player.multiplicador())
        self.eliminar()
        player.aumentarMultiplicador()
        }
    // SISTEMA DE REINICIO 
    method fail() {
        player.sumarFallo()
        player.reiniciarMultiplicador()
    }
}
// // BOTONES

class Botones {
    var property position
    var property imagenApagado     
    var property imagenActual      
    var property botonHit

    method image() = imagenActual
    method position() = position
    method cambiarImage(png) { imagenActual = png }
}

object botonVerde inherits Botones(position = game.at(2,1), imagenApagado = "boton1.png", imagenActual = "boton1.png" ,botonHit = "boton1Hit.png"){

}
object botonRojo inherits Botones(position = game.at(5,1), imagenApagado = "boton2.png", imagenActual = "boton2.png", botonHit = "boton2Hit.png"){

}
object botonAmarillo inherits Botones(position = game.at(8,1), imagenApagado = "boton3.png", imagenActual ="boton3.png", botonHit = "boton3Hit.png"){

}
object botonAzul inherits Botones(position = game.at(11,1), imagenApagado = "boton4.png", imagenActual = "boton4.png", botonHit = "boton4Hit.png"){

}
object botonNaranja inherits Botones(position = game.at(14,1), imagenApagado = "boton5.png", imagenActual = "boton5.png", botonHit = "boton5Hit.png"){

}

