import teclado.*
import Menu.*
import NotasyBotones.*
import player.*


// object imagenPuntuacion {
//     var property position = game.at(14, 14.5)
//     method image() = "puntuacionchica.png"
// }
object cartelPuntuacion {
    var property position = game.at(16, 12)
    var property text = "PUNTAJE: 0"
    method size() = 150
    method textColor() = "00FF00FF"
    method actualizar(nuevaPuntuacion) {
        self.text("PUNTAJE: " + nuevaPuntuacion)
    }
}
object imagenPuntos {
    var property position = game.at(12, 5)
    method image() = "cartelPuntuacionGrandeV.png"
}

object cartelHits {
    var property position = game.at(17,10)
    var property text = "HITS: 0"

    method actualizarHits(nuevoHits) {
        self.text("HITS: " + nuevoHits)
    }
    
}
object cartelFallos {
    var property text = "FALLOS: 0" 
    var property position = game.at(16,11)
    method textColor() = "FF0000FF" 
    method actualizarFallo(cantFallos) {
        self.text("FALLOS: " + cantFallos)
    }
}
object cartelVida {
    // var property text = "Vida: 3" 
    // var property size = 20
    // var property position = game.at(17,12)
    
    // method actualizarVida(cantVida) {
    //     self.text("Vida: " + cantVida)
    // }

    const vidas = [vida1, vida2, vida3]
    method actualizarVida() {
        vidas.find({v => v.image() == "guitarraVida2.png"}).imagen("guitarraVidaPerdida2.png")
    }
}
object vida1 {
    var property position = game.at(15.3, 7)
    var property imagen = "guitarraVida2.png"
    method image() =  imagen
}
object vida2 {
    var property position = game.at(16.3, 7)
    var property imagen = "guitarraVida2.png"
    method image() =  imagen
}
object vida3 {
    var property position = game.at(17.3, 7)
    var property imagen = "guitarraVida2.png"
    method image() =  imagen
}


object reglas {
    var property estaVisible = false
    method position() = game.at(-10, 0) //game.at(1,-14)
    method image() = "reglasbiem.png"
    method cambioVisible() {
        estaVisible = !estaVisible
    }
}
object gameOver {
    method position() = game.at(5, 10)
    method image() = "gameover.png"
}