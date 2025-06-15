
object juego {
    var property notasActivas = []

    method iniciar() {
        
        game.addVisual(botonVerde)
        game.addVisual(botonRojo)
        game.addVisual(botonAmarillo)
        game.addVisual(botonAzul)
        game.addVisual(cartelPuntuacion)
        game.addVisual(imagenPuntuacion)
        game.addVisual(cartelFallos)
        game.addVisual(cartelVida)

        cancion1.iniciar()
        teclado.iniciar()
        
        game.onTick(50, "verificarFallos", { => self.verificarNotasFalladas() })

    }

    method eliminarVisuals() {
        game.removeVisual(botonAmarillo)
        game.removeVisual(botonAzul)
        game.removeVisual(botonRojo)
        game.removeVisual(botonVerde)
        game.removeVisual(cartelFallos)
        game.removeVisual(imagenPuntuacion)
        game.removeVisual(cartelHits)
        game.removeVisual(cartelVida)
    }
    
    method pulsarNotaEn(unBoton) {
        
        const notaCercana = notasActivas.findOrElse({n =>
        n.botonAsignado() == unBoton &&
        (n.position().equals(unBoton.position()))
    },{null})
        if (notaCercana != null) {
            notaCercana.hit()
            notasActivas.remove(notaCercana)
            cartelPuntuacion.actualizar(player.puntuacion())
        } else {
            game.sound("sonido2.mp3").play()
            player.sumarFallo()
            player.reiniciarMultiplicador()
            notasActivas.remove(notaCercana)
            cartelFallos.actualizarFallo(player.fallos())
            player.restarVida()

        }
    }

    method verificarNotasFalladas() {
        const posicionParaFallo = -4 

        const notasFalladas = notasActivas.filter({ n =>
            n.position().y() < (n.botonAsignado().position().y() + posicionParaFallo)
        })
        
        notasFalladas.forEach({ n =>
            game.sound("sonido2.mp3").play()
            n.fail()
            notasActivas.remove(n)
            game.removeVisual(n)
            cartelFallos.actualizarFallo(player.fallos())
            player.restarVida()
        })
    }



    method crearNotaVerde() {
        const notaNueva = new Notas(image = "note1.png",  position = game.at(2,18), botonAsignado = botonVerde)
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
    }
    method crearNotaRoja() {
        const notaNueva = new Notas(image = "note2.png", position = game.at(5,18), botonAsignado = botonRojo)
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
    }
    method crearNotaAmarilla() {
        const notaNueva = new Notas(image = "note3.png", position = game.at(8,18), botonAsignado = botonAmarillo)
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
    }
    method crearNotaAzul() {
        const notaNueva = new Notas(image = "note4.png", position = game.at(11,18), botonAsignado = botonAzul)
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
    }
}

object teclado {
    var property estaVerdePrendido = false
    var property estaRojoPrendido = false
    var property estaAmarilloPrendido = false
    var property estaAzulPrendido = false
    var property juegoAsociado = juego

    method iniciar(){
        keyboard.a().onPressDo({=>juegoAsociado.pulsarNotaEn(botonVerde)
        if (!estaVerdePrendido) {
                estaVerdePrendido = true
                botonVerde.cambiarImage(botonVerde.botonHit()) 

                game.removeTickEvent("apagadoBotonVerde")
                game.onTick(300, "apagadoBotonVerde", {
                estaVerdePrendido = false
                botonVerde.cambiarImage(botonVerde.imagenApagado())
                game.removeTickEvent("apagadoBotonVerde")
                })
            }})
        keyboard.s().onPressDo({=>juegoAsociado.pulsarNotaEn(botonRojo)
        if (!estaRojoPrendido) {
                estaRojoPrendido = true
                botonRojo.cambiarImage(botonRojo.botonHit()) 

                game.removeTickEvent("apagadoBotonRojo")
                game.onTick(300, "apagadoBotonRojo", { =>
                    estaRojoPrendido = false
                    botonRojo.cambiarImage(botonRojo.imagenApagado())
                    game.removeTickEvent("apagadoBotonRojo")
                })
            }})
        keyboard.d().onPressDo({=>juegoAsociado.pulsarNotaEn(botonAmarillo)
            if (!estaAmarilloPrendido) {
                estaAmarilloPrendido = true
                botonAmarillo.cambiarImage(botonAmarillo.botonHit())

                game.removeTickEvent("apagadoBotonAmarillo")
                game.onTick(300, "apagadoBotonAmarillo", { =>
                    estaAmarilloPrendido = false
                    botonAmarillo.cambiarImage(botonAmarillo.imagenApagado())
                    game.removeTickEvent("apagadoBotonAmarillo")
                })
            }})

        keyboard.f().onPressDo({=>juegoAsociado.pulsarNotaEn(botonAzul)
            if (!estaAzulPrendido) {
                estaAzulPrendido = true
                botonAzul.cambiarImage(botonAzul.botonHit()) 
                game.removeTickEvent("apagadoBotonAzul")
                game.onTick(300, "apagadoBotonAzul", { =>
                    estaAzulPrendido = false
                    botonAzul.cambiarImage(botonAzul.imagenApagado())
                    game.removeTickEvent("apagadoBotonAzul")
                })
            }})
    }
}



