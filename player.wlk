import Menu.*
import NotasyBotones.*
import teclado.*
import carteles.*
object player {
    // seguro
    var property puntuacion = 0 // puntuacion del jugador
    var property multiplicador = 1 // maximo 4 sin poder, maximo 8 con poder
    var property energia =  0 //maximo 10
    var property fallos = 0 // cantidad de fallos
    var property falloOculto = 0
    var property consecutiveHits = 0
    var property hitsAcertados = 0
    var property vida = 3

    method restarVida() {
        if(falloOculto == 6) {
            vida = (vida-1).max(0)
            falloOculto = 0
            cartelVida.actualizarVida(self.vida())
        } 
        else if (vida == 0) {
            game.addVisual(gameOver)
        }
    }
    
    
    method sumarFallo() {fallos += 1 falloOculto += 1}
    method sumarPuntuacion(valor) {puntuacion += valor}
    method sumarHit() {hitsAcertados += 1 return hitsAcertados}
    method aumentarMultiplicador() {
        consecutiveHits += 1 
        if (consecutiveHits == 4) { 
            multiplicador = 2
        } else if (consecutiveHits == 8) {
            multiplicador = 3
        } 
    }

    method reiniciarMultiplicador() {
        multiplicador = 1
        consecutiveHits = 0 
    }


    // method activarPoder() {
    //     if (energia == 10){ 
    //         //cancion.notas.forEach({n=>n.cambiarImage("noteSuper.png")}) 
    //         //cancion.notas.forEach({n=>n.cambiarImage("noteSuperHit.png")})
    //         multiplicador *= 2
    //         energia = 0
    //         poder = true
    //         self.desactivarPoder()
    //     } else {
    //         throw new Exception(message="No hay suficiente energia")
    //     }
    // }

    // method desactivarPoder() {
    //     game.onTick(300,"desactivarPoder", {poder = false})
    // }
}