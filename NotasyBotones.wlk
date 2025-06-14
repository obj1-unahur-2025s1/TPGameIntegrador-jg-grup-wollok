


object juego {
    var property notasActivas = []
    var property estaVerdePrendido = false
    var property estaRojoPrendido = false
    var property estaAmarilloPrendido = false
    var property estaAzulPrendido = false

    method iniciar() {



        game.addVisual(botonVerde)
        game.addVisual(botonRojo)
        game.addVisual(botonAmarillo)
        game.addVisual(botonAzul)
        game.addVisual(cartelPuntuacion) 
        game.addVisual(cartelFallos)
        game.addVisual(cartelVida)

        game.schedule(100, {=>self.crearNotaVerde()})
        game.schedule(2000, {=>self.crearNotaRoja()})
        game.schedule(4000, {=>self.crearNotaAzul()})
        game.schedule(6000, {=>self.crearNotaVerde()})
        game.schedule(8000, {=>self.crearNotaVerde()})
        game.schedule(9000, {=>self.crearNotaAzul()})
        game.schedule(12000, {=>self.crearNotaAmarilla()})
        game.schedule(15000, {=>self.crearNotaVerde()})
        game.schedule(18990, {=>self.crearNotaVerde()})
        game.schedule(20000, {=>self.crearNotaAzul()})
        game.schedule(23000, {=>self.crearNotaAmarilla()})
        game.schedule(27000, {=>self.crearNotaAzul()})
        //game.onTick(300, "verificarFallos", { => self.verificarNotasFalladas() })

        game.onTick(50, "verificarFallos", { => self.verificarNotasFalladas() })

        keyboard.a().onPressDo({=>self.pulsarNotaEn(botonVerde)
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
        keyboard.s().onPressDo({=>self.pulsarNotaEn(botonRojo)
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
        keyboard.d().onPressDo({=>self.pulsarNotaEn(botonAmarillo)
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

        keyboard.f().onPressDo({=>self.pulsarNotaEn(botonAzul)
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
            n.fail()
            notasActivas.remove(n)
            game.removeVisual(n)
            cartelFallos.actualizarFallo(player.fallos())
            player.restarVida()
        })
    }



    method crearNotaVerde() {
        const notaNueva = new Notas(image = "note1.png", noteHit = "note1Hit.png", position = game.at(2,18), botonAsignado = botonVerde)
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
    }
    method crearNotaRoja() {
        const notaNueva = new Notas(image = "note2.png", noteHit = "note2Hit.png", position = game.at(5,18), botonAsignado = botonRojo)
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
    }
    method crearNotaAmarilla() {
        const notaNueva = new Notas(image = "note3.png", noteHit = "note3Hit.png", position = game.at(8,18), botonAsignado = botonAmarillo)
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
    }
    method crearNotaAzul() {
        const notaNueva = new Notas(image = "note4.png", noteHit = "note4Hit.png", position = game.at(11,18), botonAsignado = botonAzul)
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
    }
}

object cartelPuntuacion {
    var property position = game.at(17,15)
    var property text = "Puntuación: 0"
    var property size = 20 

    method actualizar(nuevaPuntuacion) {
        self.text("Puntuación: " + nuevaPuntuacion)
    }
    
}
object cartelFallos {
    var property text = "Fallos: 0" 
    var property size = 20
    var property position = game.at(17,14)
    
    method actualizarFallo(cantFallos) {
        self.text("Fallos: " + cantFallos)
    }
}

object cartelVida {
    var property text = "Vida: 3" 
    var property size = 20
    var property position = game.at(17,13)
    
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
    var property poder = false  //  
    var property consecutiveHits = 0
    // puede ser
    var property vida = 3
    // Metodo 3 vidas maximo
    method restarVida() {
        if(fallos >= 20) {
            vida = (vida- 1).max(0)
            fallos = 0
            cartelVida.actualizarVida(self.vida())
        }
    }

    method activarPoder() {
        if (energia == 10){ 
            //cancion.notas.forEach({n=>n.cambiarImage("noteSuper.png")}) 
            //cancion.notas.forEach({n=>n.cambiarImage("noteSuperHit.png")})
            multiplicador *= 2
            energia = 0
            poder = true
            self.desactivarPoder()
        } else {
            throw new Exception(message="No hay suficiente energia")
        }
    }

    method desactivarPoder() {
        game.onTick(300,"desactivarPoder", {poder = false})
    }

    method sumarFallo() {fallos += 1}
    // method reiniciarMultiplicador() {multiplicador = 1}
    method sumarPuntuacion(valor) {puntuacion += valor}
    // method aumentarMultiplicador() {multiplicador += 0.2}

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
}

//NOTAS

class Notas {
    var property image 
    var noteHit 
    var property puntuacion = 2
    var property position
    var property botonAsignado


     //ELIMINA LA NOTA
    method eliminar() {
        game.removeVisual(self)
        
    }

    

    method cambiarImage(png) {image = png}
    method cambiarHit(png) {noteHit = png}
    method queCaiga() {
        game.onTick(100,"caerse", {self.position(self.position().down(1))})
    }

    //SISTEMA DE PUNTUACION
    method hit() {
        image = noteHit
        player.sumarPuntuacion(puntuacion * player.multiplicador())
        self.eliminar()
        player.aumentarMultiplicador()

        }
        
    

    // SISTEMA DE REINICIO 
    method fail() {
        //Reproducir sonido de fallo de la nota
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

