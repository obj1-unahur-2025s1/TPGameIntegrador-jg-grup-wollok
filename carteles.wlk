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
    var property text = "PUNTUACION : 0"
    method textColor() =  "F9F9F9" //"00FF00FF"
    method actualizar(nuevaPuntuacion) {
        self.text("PUNTUACION:" + nuevaPuntuacion)
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
    var property text = "FALLOS : 0" 
    var property position = game.at(16,10)
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
    method recargarVidas() {
        vidas.forEach({v => v.imagen("guitarraVida2.png")})
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
    method position() = game.at(0, 0) //game.at(1,-14)
    method image() = "texto2.jpg"//"reglasbiem.png"
    method cambioVisible() {
        estaVisible = !estaVisible
    }
}

/////////////
object win1 {
    method iniciar() {
        menu.cambiarEstado("win1")
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
object cartelPrecision {
    var property text = "Precision: 0%"
    var property position = game.at(10,9)
    method textColor() = "FF0000FF" 
    method mostrarPresicion(unaCancion) {
        const presicion = unaCancion.calcularPresicion()
        self.text("Precision: " + presicion + "%")
    }
}
object gameOver{
    method iniciar() { 
        game.sound("game_over_sound.mp3").play()
        menu.cambiarEstado("gameOver")
        game.addVisual(imgGameOver)
    }
    method ocultar() {
        game.removeVisual(imgGameOver)
    }
}
object imgGameOver {
    method image() = "gameover1.png"
    method position() = game.at(0,0)
}
