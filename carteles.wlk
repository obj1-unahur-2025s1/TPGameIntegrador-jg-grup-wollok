import teclado.*
import Menu.*
import NotasyBotones.*
import player.*
import wollokJuego.*
import niveles.*

// Carteles que aparecen dentro de la partida y/o inicio
object cartelPuntuacion {
    var property position = game.at(16, 12)
    var property text = "PUNTUACION: 0"
    method textColor() =  "F9F9F9" 
    method actualizar(nuevaPuntuacion) {
        self.text("PUNTUACION: " + nuevaPuntuacion)
    }
}
object imagenPuntos {
    var property position = game.at(12, 5)
    method image() = "cartelPuntuacionGrandeV.png"
}
object cartelFallos {
    var property text = "FALLOS : 0" 
    var property position = game.at(16,10)
    method textColor() = "FF0000FF" 
    method actualizarFallo(cantFallos) {
        self.text("FALLOS: " + cantFallos)
    }
}
object cartelVida {
    //vida auxiliar
    const vida = new Vida(position = game.at(0,0))
    // vidas del jugador 
    const property vida1 = new Vida(position = game.at(15.3, 7))
    const property vida2 = new Vida(position = game.at(16.3, 7))
    const property vida3 = new Vida(position = game.at(17.3, 7))

    const vidas = [vida1, vida2, vida3]

    method mostrarVidas() {
        game.addVisual(vida1)
        game.addVisual(vida2)
        game.addVisual(vida3)
    }
    method ocultarVidas() {
        game.removeVisual(vida1)
        game.removeVisual(vida2)
        game.removeVisual(vida3)
    }
    method actualizarVida() {
        vidas.find({v => v.image() == vida.image()}).imagen(vidaPerdida.image())
    }
    method recargarVidas() {
        vidas.forEach({v => v.recargarVida()})
    }
}
object cartelPrecision {
    var property text = "Precision: 0%"
    var property position = game.at(10,9)
    method textColor() = "F9F9F9" 
    method mostrarPresicion(unaCancion) {
        const presicion = unaCancion.calcularPresicion()
        self.text("Precision: " + presicion + "%")
    }
}
 object win1 {
    method iniciar() {
        menu.cambiarEstado("win1")
        game.sound("winSonido.mp3").play()
        cartelPrecision.mostrarPresicion(juego.nivelElegido())
        game.addVisual(winMenu)
        game.addVisual(cartelPrecision)
    }
    method ocultarWin() {
        game.removeVisual(winMenu)
        game.removeVisual(cartelPrecision)
    }
 }
object winMenu {
    method image() = "winersss.png" 
    method position() = game.at(0,0) 
}
//Imagenes de las vidas
class Vida {
    var property position 
    var property imagen = "guitarraVida2.png"
    method image() =  imagen 
    method recargarVida() {
        if (self.imagen() == vidaPerdida.image()) {self.imagen("guitarraVida2.png")}
    } 
}
object vidaPerdida {
    method image() = "guitarraVidaPerdida2.png"
}

///////////////////////

//Imagenes actualizables de las reglas
object reglas {
    var property estaVisible = false
    var property imagenPuesta = "textoreglas1.jpg" 
    method position() = game.at(0, 0) 
    method image() = imagenPuesta
    method cambioVisible() {
        estaVisible = !estaVisible
    }
}
///////////////////////




