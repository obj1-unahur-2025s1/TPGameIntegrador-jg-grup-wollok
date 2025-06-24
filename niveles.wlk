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
    method activarNivel() {
        tecla = true
    }
    method cerrarNivel() {
        music.stop()
        menu.iniciar()
        self.detener()
        player.resetear()
        juego.eliminarNotasActivas()
        if (player.vida() == 0) {game.removeVisual(gameOver)}
        game.removeTickEvent("verificarFallos")
    }
    method iniciar() {
        self.activarNivel()
        music.play()
        game.schedule(4300, {=>self.iniciaMusica()})
    }
    method tresNotas() {
        game.schedule(0, {=>juego.crearNotaVerde(90)})
        game.schedule(250, {=> juego.crearNotaAzul(90)})
    }
    method cuatroNotas() {
        game.schedule(0, {=>self.tresNotas()})
        game.schedule(750, {=>juego.crearNotaAmarilla(90)})
    }
    method primerParte() {
        game.schedule(0,{=>self.tresNotas()})
        game.schedule(1300, {=>self.cuatroNotas()})

        game.schedule(2500, {=>self.tresNotas()})
        game.schedule(3800, {=>self.cuatroNotas()})

        game.schedule(5000, {=>self.tresNotas()})
        game.schedule(6100, {=>self.cuatroNotas()})

        game.schedule(7400, {=>self.tresNotas()})

    }
    method segundaParte() {
        game.schedule(0, {=>self.tresNotas()})
        game.schedule(600, {=>juego.crearNotaAmarilla(90)})
        game.schedule(1100, {=>juego.crearNotaRoja(90)})
    }
    method terceraParte() {
        game.schedule(0, {=>self.tresNotas()})
        game.schedule(1200, {=>juego.crearNotaAzul(90)})

        game.schedule(1300, {=>self.secuenciaDoble()})
        game.schedule(2100, {=>juego.crearNotaRoja(90)})

    }
    method secuenciaDoble() {
        game.schedule(0,{=>juego.crearNotaVerde(90)}) 
        game.schedule(500, {=>juego.crearNotaAzul(90)})
    }
    method midGame() {
        game.schedule(0, {=>self.tresNotas()})
        game.schedule(2300, {=>self.terceraParte()})
        game.schedule(5000, {=>self.tresNotas()}) 

        game.schedule(7300, {=>juego.crearNotaAzul(90)})
        game.schedule(7600, {=>juego.crearNotaVerde(90)})

        game.schedule(8400, {=>self.secuenciaDoble()})    
        game.schedule(9400, {=>juego.crearNotaAmarilla(90)})

    }
    //ANTES DEL DROP CUARTA PARTE
    method cuartaParte() {
        game.schedule(0, {=>juego.crearNotaRoja(90)})
        game.schedule(300, {=>juego.crearNotaAzul(90)})
        game.schedule(1400, {=>juego.crearNotaAzul(90)})
        game.schedule(1700, {=>juego.crearNotaRoja(90)})
        
        game.schedule(3000, {=>juego.crearNotaAmarilla(90)})
        game.schedule(4000, {=>juego.crearNotaAzul(90)})
    }
    method drop() { 
        game.schedule(0, {=>juego.crearNotaVerde(90)})
        game.schedule(400, {=>juego.crearNotaRoja(90)})

        game.schedule(1300, {=>juego.crearNotaAmarilla(90)})
        game.schedule(1650, {=> juego.crearNotaAzul(90)})

        game.schedule(2000, {=> juego.crearNotaRoja(90)})
        game.schedule(2500, {=> juego.crearNotaAmarilla(90)})

        game.schedule(3500, {=> juego.crearNotaAzul(90)})
        game.schedule(3800, {=> juego.crearNotaVerde(90)})

        game.schedule(4500, {=> juego.crearNotaAmarilla(90)})

        game.schedule(5000, {=> juego.crearNotaRoja(90)})
        
        game.schedule(6200, {=> juego.crearNotaVerde(90)})

        game.schedule(7500, {=> juego.crearNotaRoja(90)})

        game.schedule(8500, {=> juego.crearNotaAmarilla(90)})
        game.schedule(9000, {=> juego.crearNotaAzul(90)
            juego.crearNotaRoja(90)})
    
        game.schedule(9300, {=> juego.crearNotaVerde(90)})

        game.schedule(9700, {=> juego.crearNotaAmarilla(90)})
        game.schedule(10200, {=> juego.crearNotaAzul(90)
            juego.crearNotaRoja(90)}) 

        game.schedule(10700, {=> juego.crearNotaVerde(90)})
        game.schedule(11100, {=> juego.crearNotaAmarilla(90)})       
        game.schedule(11700, {=> juego.crearNotaRoja(90)})       
    }
    method musicaCompleta() {
        game.schedule(0, {=>self.primerParte()})
        game.schedule(8500, {=>self.segundaParte()})
        game.schedule(11600, {=>self.terceraParte()})
        game.schedule(14200, {=>self.midGame()})
        game.schedule(23900, {=>self.cuartaParte()})
        game.schedule(31500, {=>self.puntosEnPantalla()})
        game.schedule(38200, {=>self.drop()})
        // game.schedule(45000, {=>{win1.iniciar()}})
    }
    method iniciaMusica() {
        self.musicaCompleta()
    }
    method puntosEnPantalla() {
        game.sound("sonido3.mp3").play()
        cartelPuntuacion.position(game.at(8,8))
        game.schedule(4000, {=> cartelPuntuacion.position(game.at(16, 12))})
    }
 }
