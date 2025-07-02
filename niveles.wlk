import player.*
import NotasyBotones.*
import Menu.*
import carteles.*
import teclado.*
import wollokJuego.*

// NIVEL 1 
class Nivel {
    const property notasTotales
    var property nivel
    var property musica 
    var property duracion // en segundos
    var property inicio = 1
    var property tecla = true
    method iniciar() {
        tecla = true
        nivel.musica().play()
        game.schedule(4300, {=>nivel.iniciaMusica()})
    }
    method detener() {
        tecla = false
        musica.stop()
    }
    method cerrarNivel() {
        if (menu.estadoJuego() == win1.estado()) {
            win1.ocultarWin()
        } 
        else if (menu.estadoJuego() == gameOver.estado()){
            game.removeVisual(imgGameOver)
        }
        game.removeTickEvent("verificarFallos")   
        game.removeTickEvent("caer") 
        menu.iniciar()
        self.detener()
        juego.eliminarVisuals()
        player.resetear()
    }
    method calcularPresicion() {
        return (player.hitsAcertados() / notasTotales) * 100 
    }
    method duracionEnMs() {
        return duracion * 1000
    }
    method iniciaMusica() {
        nivel.musicaCompleta()
        game.schedule(self.duracionEnMs(), {=>if (player.vida() == 0) {
            gameOver.iniciar()
        } else {win1.iniciar()}})
    }
    method puntosEnPantalla() {
        game.sound("sonido3.mp3").play()
        cartelPuntuacion.position(game.at(7,8))
        game.schedule(7300, {=> cartelPuntuacion.position(game.at(16, 12))})
    }
    
//// TIPO DE NOTAS A CAER
    method caerNota(tiempo, color, velocidad){
        game.schedule(tiempo, {=>juego.crearNota(color,velocidad)})
    }
    method dosNotas(tiempo, color1,color2, velocidad) {
        self.caerNota(0,color1,velocidad)
        self.caerNota(tiempo,color2,velocidad)
    }
    method tresNotas(tiempo1,tiempo2, color1,color2,color3,velocidad) {
        self.caerNota(0,color1,velocidad)
        self.caerNota(tiempo1,color2,velocidad)
        self.caerNota(tiempo2,color3,velocidad)
    }
    method cuatroNotas(tiempo1,tiempo2,tiempo3,color1,color2,color3,color4,velocidad){
        self.caerNota(0,color1,velocidad)
        self.caerNota(tiempo1,color2,velocidad)
        self.caerNota(tiempo2,color3,velocidad)
        self.caerNota(tiempo3,color4,velocidad)
    }
    
}
object cancion1 inherits Nivel(notasTotales=70, duracion=65 ,musica=game.sound("cancionNivel1.mp3"), nivel=self) {

    method primerParte() {
        game.schedule(0, {=> self.tresNotas(250, 750, verde, azul, roja, 90) })
        game.schedule(1300, {=> self.tresNotas(250, 750, verde, azul, amarilla, 90) })
        game.schedule(2500, {=> self.tresNotas(250, 750, verde, azul, roja, 90) })
        game.schedule(3800, {=> self.tresNotas(250, 750, verde, azul, amarilla, 90) })
        game.schedule(5000, {=> self.tresNotas(250, 750, verde, azul, roja, 90) })
        game.schedule(6100, {=> self.tresNotas(250, 750, verde, azul, amarilla, 90) })
        game.schedule(7400, {=> self.tresNotas(250, 750, verde, azul, roja, 90) })
    }

    method segundaParte() {
        game.schedule(0, {=> self.tresNotas(250, 750, verde, azul, roja, 90) })
        game.schedule(600, {=> self.caerNota(0, amarilla, 90) })
        game.schedule(1100, {=> self.caerNota(0, roja, 90) })
    }

    method terceraParte() {
        game.schedule(0, {=> self.tresNotas(250, 750, verde, azul, roja, 90) })
        game.schedule(1200, {=> self.caerNota(0, azul, 90) })
        game.schedule(1300, {=> self.dosNotas(500, verde, azul, 90) })
        game.schedule(2100, {=> self.caerNota(0, roja, 90) })
    }

    method midGame() {
        game.schedule(0, {=> self.tresNotas(250, 750, verde, azul, roja, 90) })
        game.schedule(2300, {=> self.terceraParte() })
        game.schedule(5000, {=> self.tresNotas(250, 750, verde, azul, roja, 90) })
        game.schedule(7300, {=> self.caerNota(0, azul, 90) })
        game.schedule(7600, {=> self.caerNota(0, verde, 90) })
        game.schedule(8400, {=> self.dosNotas(500, verde, azul, 90) })
        game.schedule(9400, {=> self.caerNota(0, amarilla, 90) })
    }

    method cuartaParte() {
        self.caerNota(0, roja, 90)
        self.caerNota(300, azul, 90)
        self.caerNota(1400, azul, 90)
        self.caerNota(1700, roja, 90)
        self.caerNota(3000, amarilla, 90)
        self.caerNota(4000, azul, 90)
    }

