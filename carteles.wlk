import teclado.*
import Menu.*
import NotasyBotones.*
import player.*


object imagenPuntuacion {
    var property position = game.at(14, 14.5)
    method image() = "puntuacionchica.png"
}

object cartelPuntuacion {
    var property position = game.at(16.5, 14)
    var property text = ": 0"
    var property size = 50
    method actualizar(nuevaPuntuacion) {
        self.text(": " + nuevaPuntuacion)
    }

}

object cartelHits {
    var property position = game.at(17,10)
    var property text = "Hits: 0"
    var property size = 20 

    method actualizarHits(nuevoHits) {
        self.text("hits: " + nuevoHits)
    }
    
}
object cartelFallos {
    var property text = "Fallos: 0" 
    var property size = 20
    var property position = game.at(17,13)
    
    method actualizarFallo(cantFallos) {
        self.text("Fallos: " + cantFallos)
    }
}
object cartelVida {
    var property text = "Vida: 3" 
    var property size = 20
    var property position = game.at(17,12)
    
    method actualizarVida(cantVida) {
        self.text("Vida: " + cantVida)
    }
}
object reglas {
    var property estaVisible = false
    method position() = game.at(-10, 0) //game.at(1,-14)
    method image() = "ruless.png"
    method cambioVisible() {
        estaVisible = !estaVisible
    }
}
object gameOver {
    method position() = game.at(5, 10)
    method image() = "gameover.png"
}