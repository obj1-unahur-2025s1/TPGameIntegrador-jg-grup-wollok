
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

        game.schedule(1000, {=>self.crearNotaVerde()})
        game.schedule(1500, {=>self.crearNotaRoja()})
        game.schedule(2000, {=>self.crearNotaAmarilla()})
        game.schedule(4000, {=>self.crearNotaVerde()})
        game.schedule(5000, {=>self.crearNotaRoja()})
        game.schedule(6000, {=>self.crearNotaAmarilla()})
        game.schedule(7000, {=>self.crearNotaVerde()})
        game.schedule(8000, {=>self.crearNotaRoja()})
        game.schedule(9000, {=>self.crearNotaAmarilla()})

        keyboard.a().onPressDo({=>self.pulsarNotaEn(botonVerde)
        if (!estaVerdePrendido) {
                estaVerdePrendido = true
                botonVerde.cambiarImage(botonVerde.botonHit()) 

                game.removeTickEvent("apagadoBotonVerde")
                game.onTick(200, "apagadoBotonVerde", { =>
                    estaVerdePrendido = false
                    botonVerde.cambiarImage(botonVerde.image())
                    game.removeTickEvent("apagadoBotonVerde")
                })
            }})
        keyboard.s().onPressDo({=>self.pulsarNotaEn(botonRojo)
        if (!estaRojoPrendido) {
                estaRojoPrendido = true
                botonRojo.cambiarImage(botonRojo.botonHit()) 

                game.removeTickEvent("apagadoBotonRojo")
                game.onTick(200, "apagadoBotonRojo", { =>
                    estaRojoPrendido = false
                    botonRojo.cambiarImage(botonRojo.image())
                    game.removeTickEvent("apagadoBotonRojo")
                })
            }})
        keyboard.d().onPressDo({=>self.pulsarNotaEn(botonAmarillo)})
        keyboard.f().onPressDo({=>self.pulsarNotaEn(botonAzul)})

    }
    
    method pulsarNotaEn(unBoton) {
        const notaCercana = notasActivas.find({n =>
        n.botonAsignado() == unBoton &&
        (n.position().equals(unBoton.position()))
         
    })

        if (notaCercana != false) {
            notaCercana.hit()
            notasActivas.remove(notaCercana)
            cartelPuntuacion.actualizar(player.puntuacion())
        } else {
            notaCercana.fail()
        }
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
    var property position = game.center()
    var property text = "Puntuación: 0" 
    var property size = 20 

    method actualizar(nuevaPuntuacion) {
        self.text("Puntuación: " + nuevaPuntuacion)
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

    // puede ser
    var property vida = 3

    // Situacion de pulsar Nota
    method pulsarNota(unaNota){
        if(  unaNota.position().equals(unaNota.botonAsignado().position())){
            unaNota.hit()
        }
        else {
            unaNota.fail()
        }
    }
    // Metodo 3 vidas maximo
    method restarVida() {
        if(fallos == 8) {
            fallos = 0
            vida = (vida- 1).max(0)
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
    method reiniciarMultiplicador() {multiplicador = 1}
    method sumarPuntuacion(valor) {puntuacion += valor}
    method aumentarMultiplicador() {multiplicador += 0.2}
}

//NOTAS

class Notas {
    var property image 
    var noteHit 
    var property puntuacion = 13
    var property position
    var property botonAsignado


     //ELIMINA LA NOTA
    method eliminar() {
         game.removeVisual(self)
     }

    

    method cambiarImage(png) {image = png}
    method cambiarHit(png) {noteHit = png}
    method queCaiga() {
        game.onTick(300,"caerse", {self.position(self.position().down(1))})
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
    var property imagen 
    var property botonHit
    method image() = imagen
    method position() = position
    method cambiarImage(png) {imagen = png}
    
}

object botonVerde inherits Botones(position = game.at(2,1), imagen = "boton1.png", botonHit = "boton1Hit.png"){

}
object botonRojo inherits Botones(position = game.at(5,1), imagen = "boton2.png", botonHit = "boton2Hit.png"){

}
object botonAmarillo inherits Botones(position = game.at(8,1), imagen = "boton3.png", botonHit = "boton3Hit.png"){

}
object botonAzul inherits Botones(position = game.at(11,1), imagen = "boton4.png", botonHit = "boton4Hit.png"){

}
object botonNaranja inherits Botones(position = game.at(14,1), imagen = "boton5.png", botonHit = "boton5Hit.png"){

}