    method drop() {
        const notas = [
            [0, verde], [400, roja], [1300, amarilla], [1650, azul],
            [2000, roja], [2500, amarilla], [3500, azul], [3800, verde],
            [4500, amarilla], [5000, roja], [5300, verde], [5800, roja],
            [6100, amarilla]]
        notas.forEach({ par =>
        const tiempo = par.get(0)
        const color = par.get(1)
        game.schedule(tiempo, {=> self.caerNota(tiempo, color, 90)})})
    
    }
    method musicaCompleta() {
        if (menu.estadoJuego() == juego.estado()) game.schedule(0, {=> self.primerParte() })
        if (menu.estadoJuego() == juego.estado()) game.schedule(8500, {=> self.segundaParte() })
        if (menu.estadoJuego() == juego.estado()) game.schedule(11600, {=> self.terceraParte() })
        if (menu.estadoJuego() == juego.estado()) game.schedule(14200, {=> self.midGame() })
        if (menu.estadoJuego() == juego.estado()) game.schedule(23900, {=> self.cuartaParte() })
        if (menu.estadoJuego() == juego.estado()) game.schedule(31500, {=> self.puntosEnPantalla() })
        if (menu.estadoJuego() == juego.estado()) game.schedule(38200, {=> self.drop() })
    }
} 

// NIVEL 2 
object cancion2 inherits Nivel(notasTotales=84, duracion=54,musica=game.sound("cancionn2.mp3"), nivel=self) {

    method parte1() {
        game.schedule(1, {=> self.guitarraPrincipio() })
        game.schedule(1500, {=> self.guitarraPrincipio() })
        game.schedule(3000, {=> self.guitarraPrincipio() })
        game.schedule(4500, {=> self.guitarraPrincipio2() })
        game.schedule(6000, {=> self.guitarraPrincipio() })
        game.schedule(7500, {=> self.guitarraPrincipio2() })
        game.schedule(9000, {=> self.guitarraPrincipio() })
        game.schedule(11400, {=> self.guitarraPrincipio() })
    }

    method parte2() {
        game.schedule(1, {=> self.guitarraPrincipio2() })
        game.schedule(1200, {=> self.dobleDerecha() })
        game.schedule(3000, {=> self.dobleDerecha() })
        game.schedule(3600, {=> self.dobleIzquierda() })
        game.schedule(4400, {=> self.dobleDerechaInverso() })
        game.schedule(6000, {=> self.dobleIzquierda() })
        game.schedule(6700, {=> self.dobleIzquierdaInverso() })
        game.schedule(7700, {=> self.dobleDerechaInverso() })
        game.schedule(8400, {=> self.dobleIzquierdaInverso() })
        game.schedule(10700, {=> self.dobleDerecha() })
        game.schedule(11500, {=> self.dobleIzquierda() })
        game.schedule(12200, {=> self.dobleIzquierdaInverso() })
    }

    method parte3() {
        self.caerNota(1300, amarilla, 100)
        self.caerNota(1650, azul, 100)
        self.caerNota(2200, verde, 100)
        game.schedule(2600, {=> self.ritmo4() })
        self.caerNota(3500, roja, 100)
        self.caerNota(4000, verde, 100)
        self.caerNota(4300, verde, 100)
        self.caerNota(5000, azul, 100)
        self.caerNota(6300, roja, 100)
    }

    method parte4() {
        self.ritmo4()
        self.caerNota(900, amarilla, 90)
        self.caerNota(1500, roja, 90)
       
        game.schedule((2000), {=>self.dobleIzquierda()})
        game.schedule((2500), {=>self.dobleDerecha()})
        game.schedule((3000), {=>self.dobleDerechaInverso()})
        self.caerNota(3300, azul, 90)
        self.caerNota(3700, verde, 90)
        self.caerNota(4100, amarilla, 90)

        game.schedule((5000), {=>self.dobleIzquierdaInverso()})
        game.schedule((5500), {=>self.dobleIzquierda()})
        game.schedule((6000), {=>self.dobleDerechaInverso()})
        


        self.caerNota(7100, azul, 90)
        self.caerNota(7500, azul, 90)
        self.caerNota(8300, azul, 90)
    }

    method guitarraPrincipio() {
        self.cuatroNotas(250, 800, 1100, verde, roja, azul, amarilla, 90)
    }

    method guitarraPrincipio2() {
        self.cuatroNotas(250, 800, 1100, amarilla, azul, roja, verde, 90)
    }

    method dobleIzquierda() {
        self.dosNotas(250, verde, roja, 90)
    }

    method dobleDerecha() {
        self.dosNotas(250, amarilla, azul, 90)
    }

    method dobleIzquierdaInverso() {
        self.dosNotas(250, roja, verde, 90)
    }

    method dobleDerechaInverso() {
        self.dosNotas(250, azul, amarilla, 90)
    }

    method ritmo4() {
        self.tresNotas(700, 1200, amarilla, roja, amarilla, 90)
    }

    method drop() {
        game.schedule(0, {=> self.parte3() })
        game.schedule(10400, {=> self.parte4() })
    }

    method musicaCompleta() {
        game.schedule(1, {=> self.parte1() })
        game.schedule(13000, {=> self.parte2() })
        game.schedule(27200, {=> self.drop() })
    }
}

//////////////////////

// Imagenes de game over (cuando finaliza la partida)
object gameOver {
    method estado() = "gameOver"
    method iniciar() { 
        game.sound("game_over_sound.mp3").play()
        menu.cambiarEstado(self.estado())
        game.addVisual(imgGameOver)
    }
    method ocultar() {
        game.removeVisual(imgGameOver)
    }
}
object imgGameOver {
    method image() = "gameover2.png"
    method position() = game.at(0,0)
}
 /////////////////////
