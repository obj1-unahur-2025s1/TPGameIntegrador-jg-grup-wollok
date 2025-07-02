import Menu.*
import teclado.*
import player.*
import carteles.*
import niveles.*
import wollokJuego.*

// clase usada para crear las notas del juego
class Notas {
    var property image   
    var property puntuacion = 2
    var property position
    var property botonAsignado
    var property colorDefinido
    var property idUnico = contadorNotas.siguienteId()
    //ELIMINA LA NOTA
    method eliminar() {
        colorDefinido.liberarNota(self)
        game.removeVisual(self)
        game.removeTickEvent("caer" + idUnico) 
    }
    method queCaiga(velocidad) {
        // game.onTick(velocidad,"caerse", {self.position(self.position().down(1))})
        const idEvento = "caer" + idUnico
        game.onTick(velocidad, idEvento, {
            self.position(self.position().down(1))
        })
    }
    //SISTEMA DE PUNTUACION
    method hit() {
        player.sumarPuntuacion(puntuacion * player.multiplicador())
        self.eliminar()
        player.aumentarMultiplicador()

        colorDefinido.liberarNota(self)
        }
    // SISTEMA DE REINICIO 
    // method fail() {
    //     player.sumarFallo()
    //     player.reiniciarMultiplicador()
    //     colorDefinido.liberarNota(self)
    // }
    method fail() {
        player.sumarFallo()
        player.reiniciarMultiplicador()
        
        self.eliminar() 
    }
    method esCercanaA(unBoton) {
        const mismaPosicion = self.position().equals(unBoton.position())
        const justoAbajo = self.position().y() == unBoton.position().y() + 1
        return self.botonAsignado() == unBoton && (mismaPosicion || justoAbajo)
    }
    method resetearPosicion() {
        const posX = self.botonAsignado().position().x()
        self.position(game.at(posX, 18))
    }
    method image() = image
}
// clase botones usada para los botones del juego

class Boton {
    var property position
    var property imagenApagado     
    var property imagenActual      
    var property botonHit

    method image() = imagenActual
    method position() = position
    method cambiarImage(png) { imagenActual = png }
}
const botonVerde    = new Boton(position = game.at(2,1),  imagenApagado = "boton1.png", imagenActual = "boton1.png",  botonHit = "boton1Hit.png")
const botonRojo     = new Boton(position = game.at(5,1),  imagenApagado = "boton2.png", imagenActual = "boton2.png",  botonHit = "boton2Hit.png")
const botonAmarillo = new Boton(position = game.at(8,1),  imagenApagado = "boton3.png", imagenActual = "boton3.png",  botonHit = "boton3Hit.png")
const botonAzul     = new Boton(position = game.at(11,1), imagenApagado = "boton4.png", imagenActual = "boton4.png", botonHit = "boton4Hit.png")
