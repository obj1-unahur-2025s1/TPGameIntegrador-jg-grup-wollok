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
        game.schedule(0, {=>if (tecla) {juego.crearNotaVerde()}})
        game.schedule(250, {=> if (tecla) {juego.crearNotaAzul() }})
    }
    method cuatroNotas() {
        game.schedule(0, {=>if (tecla) {self.tresNotas()}})
        game.schedule(750, {=>if (tecla) {juego.crearNotaAmarilla()}})
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
        game.schedule(600, {=>if (tecla) {juego.crearNotaAmarilla()}})
        game.schedule(1100, {=>if (tecla) {juego.crearNotaRoja()}})
    }
    method terceraParte() {
        game.schedule(0, {=>if (tecla) {self.tresNotas()}})
        game.schedule(1200, {=>if (tecla) {juego.crearNotaAzul()}})

        game.schedule(1300, {=>if (tecla) {self.secuenciaDoble()}})
        game.schedule(2100, {=>if (tecla) {juego.crearNotaRoja()}})

    }
    method secuenciaDoble() {
        game.schedule(0,{=>if (tecla) {juego.crearNotaVerde()}}) 
        game.schedule(500, {=>if (tecla) {juego.crearNotaAzul()}})
    }
    method midGame() {
        game.schedule(0, {=>if (tecla) {self.tresNotas()}})
        game.schedule(2300, {=>if (tecla) {self.terceraParte()}})
        game.schedule(5000, {=>if (tecla) {self.tresNotas()}}) 

        game.schedule(7300, {=>if (tecla) {juego.crearNotaAzul()}})
        game.schedule(7600, {=>if (tecla) {juego.crearNotaVerde()}})

        game.schedule(8400, {=>if (tecla) {self.secuenciaDoble()}})    
        game.schedule(9400, {=>if (tecla) {juego.crearNotaAmarilla()}})

    }
    //ANTES DEL DROP CUARTA PARTE
    method cuartaParte() {
        game.schedule(0, {=>if (tecla) {juego.crearNotaRoja()}})
        game.schedule(300, {=>if (tecla) {juego.crearNotaAzul()}})
        game.schedule(1400, {=>if (tecla) {juego.crearNotaAzul()} })
        game.schedule(1700, {=>if (tecla) {juego.crearNotaRoja() }})
        
        game.schedule(3000, {=>if (tecla) {juego.crearNotaAmarilla()}})
        game.schedule(4000, {=>if (tecla) {juego.crearNotaAzul()}})
    }
    method drop() { 
        game.schedule(0, {=>if (tecla) {juego.crearNotaVerde()}})
        game.schedule(400, {=>if (tecla) {juego.crearNotaRoja()}})

        game.schedule(1300, {=>if (tecla) {juego.crearNotaAmarilla()}})
        game.schedule(1650, {=> if (tecla) {juego.crearNotaAzul()}})

        game.schedule(2000, {=> if (tecla) {juego.crearNotaRoja()}})
        game.schedule(2500, {=> if (tecla) {juego.crearNotaAmarilla()}})

        game.schedule(3500, {=> if (tecla) {juego.crearNotaAzul()}})
        game.schedule(3800, {=> if (tecla) {juego.crearNotaVerde()}})

        game.schedule(4500, {=> if (tecla) {juego.crearNotaAmarilla()}})

        game.schedule(5000, {=> if (tecla) {juego.crearNotaRoja()}})
        
        game.schedule(6200, {=> if (tecla) {juego.crearNotaVerde()}})

        game.schedule(7500, {=> if (tecla) {juego.crearNotaRoja()}})

        game.schedule(8500, {=> if (tecla) {juego.crearNotaAmarilla()}})
        game.schedule(9400, {=> if (tecla) {juego.crearNotaAzul()
            juego.crearNotaRoja()}})
    }
    method iniciaMusica() {
    
        game.schedule(1, {=>if(tecla){self.primerParte()}})
        game.schedule(8500, {=>if (tecla) {self.segundaParte()}})
        game.schedule(11600, {=>if (tecla) {self.terceraParte()}})
        game.schedule(14200, {=>if (tecla) {self.midGame()}})
        game.schedule(23900, {=>if (tecla) {self.cuartaParte()}})
        game.schedule(31500, {=>if (tecla) {self.puntosEnPantalla()}})
        game.schedule(38200, {=>if (tecla) {self.drop()}})
    }
    method puntosEnPantalla() {
        game.sound("sonido3.mp3").play()
        imagenPuntuacion.position(game.at(3,8))
        cartelPuntuacion.position(game.at(8,8))
        game.schedule(4000, {=> cartelPuntuacion.position(game.at(16.5, 14))})
        game.schedule(4000, {=> imagenPuntuacion.position(game.at(14, 14.5))})
    }
 }
 object cancion2 {
   
 }