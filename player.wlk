import Menu.*
import NotasyBotones.*
import teclado.*
import carteles.*
object player {
    // seguro
    var property puntuacion = 0 // puntuacion del jugador
    var property multiplicador = 1 // maximo 4 sin poder, maximo 8 con poder
    var property fallos = 0 // cantidad de fallos
    var property falloOculto = 0
    var property consecutiveHits = 0
    var property hitsAcertados = 0
    var property vida = 3

    method resetear() {
        puntuacion = 0
        multiplicador = 1
        fallos = 0
        falloOculto = 0
        consecutiveHits = 0
        hitsAcertados = 0
        vida = 3
        cartelPuntuacion.actualizar(0)
        cartelFallos.actualizarFallo(0)
        cartelVida.recargarVidas()
        cartelPrecision.mostrarPresicion(juego.nivelElegido())
    }
    method restarVida() {
            
            if(falloOculto == 6 and vida >= 1) {
                vida = (vida-1).max(0)
                falloOculto = 0
                cartelVida.actualizarVida()
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
}