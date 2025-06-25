import player.*
import NotasyBotones.*
import Menu.*
import carteles.*
import teclado.*


object cancion1 {

    const notasTotales = 70
    var property inicio = 1
    var property tecla = true
    const musica = game.sound("cancionNivel1.mp3")
    
    method detener() {
        tecla = false
        musica.stop()
    }
    method cerrarNivel() {
        if (menu.estadoJuego() == "win1") {
            win1.ocultarWin()
        } 
        else if (menu.estadoJuego() == "gameOver"){
            game.removeVisual(imgGameOver)
        }
        game.removeTickEvent("verificarFallos")
        game.removeTickEvent("caerse")
        menu.iniciar()
        self.detener()
        juego.eliminarVisuals()
        player.resetear()
    }
    method iniciar() {
            tecla = true
            musica.play()
            game.schedule(4300, {=>self.iniciaMusica()})
    }
    method tresNotas() {
        game.schedule(0, {=>juego.crearNotaVerde(90)})
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
    method musicaCompleta() {
        if (menu.estadoJuego() == "jugando" && tecla){game.schedule(0, {=>self.primerParte()})}
        if (menu.estadoJuego() == "jugando" && tecla){game.schedule(8500, {=>self.segundaParte()})}
        if (menu.estadoJuego() == "jugando" && tecla){game.schedule(11600, {=>self.terceraParte()})}
        if (menu.estadoJuego() == "jugando" && tecla){game.schedule(14200, {=>self.midGame()})}
        if (menu.estadoJuego() == "jugando" && tecla){game.schedule(23900, {=>self.cuartaParte()})}
        if (menu.estadoJuego() == "jugando" && tecla){game.schedule(31500, {=>self.puntosEnPantalla()})}
        if (menu.estadoJuego() == "jugando" && tecla){game.schedule(38200, {=>self.drop()})} 
    }
    method calcularPresicion() {
        return (player.hitsAcertados() / notasTotales) * 100 
    }
    method iniciaMusica() {
        self.musicaCompleta()
        game.schedule(56000, {=>if (player.vida() == 0) {
            gameOver.iniciar()
        } else {win1.iniciar()}})
    }
    method puntosEnPantalla() {
        game.sound("sonido3.mp3").play()
        cartelPuntuacion.position(game.at(7,8))
        game.schedule(8000, {=> cartelPuntuacion.position(game.at(16, 12))})
    }
}



object cancion2 {
    const notasTotales = 84
    var property tecla = true
    const music = game.sound("cancionn2.mp3")
    method detener() {
        tecla = false
    }
    
    method calcularPresicion() {
        return (player.hitsAcertados() / notasTotales) * 100 
    }