object cancion2 {
   var property tecla = true
    const music = game.sound("cancion2.mp3")
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
    
    method guitarraPrincipio(){
        game.schedule(500, { => if (tecla) { juego.crearNotaVerde(90) } })    
        game.schedule(750, { => if (tecla) { juego.crearNotaRoja(90) } })     
        game.schedule(1300, { => if (tecla) { juego.crearNotaAzul(90) } })     
        game.schedule(1600, { => if (tecla) { juego.crearNotaAmarilla(90)} })
    }
    method guitarraPrincipio2(){
        game.schedule(500, { => if (tecla) { juego.crearNotaAmarilla(90) } })    
        game.schedule(750, { => if (tecla) { juego.crearNotaAzul(90) } })     
        game.schedule(1300, { => if (tecla) { juego.crearNotaRoja(90) } })     
        game.schedule(1600, { => if (tecla) { juego.crearNotaVerde(90)} })
    }
    
   
   
    method secuenciaDoble() {
        game.schedule(0,{=>if (tecla) {juego.crearNotaVerde(90)}}) 
        game.schedule(500, {=>if (tecla) {juego.crearNotaVerde(90)}})
    }
    method ritmo1(){
        game.schedule(0, {=>if (tecla) {juego.crearNotaRoja(90)}})
        game.schedule(500, {=>if (tecla) {juego.crearNotaAmarilla(90)}})
        game.schedule(1500, {=>if (tecla) {juego.crearNotaAzul(90)}})
        game.schedule(2000, {=>if (tecla) {juego.crearNotaVerde(90)}})
    }

    method ritmo2(){
        game.schedule(0, {=>if (tecla) {juego.crearNotaRoja(90)}})
        game.schedule(500, {=>if (tecla) {juego.crearNotaAmarilla(90)}})
        game.schedule(1500, {=>if (tecla) {self.dobleIzquierdaInverso()}})
      
        
    }

    method ritmo3(){
        game.schedule(1600, {=>if (tecla) {juego.crearNotaRoja(90)}})
        game.schedule(200, {=>if (tecla) {juego.crearNotaAmarilla(90)}})
        game.schedule(500, {=>if (tecla) {juego.crearNotaAzul(90)}})
        game.schedule(1500, {=>if (tecla) {self.dobleIzquierda()}})

    }
    method midGame() {
        game.schedule(0, {=>if (tecla) {self.ritmo1()}})
        game.schedule(2300, {=>if (tecla) {self.ritmo2()}})
        game.schedule(4600, {=>if (tecla) {self.ritmo3()}})
        
       
        game.schedule(6200, {=>if (tecla) {juego.crearNotaAmarilla(90)}})
        game.schedule(7600, {=> if (tecla) {juego.crearNotaAzul(90)}})////////
        game.schedule(8000, {=> if (tecla) {juego.crearNotaAzul(90)}})
        game.schedule(8400, {=> if (tecla) {juego.crearNotaAzul(90)}})
        game.schedule(8800, {=> if (tecla) {juego.crearNotaAzul(90)}})


    }
   
