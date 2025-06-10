object juego {
    var property estaRojoPrendido = false
    var property estaAzulPrendido = false
    var property estaVerdePrendido = false
    method iniciar() {
    const unaNota = nota
    game.addVisualCharacter(unaNota)
    game.onTick(300,"caerse", {unaNota.position(unaNota.position().down(1))})


    // BOTONES Y KEYS

    game.addVisual(botonRojoApagado)
        game.addVisual(botonAzulApagado)
        game.addVisual(botonVerdeApagado)

        keyboard.f().onPressDo {
            if (!estaRojoPrendido) {
                estaRojoPrendido = true
                game.removeVisual(botonRojoApagado)
                game.addVisual(botonRojoPrendido)

                game.removeTickEvent("apagadoBotonRojo")
                game.onTick(200, "apagadoBotonRojo", { =>
                    estaRojoPrendido = false
                    game.removeVisual(botonRojoPrendido)
                    game.addVisual(botonRojoApagado)
                    game.removeTickEvent("apagadoBotonRojo")
                })
            }
        }

        keyboard.g().onPressDo {
            if (!estaAzulPrendido) {
                estaAzulPrendido = true
                game.removeVisual(botonAzulApagado)
                game.addVisual(botonAzulPrendido)

                game.removeTickEvent("apagadoBotonAzul")
                game.onTick(200, "apagadoBotonAzul", { =>
                    estaAzulPrendido = false
                    game.removeVisual(botonAzulPrendido)
                    game.addVisual(botonAzulApagado)
                    game.removeTickEvent("apagadoBotonAzul")
                })
            }
        }

        keyboard.d().onPressDo {
            if (!estaVerdePrendido) {
                estaVerdePrendido = true
                game.removeVisual(botonVerdeApagado)
                game.addVisual(botonVerdePrendido)


                game.removeTickEvent("apagadoBotonVerde")
                game.onTick(200, "apagadoBotonVerde", { =>
                    estaVerdePrendido = false
                    game.removeVisual(botonVerdePrendido)
                    game.addVisual(botonVerdeApagado)
                    game.removeTickEvent("apagadoBotonVerde")
                })
            }
        }
    }
}


object player {
    // seguro
    var property puntuacion = 0 // puntuacion del jugador
    var property multiplicador = 1 // maximo 4 sin poder, maximo 8 con poder
    var property energia =  0 //maximo 10
    var property fallos = 0 // cantidad de fallos
    var property poder = false  //  activasion de poderes
    var vida = 3 // sistema de vidas


    method pulsarNota(unaNota, unBoton){
        if( unaNota.posiciones().contains(unBoton.position())){
            self.puntuacion(self.puntuacion() + unaNota.hit())
        }
        else {
            unaNota.fail()
        }
    }

   method revisarVida() {
    if (fallos == 8) {
        vida = (vida - 1).max(0)
        fallos = 0               
        }
    }

}

object nota {
    var property image = "note2.png"
    var property puntuacion = 2
    var property position = game.at(5, 18)
    var property posiciones = []

    method position() = position

    method posicion(nuevaPosicion) {
        position = nuevaPosicion
        posiciones.add(nuevaPosicion)
    }
    
    
    method hit() {
        return self.puntuacion() * player.multiplicador()
        
        }
    
    method fail() {
        player.fallos(player.fallos() + 1) 
        player.multiplicador(1)
    }

}

object botonRojoApagado {
    var property position = game.at(5, 1)
    method image() = "note2.png"
    method position() = position
    
}

object botonRojoPrendido {
    var property position = botonRojoApagado.position()
    method image() = "note2Hit.png"
    method position() = position
}


object botonAzulApagado {
    var property position = botonRojoApagado.position().right(3)
    method image() = "noteSuper.png"
    method position() = position
    
}

object botonAzulPrendido {
    var property position = botonRojoApagado.position().right(3)
    method image() = "noteSuperHit.png"
    method position() = position
    
}

object botonVerdeApagado {
    var property position = botonRojoApagado.position().left(3)
    method image() = "note3.png"
    method position() = position
    
}

object botonVerdePrendido {
    var property position = botonRojoApagado.position().left(3)
    method image() = "note3Hit.png"
    method position() = position
    
}
