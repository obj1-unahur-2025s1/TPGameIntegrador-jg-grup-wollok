import player.*
import NotasyBotones.*
import Menu.*
import carteles.*
import teclado.*
import wollokJuego.*

// NIVEL 1 
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
        if (menu.estadoJuego() == win1.estado()) {
            win1.ocultarWin()
        } 
        else if (menu.estadoJuego() == gameOver.estado()){
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
        game.schedule(0, {=>juego.crearNota(verde, 90)})
        game.schedule(250, {=> juego.crearNota(azul, 90) })
    }
    method cuatroNotas() {
        game.schedule(0, {=>self.tresNotas()})
        game.schedule(750, {=>juego.crearNota(amarillo, 90)})
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
        game.schedule(0, {self.tresNotas()})
        game.schedule(600, {=>juego.crearNota(amarillo, 90)})
        game.schedule(1100, {=>juego.crearNota( rojo, 90)})
    }
    method terceraParte() {
        game.schedule(0, {=>self.tresNotas()})
        game.schedule(1200, {=>juego.crearNota(azul, 90)})

        game.schedule(1300, {=> self.secuenciaDoble()})
        game.schedule(2100, {=>juego.crearNota(rojo, 90)})

    }
    method secuenciaDoble() {
        game.schedule(0,{=>juego.crearNota(verde, 90)}) 
        game.schedule(500, {=>juego.crearNota(azul, 90)})
    }
    method midGame() {
        game.schedule(0, {=>self.tresNotas()})
        game.schedule(2300, {=>self.terceraParte()})
        game.schedule(5000, {=>self.tresNotas()}) 

        game.schedule(7300, {=>juego.crearNota(azul, 90)})
        game.schedule(7600, {=>juego.crearNota(verde, 90)})

        game.schedule(8400, {=>self.secuenciaDoble()})    
        game.schedule(9400, {=>juego.crearNota(amarillo, 90)})

    }
    //ANTES DEL DROP CUARTA PARTE
    method cuartaParte() {
        game.schedule(0, {=>juego.crearNota(rojo, 90)})
        game.schedule(300, {=>juego.crearNota(azul, 90)})
        game.schedule(1400, {=>juego.crearNota(azul, 90)} )
        game.schedule(1700, {=>juego.crearNota(rojo, 90) })
        
        game.schedule(3000, {=>juego.crearNota(amarillo, 90)})
        game.schedule(4000, {=>juego.crearNota(azul, 90)})
    }
    method drop() { 
        game.schedule(0, {=>juego.crearNota(verde, 90)})
        game.schedule(400, {=>juego.crearNota(rojo, 90)})

        game.schedule(1300, {=>juego.crearNota(amarillo, 90)})
        game.schedule(1650, {=> juego.crearNota(azul, 90)})

        game.schedule(2000, {=> juego.crearNota(rojo, 90)})
        game.schedule(2500, {=> juego.crearNota(amarillo, 90)})

        game.schedule(3500, {=> juego.crearNota(azul, 90)})
        game.schedule(3800, {=> juego.crearNota(verde, 90)})

        game.schedule(4500, {=> juego.crearNota(amarillo, 90)})

        game.schedule(5000, {=> juego.crearNota(rojo, 90)})
        
        game.schedule(6200, {=> juego.crearNota(verde, 90)})

        game.schedule(7500, {=> juego.crearNota(rojo, 90)})

        game.schedule(8500, {=> juego.crearNota(amarillo ,90)})
        game.schedule(9000, {=> juego.crearNota(azul, 90)
            juego.crearNota(rojo, 90)})
    
        game.schedule(9300, {=> juego.crearNota(verde, 90)})

        game.schedule(9700, {=> juego.crearNota(amarillo, 90)})
        game.schedule(10200, {=> juego.crearNota(azul, 90)
            juego.crearNota(rojo, 90)}) 

        game.schedule(10700, {=> juego.crearNota(verde, 90)})
        game.schedule(11100, {=> juego.crearNota(amarillo, 90)})       
        game.schedule(11700, {=> juego.crearNota(rojo, 90)})       
    }
    method musicaCompleta() {
        if (menu.estadoJuego() == juego.estado()){game.schedule(0, {=>self.primerParte()})}
        if (menu.estadoJuego() == juego.estado()){game.schedule(8500, {=>self.segundaParte()})}
        if (menu.estadoJuego() == juego.estado()){game.schedule(11600, {=>self.terceraParte()})}
        if (menu.estadoJuego() == juego.estado()){game.schedule(14200, {=>self.midGame()})}
        if (menu.estadoJuego() == juego.estado()){game.schedule(23900, {=>self.cuartaParte()})}
        if (menu.estadoJuego() == juego.estado()){game.schedule(31500, {=>self.puntosEnPantalla()})}
        if (menu.estadoJuego() == juego.estado()){game.schedule(38200, {=>self.drop()})} 
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
        game.schedule(7300, {=> cartelPuntuacion.position(game.at(16, 12))})
    }
}

