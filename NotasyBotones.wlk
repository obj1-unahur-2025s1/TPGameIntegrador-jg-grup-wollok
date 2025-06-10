
object cancion1 {

}

object juego {
    var property notasActivas = []
    

    method iniciar() {



        game.addVisual(botonVerde)



        game.schedule(1000, {=>self.crearNotaVerde()})
        game.schedule(1500, {=>self.crearNotaRoja()})
        game.schedule(2000, {=>self.crearNotaAmarilla()})
        game.schedule(4000, {=>self.crearNotaVerde()})
        game.schedule(5000, {=>self.crearNotaRoja()})
        game.schedule(6000, {=>self.crearNotaAmarilla()})
        game.schedule(7000, {=>self.crearNotaVerde()})
        game.schedule(8000, {=>self.crearNotaRoja()})
        game.schedule(9000, {=>self.crearNotaAmarilla()})

        keyboard.a().onPressDo({=>player.pulsarNota()})

    }

    method crearNotaVerde() {
        const notaNueva = new Notas(image = "note1.png", noteHit = "note1Hit.png", position = game.at(2,18))
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
    }
    method crearNotaRoja() {
        const notaNueva = new Notas(image = "note2.png", noteHit = "note2Hit.png", position = game.at(5,18))
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
    }
    method crearNotaAmarilla() {
        const notaNueva = new Notas(image = "note3.png", noteHit = "note3Hit.png", position = game.at(8,18))
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
    }
    method crearNotaAzul() {
        const notaNueva = new Notas(image = "note4.png", noteHit = "note4Hit.png", position = game.at(11,18))
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
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
        if( unaNota.posiciones().contains(unaNota.boton().position())){
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

    method sumarFallo() {fallos =+ 1}
    method reiniciarMultiplicador() {multiplicador = 1}
    method sumarPuntuacion(valor) {puntuacion =+ valor}
    method aumentarMultiplicador() {multiplicador =+ 0.2}
}

//NOTAS

class Notas {
    var property image 
    var noteHit 
    var property puntuacion = 13
    var property position
    var property posiciones = []

    // // GUARDA LAS POCIONES EN LA QUE PASA
    method posicion(nuevaPosicion) {
         position = nuevaPosicion
         posiciones.add(nuevaPosicion)
     }

     //ELIMINA LA NOTA
    method eliminar() {
         game.removeVisual(self)
     }

    method eliminaPosicion(pos) {
         const notaPosicion = posiciones.any({n=>n.y() < pos.y(1)})
         if(notaPosicion){
             self.eliminar()
             posiciones.remove(notaPosicion)
         }
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
    var property image  
    method image() = image
    method position() = position
}

object botonVerde inherits Botones(position = game.at(2,1), image = "boton1.png"){

}
object botonRojo inherits Botones(position = game.at(5,1), image = ""){

}
object botonAmarillo inherits Botones(position = game.at(8,1), image = ""){

}
object botonAzul inherits Botones(position = game.at(11,1), image = ""){

}
object botonNaranja inherits Botones(position = game.at(14,1), image = ""){

}

