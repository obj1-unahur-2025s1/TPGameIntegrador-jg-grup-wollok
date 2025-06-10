import juego.*

object juego {
    var property estaRojoPrendido = false
    var property estaAzulPrendido = false
    var property estaVerdePrendido = false

    method iniciar() {
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
                persona.pulsarNota(nota1)

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

object botonRojoApagado {
    var property position = game.at(5, 1)
    method image() = "note2.png"
    method position() = position
    
}

object botonRojoPrendido {
    var property position = game.at(5, 1)
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