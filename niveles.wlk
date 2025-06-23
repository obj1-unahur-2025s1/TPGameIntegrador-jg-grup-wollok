import player.*
import NotasyBotones.*
import Menu.*
import carteles.*
import teclado.*

object cancion1 {
    //METODO CERRAR NIVEL A TERMINAR (NO SE COMO PARAR LA MUSICA :( ))
    var property tecla = true
    const music = game.sound("cancionNivel1.mp3")
    method detener() {
        tecla = false
    }
    method cerrarNivel() {
        menu.mostrarMenuPrincipal()
        music.stop()
        self.detener()

        juego.eliminarVisuals()
    }
    method iniciar() {
        music.play()
        game.schedule(4300, {=>self.iniciaMusica()})
    }
    method tresNotas() {
        game.schedule(0, {=>if (tecla) {juego.crearNotaVerde(90)}})
        game.schedule(250, {=> if (tecla) {juego.crearNotaAzul(90) }})
    }
    method cuatroNotas() {
        game.schedule(0, {=>if (tecla) {self.tresNotas()}})
        game.schedule(750, {=>if (tecla) {juego.crearNotaAmarilla(90)}})
    }
    method primerParte() {
        game.schedule(0,{=>if (tecla) {self.tresNotas()}})
        game.schedule(1300, {=>if (tecla) {self.cuatroNotas()}})

        game.schedule(2500, {=>if (tecla) {self.tresNotas()}})
        game.schedule(3800, {=>if (tecla) {self.cuatroNotas()}})

        game.schedule(5000, {=>if (tecla) {self.tresNotas()}})
        game.schedule(6100, {=>if (tecla) {self.cuatroNotas()}})

        game.schedule(7400, {=>if (tecla) {self.tresNotas()}})

    }
    method segundaParte() {
        game.schedule(0, {if (tecla) {self.tresNotas()}})
        game.schedule(600, {=>if (tecla) {juego.crearNotaAmarilla(90)}})
        game.schedule(1100, {=>if (tecla) {juego.crearNotaRoja(90)}})
    }
    method terceraParte() {
        game.schedule(0, {=>if (tecla) {self.tresNotas()}})
        game.schedule(1200, {=>if (tecla) {juego.crearNotaAzul(90)}})

        game.schedule(1300, {=>if (tecla) {self.secuenciaDoble()}})
        game.schedule(2100, {=>if (tecla) {juego.crearNotaRoja(90)}})

    }
    method secuenciaDoble() {
        game.schedule(0,{=>if (tecla) {juego.crearNotaVerde(90)}}) 
        game.schedule(500, {=>if (tecla) {juego.crearNotaAzul(90)}})
    }
    method midGame() {
        game.schedule(0, {=>if (tecla) {self.tresNotas()}})
        game.schedule(2300, {=>if (tecla) {self.terceraParte()}})
        game.schedule(5000, {=>if (tecla) {self.tresNotas()}}) 

        game.schedule(7300, {=>if (tecla) {juego.crearNotaAzul(90)}})
        game.schedule(7600, {=>if (tecla) {juego.crearNotaVerde(90)}})

        game.schedule(8400, {=>if (tecla) {self.secuenciaDoble()}})    
        game.schedule(9400, {=>if (tecla) {juego.crearNotaAmarilla(90)}})

    }
    //ANTES DEL DROP CUARTA PARTE
    method cuartaParte() {
        game.schedule(0, {=>if (tecla) {juego.crearNotaRoja(90)}})
        game.schedule(300, {=>if (tecla) {juego.crearNotaAzul(90)}})
        game.schedule(1400, {=>if (tecla) {juego.crearNotaAzul(90)} })
        game.schedule(1700, {=>if (tecla) {juego.crearNotaRoja(90) }})
        
        game.schedule(3000, {=>if (tecla) {juego.crearNotaAmarilla(90)}})
        game.schedule(4000, {=>if (tecla) {juego.crearNotaAzul(90)}})
    }
    method drop() { 
        game.schedule(0, {=>if (tecla) {juego.crearNotaVerde(90)}})
        game.schedule(400, {=>if (tecla) {juego.crearNotaRoja(90)}})

        game.schedule(1300, {=>if (tecla) {juego.crearNotaAmarilla(90)}})
        game.schedule(1650, {=> if (tecla) {juego.crearNotaAzul(90)}})

        game.schedule(2000, {=> if (tecla) {juego.crearNotaRoja(90)}})
        game.schedule(2500, {=> if (tecla) {juego.crearNotaAmarilla(90)}})

        game.schedule(3500, {=> if (tecla) {juego.crearNotaAzul(90)}})
        game.schedule(3800, {=> if (tecla) {juego.crearNotaVerde(90)}})

        game.schedule(4500, {=> if (tecla) {juego.crearNotaAmarilla(90)}})

        game.schedule(5000, {=> if (tecla) {juego.crearNotaRoja(90)}})
        
        game.schedule(6200, {=> if (tecla) {juego.crearNotaVerde(90)}})

        game.schedule(7500, {=> if (tecla) {juego.crearNotaRoja(90)}})

        game.schedule(8500, {=> if (tecla) {juego.crearNotaAmarilla(90)}})
        game.schedule(9000, {=> if (tecla) {juego.crearNotaAzul(90)
            juego.crearNotaRoja(90)}})
    
        game.schedule(9300, {=> if (tecla) {juego.crearNotaVerde(90)}})

        game.schedule(9700, {=> if (tecla) {juego.crearNotaAmarilla(90)}})
        game.schedule(10200, {=> if (tecla) {juego.crearNotaAzul(90)
            juego.crearNotaRoja(90)}}) 

        game.schedule(10700, {=> if (tecla) {juego.crearNotaVerde(90)}})
        game.schedule(11100, {=> if (tecla) {juego.crearNotaAmarilla(90)}})       
        game.schedule(11700, {=> if (tecla) {juego.crearNotaRoja(90)}})       
    }

    method iniciaMusica() {
        game.schedule(0, {=>if(tecla){self.primerParte()}})
        game.schedule(8500, {=>if (tecla) {self.segundaParte()}})
        game.schedule(11600, {=>if (tecla) {self.terceraParte()}})
        game.schedule(14200, {=>if (tecla) {self.midGame()}})
        game.schedule(23900, {=>if (tecla) {self.cuartaParte()}})
        game.schedule(31500, {=>if (tecla) {self.puntosEnPantalla()}})
        game.schedule(38200, {=>if (tecla) {self.drop()}})
    }
    method puntosEnPantalla() {
        game.sound("sonido3.mp3").play()
        cartelPuntuacion.position(game.at(8,8))
        game.schedule(4000, {=> cartelPuntuacion.position(game.at(16, 12))})
    }
 }
 object cancion2 {
   
 }