        method cerrarNivel() {
            if (menu.estadoJuego() == "win1") {
                win1.ocultarWin()
            } 
            else if (menu.estadoJuego() == "gameOver"){
                game.removeVisual(imgGameOver)
            }
        game.removeTickEvent("verificarFallos")
        game.removeTickEvent("caerse")
        menu.iniciar()
        self.detener()
        juego.eliminarVisuals()
        player.resetear()
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
    
   
   
    method secuenciaDoble() {
        game.schedule(0,{=>if (tecla) {juego.crearNotaVerde(90)}}) 
        game.schedule(500, {=>if (tecla) {juego.crearNotaVerde(90)}})
    }
    method parteFinal() {
        game.schedule(0, {=>if (tecla) {self.ritmo4()}})
        game.schedule(2000, {=>if (tecla) {self.ritmo4()}})
        game.schedule(4200, {=>if (tecla) {self.ritmo4()}})
        game.schedule(6100, {=>if (tecla) {juego.crearNotaAmarilla(90)}})
        game.schedule(6500, {=>if (tecla) {juego.crearNotaRoja(90)}})
        
        
       game.schedule(7100, {=> if (tecla) {juego.crearNotaAzul(90)}})////////
        game.schedule(7500, {=> if (tecla) {juego.crearNotaAzul(90)}})
        //game.schedule(7900, {=> if (tecla) {juego.crearNotaAzul(90)}})
        game.schedule(8300, {=> if (tecla) {juego.crearNotaAzul(90)}})


    }
   
    method ritmo4(){
         game.schedule(300, {=>if (tecla) {juego.crearNotaAmarilla(90)}})
        //game.schedule(650, {=> if (tecla) {juego.crearNotaAzul(90)}})

         game.schedule(1000, {=> if (tecla) {juego.crearNotaRoja(90)}})
        //game.schedule(1300, {=> if (tecla) {juego.crearNotaVerde(90)}})
        game.schedule(1500, {=> if (tecla) {juego.crearNotaAmarilla(90)}})
    }
    


    method parte1(){
        game.schedule(1, { => if (tecla) { self.guitarraPrincipio() } })    
        game.schedule(1500, { => if (tecla) { self.guitarraPrincipio() } }) 
        game.schedule(3000, { => if (tecla) { self.guitarraPrincipio() } }) 
        game.schedule(4500, { => if (tecla) { self.guitarraPrincipio2() } })  
        game.schedule(6000, { => if (tecla) { self.guitarraPrincipio() } }) 
        game.schedule(7500, { => if (tecla) { self.guitarraPrincipio2() } }) 
        game.schedule(9000, { => if (tecla) { self.guitarraPrincipio() } }) 
        game.schedule(11400, { => if (tecla) { self.guitarraPrincipio() } })
    }

    method parte2(){
        game.schedule(1, { => if (tecla) { self.guitarraPrincipio2() } })  
        game.schedule(1200, { => if (tecla) { self.dobleDerecha() } }) 
        //game.schedule(1900, { => if (tecla) { self.dobleIzquierda() } })   
        game.schedule(3000, { => if (tecla) { self.dobleDerecha() } }) 
        game.schedule(3600, { => if (tecla) { self.dobleIzquierda() } })   
        game.schedule(4400, { => if (tecla) { self.dobleDerechaInverso() } })
        //game.schedule(5200, { => if (tecla) { self.dobleDerecha() } }) 
        game.schedule(6000, { => if (tecla) { self.dobleIzquierda() } })
        game.schedule(6700, { => if (tecla) { self.dobleIzquierdaInverso() } })
        game.schedule(7700, { => if (tecla) { self.dobleDerechaInverso() } })
        game.schedule(8400, { => if (tecla) { self.dobleIzquierdaInverso() } })
        //game.schedule(9800, { => if (tecla) { self.dobleDerechaInverso() } })
        game.schedule(10700, { => if (tecla) { self.dobleDerecha() } })
        game.schedule(11500, { => if (tecla) { self.dobleIzquierda() } })
        game.schedule(12200, { => if (tecla) { self.dobleIzquierdaInverso() } })
    }
    method drop() { 

        game.schedule(1300, {=>if (tecla) {juego.crearNotaAmarilla(100)}})
        game.schedule(1650, {=> if (tecla) {juego.crearNotaAzul(100)}})
        //game.schedule(2000, {=> if (tecla) {juego.crearNotaRoja(100)}})
        game.schedule(2300, {=> if (tecla) {juego.crearNotaVerde(100)}})
        //game.schedule(2500, {=> if (tecla) {juego.crearNotaAmarilla(100)}})///
        game.schedule(3200, {=> if (tecla) {self.ritmo4()}})
        game.schedule(5200, {=> if (tecla) {juego.crearNotaRoja(100)}})
        game.schedule(6000, {=> if (tecla) {juego.crearNotaVerde(100)}})
        //game.schedule(6300, {=> if (tecla) {juego.crearNotaRoja(100)}})
        game.schedule(6800, {=> if (tecla) {juego.crearNotaAmarilla(100)}})
        //game.schedule(7300, {=> if (tecla) {juego.crearNotaAzul(100)}})
        game.schedule(8000, {=> if (tecla) {juego.crearNotaVerde(100)}})
        //game.schedule(8400, {=> if (tecla) {juego.crearNotaVerde(100)}})
        game.schedule(8800, {=> if (tecla) {juego.crearNotaVerde(100)}})
        //game.schedule(9400, {=> if (tecla) {juego.crearNotaAzul(100) }})
        game.schedule(9800, {=> if (tecla) {juego.crearNotaRoja(100)}})
        game.schedule(10400, {=> if (tecla) {self.parteFinal()}})
    }
    method iniciaMusica() {
    
        game.schedule(1, { => if (tecla) { self.parte1() } })
        game.schedule(13000, { => if (tecla) { self.parte2() } }) 
        game.schedule(27200, {=>if (tecla) {self.drop()}})
        game.schedule(52000, {=>if (player.vida() == 0) {
            gameOver.iniciar()
        } else {win1.iniciar()}})
        

    }
    method puntosEnPantalla() {
        game.sound("sonido3.mp3").play()
        imagenPuntos.position(game.at(3,8))
        cartelPuntuacion.position(game.at(8,8))
        game.schedule(4000, {=> cartelPuntuacion.position(game.at(16.5, 14))})
        game.schedule(4000, {=> imagenPuntos.position(game.at(14, 14.5))})
    }
 }