object cancion1 {
    method iniciar() {
        game.schedule(100, {=>juego.crearNotaVerde()})
        game.schedule(2000, {=>juego.crearNotaRoja()})
        game.schedule(4000, {=>juego.crearNotaAzul()})
        game.schedule(6000, {=>juego.crearNotaVerde()})
        game.schedule(8000, {=>juego.crearNotaVerde()})
        game.schedule(9000, {=>juego.crearNotaAzul()})
        game.schedule(12000, {=>juego.crearNotaAmarilla()})
        game.schedule(15000, {=>juego.crearNotaVerde()})
        game.schedule(18990, {=>juego.crearNotaVerde()})
        game.schedule(20000, {=>juego.crearNotaAzul()})
        game.schedule(23000, {=>juego.crearNotaAmarilla()})
        game.schedule(27000, {=>juego.crearNotaAzul()})
        game.schedule(30000, {=>juego.crearNotaVerde()})
        game.schedule(34000, {=>juego.crearNotaRoja()})
        game.schedule(38000, {=>juego.crearNotaAzul()})
        game.schedule(40000, {=>juego.crearNotaVerde()})
        game.schedule(42000, {=>juego.crearNotaVerde()})
        game.schedule(45000, {=>juego.crearNotaAzul()})
        game.schedule(48000, {=>juego.crearNotaAmarilla()})
        game.schedule(50000, {=>juego.crearNotaVerde()})
        game.schedule(54000, {=>juego.crearNotaVerde()})
        game.schedule(58000, {=>juego.crearNotaAzul()})
        game.schedule(60000, {=>juego.crearNotaAmarilla()})
        game.schedule(62000, {=>juego.crearNotaAzul()})
    }
}


object imagenPuntuacion {
    method position() = game.at(14, 14.5)
    method image() = "puntuacionchica.png"
}

object cartelPuntuacion {
    var property position = game.at(16.5, 14)
    var property text = ": 0"
    var property size = 50

    method actualizar(nuevaPuntuacion) {
        self.text(": " + nuevaPuntuacion)
    }
    
}

object cartelHits {
    var property position = game.at(17,14)
    var property text = "Hits: 0"
    var property size = 20 

    method actualizarHits(nuevoHits) {
        self.text("Puntuación: " + nuevoHits)
    }
    
}
object cartelFallos {
    var property text = "Fallos: 0" 
    var property size = 20
    var property position = game.at(17,13)
    
    method actualizarFallo(cantFallos) {
        self.text("Fallos: " + cantFallos)
    }
}

object cartelVida {
    var property text = "Vida: 3" 
    var property size = 20
    var property position = game.at(17,12)
    
    method actualizarVida(cantVida) {
        self.text("Vida: " + cantVida)
    }
}

// PLAYER 
object player {
    // seguro
    var property puntuacion = 0 // puntuacion del jugador
    var property multiplicador = 1 // maximo 4 sin poder, maximo 8 con poder
    var property energia =  0 //maximo 10
    var property fallos = 0 // cantidad de fallos
    var property consecutiveHits = 0
    var property vida = 3

    method restarVida() {
        if(fallos >= 20) {
            vida = (vida- 1).max(0)
            fallos = 0
            cartelVida.actualizarVida(self.vida())
        }
    }
    
    
    method sumarFallo() {fallos += 1}
    method sumarPuntuacion(valor) {puntuacion += valor}
    method aumentarMultiplicador() {
        consecutiveHits += 1 // Increment streak
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

//NOTAS

class Notas {
    var property image 
    
    var property puntuacion = 2
    var property position
    var property botonAsignado


     //ELIMINA LA NOTA
    method eliminar() {
        game.removeVisual(self)
        
    }

    

    method queCaiga() {
        game.onTick(100,"caerse", {self.position(self.position().down(1))})
    }

    //SISTEMA DE PUNTUACION
    method hit() {
        
        player.sumarPuntuacion(puntuacion * player.multiplicador())
        self.eliminar()
        player.aumentarMultiplicador()

        }
        
    

    // SISTEMA DE REINICIO 
    method fail() {
        player.sumarFallo()
        player.reiniciarMultiplicador()
        
        
    }
}
// // BOTONES

class Botones {
    var property position
    var property imagenApagado     
    var property imagenActual      
    var property botonHit

    method image() = imagenActual
    method position() = position
    method cambiarImage(png) { imagenActual = png }
}

object botonVerde inherits Botones(position = game.at(2,1), imagenApagado = "boton1.png", imagenActual = "boton1.png" ,botonHit = "boton1Hit.png"){

}
object botonRojo inherits Botones(position = game.at(5,1), imagenApagado = "boton2.png", imagenActual = "boton2.png", botonHit = "boton2Hit.png"){

}
object botonAmarillo inherits Botones(position = game.at(8,1), imagenApagado = "boton3.png", imagenActual ="boton3.png", botonHit = "boton3Hit.png"){

}
object botonAzul inherits Botones(position = game.at(11,1), imagenApagado = "boton4.png", imagenActual = "boton4.png", botonHit = "boton4Hit.png"){

}
object botonNaranja inherits Botones(position = game.at(14,1), imagenApagado = "boton5.png", imagenActual = "boton5.png", botonHit = "boton5Hit.png"){

}

