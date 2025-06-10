
object movimientoNotas {
    // const nota1 = new Notas(position = game.at(5, 100))
    
    method iniciar() {
        const unaNota = nota
        // const nota2 = new Notas
        // const nota3 = new Notas
        // const nota4 = new Notas

        game.addVisualCharacter(unaNota)
        // game.addVisualCharacter(nota2)
        // game.addVisualCharacter(nota3)
        // game.addVisualCharacter(nota4)

        // NOTAS QUE CAEN
        game.onTick(300,"caerse", {unaNota.position(unaNota.position().down(1))})
        // game.onTick(1000,"caerse", {nota1.position(nota.position().down(1))})
        // game.onTick(1000,"caerse", {nota1.position(nota.position().down(1))})
        // game.onTick(1000,"caerse", {nota1.position(nota.position().down(1))})

        
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
        if( unaNota.posiciones().contains(boton.positon())){
            unaNota.hit()
        }
        else {
            unaNota.fail()
        }
    }
    // Metodo 3 vidas maximo
    method vida() {
        if(fallo == 8) {
            fallo = 0
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
        iniciar temporizador
        if (temporizadortermina) {
            poder = false
        }
    }
}


//NOTAS

object nota {
    var property image = "note2.png"
    //var noteHit //imagen de la nota presionada
    var property puntuacion = 13
    var property position = game.at(5, 18)
    //var property posiciones = []
    //var property generado
    //var property velocidad

    // // GUARDA LAS POCIONES EN LA QUE PASA
    // method posicion(nuevaPosicion) {
    //     position = nuevaPosicion
    //     posiciones.add(nuevaPosicion)
    // }

    // ELIMINA LA NOTA
    // method eliminar() {
    //     game.removeVisual(self)
    // }

    // method eliminaPosicion() {
    //     var notaPosicion = posiciones.any({n=>n.y() < boton.y(1)})
    //     if(notaPosicion){
    //         self.eliminar()
    //         posiciones.remove(notaPosicion)
    //     }
    // }

    // method cambiarImage(png) {image = png}
    // method cambiarHit(png) {noteHit = png}
    
    // SISTEMA DE PUNTUACION
    //method hit() {
        /*
        image = noteHit
        player.puntuacion += puntuacion * player.multiplicador()
        self.eliminar()
        player.multiplicador() += 0,2
        }
        */
    

    // SISTEMA DE REINICIO 
    //method fail() 
        //Reproducir sonido de fallo de la nota
        //player.fallo += 1 
        //player.multiplicador = 1
    
}


// // BOTONES

// object botonRojoApagado {
//     var property position = game.at(5, 1)
//     method image() = "note2.png"
//     method position() = position
    
// }

// object botonRojoPrendido {
//     var property position = game.center()
//     method image() = "note2Hit.png"
//     method position() = position
    
// 

// object botonAzulApagado {
//     var property position = botonRojoApagado.position().right(3)
//     method image() = "noteSuper.png"
//     method position() = position
    
// }

// object botonAzulPrendido {
//     var property position = botonRojoApagado.position().right(3)
//     method image() = "noteSuperHit.png"
//     method position() = position
    
// }

// object botonVerdeApagado {
//     var property position = botonRojoApagado.position().left(3)
//     method image() = "note3.png"
//     method position() = position
    
// }

// object botonVerdePrendido {
//     var property position = botonRojoApagado.position().left(3)
//     method image() = "note3Hit.png"
//     method position() = position
    
// }