    method drop() { 
        game.schedule(0, {=>if (tecla) {juego.crearNotaVerde(100)}})
        game.schedule(400, {=>if (tecla) {juego.crearNotaRoja(100)}})

        game.schedule(1300, {=>if (tecla) {juego.crearNotaAmarilla(100)}})
        game.schedule(1650, {=> if (tecla) {juego.crearNotaAzul(100)}})

        game.schedule(2000, {=> if (tecla) {juego.crearNotaRoja(100)}})
        game.schedule(2500, {=> if (tecla) {juego.crearNotaAmarilla(100)}})
        game.schedule(2300, {=> if (tecla) {juego.crearNotaVerde(100)}})

        game.schedule(3500, {=> if (tecla) {juego.crearNotaAzul(100)}})
        game.schedule(3800, {=> if (tecla) {juego.crearNotaRoja(100)}})
        game.schedule(4500, {=> if (tecla) {juego.crearNotaAmarilla(100)}})
        game.schedule(4700, {=> if (tecla) {juego.crearNotaVerde(100)}})
        game.schedule(5200, {=> if (tecla) {juego.crearNotaRoja(100)}})
        
        game.schedule(6000, {=> if (tecla) {juego.crearNotaVerde(100)}})
        game.schedule(6300, {=> if (tecla) {juego.crearNotaRoja(100)}})
        game.schedule(6800, {=> if (tecla) {juego.crearNotaAmarilla(100)}})

        game.schedule(7300, {=> if (tecla) {juego.crearNotaAzul(100)}})
        
        game.schedule(8000, {=> if (tecla) {juego.crearNotaVerde(100)}})
        game.schedule(8400, {=> if (tecla) {juego.crearNotaVerde(100)}})
        game.schedule(8800, {=> if (tecla) {juego.crearNotaVerde(100)}})
        game.schedule(9400, {=> if (tecla) {juego.crearNotaAzul(100) }})
         game.schedule(9800, {=> if (tecla) {juego.crearNotaRoja(100)}})
        game.schedule(10400, {=> if (tecla) {self.midGame()}})
    }

    method dobleIzquierda(){
        game.schedule(500, { => if (tecla) { juego.crearNotaVerde(90) } })    
        game.schedule(750, { => if (tecla) { juego.crearNotaRoja(90) } })     
    }

     method dobleDerecha(){
         game.schedule(500, { => if (tecla) { juego.crearNotaAmarilla(90) } })    
         game.schedule(750, { => if (tecla) { juego.crearNotaAzul(90) } })     
    }
     method dobleIzquierdaInverso(){
        game.schedule(500, { => if (tecla) { juego.crearNotaRoja(90) } })  
        game.schedule(750, { => if (tecla) { juego.crearNotaVerde(90) } }) 
     }
    method dobleDerechaInverso(){
        game.schedule(500, { => if (tecla) { juego.crearNotaAzul(90) } }) 
        game.schedule(750, { => if (tecla) { juego.crearNotaAmarilla(90) } })    
         
    }
    method iniciaMusica() {
    
         game.schedule(1, { => if (tecla) { self.guitarraPrincipio() } })    
         game.schedule(2100, { => if (tecla) { self.guitarraPrincipio() } }) 
         game.schedule(3500, { => if (tecla) { self.guitarraPrincipio() } })
         game.schedule(5000, { => if (tecla) { self.guitarraPrincipio2() } })   
        game.schedule(6400, { => if (tecla) { self.guitarraPrincipio() } })
        game.schedule(7900, { => if (tecla) { self.guitarraPrincipio2() } })
         game.schedule(9900, { => if (tecla) { self.guitarraPrincipio() } })
        game.schedule(11400, { => if (tecla) { self.guitarraPrincipio() } })
        game.schedule(13000, { => if (tecla) { self.guitarraPrincipio2() } })
        game.schedule(13700, { => if (tecla) { juego.crearNotaAzul(90) } })/////
        game.schedule(14200, { => if (tecla) { self.dobleDerecha() } }) 
        game.schedule(14900, { => if (tecla) { self.dobleIzquierda() } })    
        game.schedule(16000, { => if (tecla) { self.dobleDerecha() } }) 
        game.schedule(16600, { => if (tecla) { self.dobleIzquierda() } })  
        game.schedule(17400, { => if (tecla) { self.dobleDerechaInverso() } })
        game.schedule(18200, { => if (tecla) { self.dobleDerecha() } }) 
        game.schedule(19000, { => if (tecla) { self.dobleIzquierda() } })
        game.schedule(19700, { => if (tecla) { self.dobleIzquierdaInverso() } })
        game.schedule(20700, { => if (tecla) { self.dobleDerechaInverso() } })
        game.schedule(21400, { => if (tecla) { self.dobleIzquierdaInverso() } })
        game.schedule(22800, { => if (tecla) { self.dobleDerechaInverso() } })
        game.schedule(23700, { => if (tecla) { self.dobleDerecha() } })
        game.schedule(24500, { => if (tecla) { self.dobleIzquierda() } })
        game.schedule(25500, { => if (tecla) { self.dobleIzquierdaInverso() } })/////////////////////
         game.schedule(27200, {=>if (tecla) {self.drop()}})
        
    }
    method puntosEnPantalla() {
        game.sound("sonido3.mp3").play()
        imagenPuntos.position(game.at(3,8))
        cartelPuntuacion.position(game.at(8,8))
        game.schedule(4000, {=> cartelPuntuacion.position(game.at(16.5, 14))})
        game.schedule(4000, {=> imagenPuntos.position(game.at(14, 14.5))})
    }
 }