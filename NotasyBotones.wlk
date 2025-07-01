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


    ///nuevo
    method esCercanaA(unBoton) {
        const mismaPosicion = self.position().equals(unBoton.position())
        const justoAbajo = self.position().y() == unBoton.position().y() + 1
        return self.botonAsignado() == unBoton && (mismaPosicion || justoAbajo)
}
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
// object botonVerde inherits Boton(position = game.at(2,1), imagenApagado = "boton1.png", imagenActual = "boton1.png" ,botonHit = "boton1Hit.png"){

// }
// object botonRojo inherits Boton(position = game.at(5,1), imagenApagado = "boton2.png", imagenActual = "boton2.png", botonHit = "boton2Hit.png"){

// }
// object botonAmarillo inherits Boton(position = game.at(8,1), imagenApagado = "boton3.png", imagenActual ="boton3.png", botonHit = "boton3Hit.png"){

// }
// object botonAzul inherits Boton(position = game.at(11,1), imagenApagado = "boton4.png", imagenActual = "boton4.png", botonHit = "boton4Hit.png"){

// }