// NIVEL 2 
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
            if (menu.estadoJuego() == win1.estado()) {
                win1.ocultarWin()
            } 
            else if (menu.estadoJuego() == gameOver.estado()){
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
        game.schedule(0, {=>juego.crearNota(verde, 90)})
        game.schedule(250, {=> juego.crearNota(azul, 90) })
    }
    
    method guitarraPrincipio(){
        game.schedule(500, { =>  juego.crearNota(verde, 90) } )    
        game.schedule(750, { =>  juego.crearNota(rojo, 90) } )     
        game.schedule(1300, { =>  juego.crearNota(azul, 90) } )     
        game.schedule(1600, { =>  juego.crearNota(amarillo, 90)})
    }
    method guitarraPrincipio2(){
        game.schedule(500, { =>  juego.crearNota(amarillo, 90)  })    
        game.schedule(750, { =>  juego.crearNota(azul, 90)  })     
        game.schedule(1300, { =>  juego.crearNota(rojo, 90)  })     
        game.schedule(1600, { =>  juego.crearNota(verde, 90) })
    }
    method dobleIzquierda(){
        game.schedule(500, { =>  juego.crearNota(verde, 90)  })    
        game.schedule(750, { =>  juego.crearNota(rojo, 90)  })     
    }

    method dobleDerecha(){
        game.schedule(500, { =>  juego.crearNota(amarillo, 90)  })    
        game.schedule(750, { =>  juego.crearNota(azul, 90)  })     
    }
    method dobleIzquierdaInverso(){
        game.schedule(500, { =>  juego.crearNota(rojo, 90)  })  
        game.schedule(750, { =>  juego.crearNota(verde, 90)  }) 
    }
    method dobleDerechaInverso(){
        game.schedule(500, { =>  juego.crearNota(azul, 90) }) 
        game.schedule(750, { =>  juego.crearNota(amarillo, 90)  })    
        
    }

    method secuenciaDoble() {
        game.schedule(0,{=>juego.crearNota(verde, 90)}) 
        game.schedule(500, {=>juego.crearNota(verde, 90)})
    }
    method parteFinal() {
        game.schedule(0, {=>self.ritmo4()})
        game.schedule(2000, {=>self.ritmo4()})
        game.schedule(4200, {=>self.ritmo4()})
        game.schedule(6100, {=>juego.crearNota(amarillo, 90)})
        game.schedule(6500, {=>juego.crearNota(rojo, 90)})
        game.schedule(7100, {=> juego.crearNota(azul, 90)})
        game.schedule(7500, {=> juego.crearNota(azul, 90)})
        game.schedule(8300, {=> juego.crearNota(azul, 90)})
    }

    method ritmo4(){
        game.schedule(300, {=>juego.crearNota(amarillo, 90)})
        game.schedule(1000, {=> juego.crearNota(rojo, 90)})
        game.schedule(1500, {=> juego.crearNota(amarillo, 90)})
    }
    method parte1(){
        game.schedule(1, { =>  self.guitarraPrincipio()  })    
        game.schedule(1500, { =>  self.guitarraPrincipio() }) 
        game.schedule(3000, { =>  self.guitarraPrincipio()  }) 
        game.schedule(4500, { =>  self.guitarraPrincipio2()  })  
        game.schedule(6000, { =>  self.guitarraPrincipio()  }) 
        game.schedule(7500, { =>  self.guitarraPrincipio2()  }) 
        game.schedule(9000, { =>  self.guitarraPrincipio()  }) 
        game.schedule(11400, { =>  self.guitarraPrincipio() })
    }

    method parte2(){
        game.schedule(1, { =>  self.guitarraPrincipio2()  })  
        game.schedule(1200, { =>  self.dobleDerecha()  }) 
        game.schedule(3000, { =>  self.dobleDerecha()  }) 
        game.schedule(3600, { =>  self.dobleIzquierda()  })   
        game.schedule(4400, { =>  self.dobleDerechaInverso()  })
        game.schedule(6000, { =>  self.dobleIzquierda()  })
        game.schedule(6700, { =>  self.dobleIzquierdaInverso()  })
        game.schedule(7700, { =>  self.dobleDerechaInverso()  })
        game.schedule(8400, { =>  self.dobleIzquierdaInverso()  })
        game.schedule(10700, { =>  self.dobleDerecha()  })
        game.schedule(11500, { =>  self.dobleIzquierda()  })
        game.schedule(12200, { =>  self.dobleIzquierdaInverso()  })
    }
    method drop() { 

        game.schedule(1300, {=>juego.crearNota(amarillo, 100)})
        game.schedule(1650, {=> juego.crearNota(azul, 100)})
        game.schedule(2300, {=> juego.crearNota(verde, 100)})
        game.schedule(3200, {=> self.ritmo4()})
        game.schedule(5200, {=> juego.crearNota(rojo, 100)})
        game.schedule(6000, {=> juego.crearNota(verde, 100)})
        game.schedule(6800, {=> juego.crearNota(amarillo, 100)})
        game.schedule(8000, {=> juego.crearNota(verde, 100)})
        game.schedule(8800, {=> juego.crearNota(verde, 100)})
        game.schedule(9800, {=> juego.crearNota(rojo, 100)})
        game.schedule(10400, {=> self.parteFinal()})
    }
    method iniciaMusica() {
    
        game.schedule(1, { =>  self.parte1() })
        game.schedule(13000, { =>  self.parte2()  }) 
        game.schedule(27200, {=>self.drop()})
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
//////////////////////

// Imagenes de game over (cuando finaliza la partida)
object gameOver{
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
