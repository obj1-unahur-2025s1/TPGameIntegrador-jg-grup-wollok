object juego {
    var property estaRojoPrendido = false
    var property estaAzulPrendido = false
    var property estaVerdePrendido = false
    var property notasActivas = [] 
    var property rangoPrecisionY = 1 

    method iniciar() {
        // Generar una nota de prueba para cada carril al inicio 
        self.generarNuevaNota(game.at(botonRojoApagado.position().x(), 18))
        self.generarNuevaNota(game.at(botonAzulApagado.position().x(), 18))
        self.generarNuevaNota(game.at(botonVerdeApagado.position().x(), 18))

        // onTick para que las notas caigan
        game.onTick(300, "caerNotas", { =>
            notasActivas.forEach({ unaNota =>
                unaNota.position(unaNota.position().down(1))
            })
            self.limpiarNotas() 
        })

        // Agregamos los elementos visuales al juego
        game.addVisual(botonRojoApagado)
        game.addVisual(botonAzulApagado)
        game.addVisual(botonVerdeApagado)
        game.addVisual(cartelPuntuacion) 

        //  teclado 
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
            self.procesarPulsacion(botonRojoApagado) 
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
            self.procesarPulsacion(botonAzulApagado)
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
            self.procesarPulsacion(botonVerdeApagado)
        }
    }
    
    // GESTIÓN  
    method generarNuevaNota(posicionInicial) { 
        const nuevaNota = new Nota(position = posicionInicial)
        game.addVisualCharacter(nuevaNota)
        notasActivas.add(nuevaNota)
    }

    method procesarPulsacion(unBoton) {
        // Filtramos las notas que están en el mismo carril (X) que el botón
        const notasEnCarril = notasActivas.filter({ unaNota => 
            unaNota.position().x() == unBoton.position().x() 
        })

        // Buscamos si existe ALGUNA nota en ese carril que esté en el rango de golpeo en Y
        if (notasEnCarril.any({ unaNota => (unaNota.position().y() - unBoton.position().y()).abs() <= self.rangoPrecisionY() })) {
            const notaGolpeada = notasEnCarril.find({ unaNota => (unaNota.position().y() - unBoton.position().y()).abs() <= self.rangoPrecisionY() })
            player.procesarAcierto(notaGolpeada) 
            notasActivas.remove(notaGolpeada) 
            game.removeVisual(notaGolpeada) 
        } else {
            player.procesarFalloPulsacion() 
        }
    }

    method limpiarNotas() {
        // Filtrar las notas que ya se fueron de la pantalla (Y <= 0)
        const notasAFallar = notasActivas.filter({ unaNota => unaNota.position().y() <= 0 })
        
        notasAFallar.forEach({ unaNota =>
            // Solo si la nota no fue golpeada antes, se considera un fallo por tiempo
            if (!unaNota.golpeada()) { 
                player.procesarFalloPorTiempo(unaNota) 
            }
            notasActivas.remove(unaNota)
            game.removeVisual(unaNota)
        })
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


object player {
    var property puntuacion = 0 
    var property multiplicador = 1 
    var property energia = 0 
    var property fallos = 0 
    var property poder = false 
    var vida = 3 

    method procesarAcierto(unaNota){ 
        self.puntuacion(self.puntuacion() + unaNota.hit())
        self.aumentarMultiplicador() 
        cartelPuntuacion.actualizar(self.puntuacion())
        
    }

    method procesarFalloPulsacion() {
        self.fallos(self.fallos() + 1)
        self.multiplicador(1) 
        self.revisarVida() 
        // cartelPuntuacion.actualizar(self.puntuacion()) 
    }

    method procesarFalloPorTiempo(unaNota) {
        self.fallos(self.fallos() + 1)
        self.multiplicador(1) 
        self.revisarVida() 
        // cartelPuntuacion.actualizar(self.puntuacion()) 
    }

    method aumentarMultiplicador() {
        self.multiplicador((self.multiplicador() + 1).min(4)) 
    }

    method revisarVida() {
        if (fallos >= 8) { 
            vida = (vida - 1).max(0)
            fallos = 0
            // agregar un game over si vida == 0
        }
    }
}


class Nota { 
    var property image = "note2.png"
    var property puntuacion = 2
    var property position 
    var property golpeada = false 

    method constructor(initialPosition) {
        self.position(initialPosition)
    }

    method image() = if (self.golpeada()) "note2Hit.png" else image 

    method hit() {
        self.golpeada(true) 
        return self.puntuacion() * player.multiplicador()
    }
}



object botonRojoApagado {
    var property position = game.at(5, 1)
    method image() = "note2.png"
}

object botonRojoPrendido {
    var property position = botonRojoApagado.position()
    method image() = "note2Hit.png"
}


object botonAzulApagado {
    var property position = botonRojoApagado.position().right(3) // X = 8
    method image() = "noteSuper.png"
}

object botonAzulPrendido {
    var property position = botonRojoApagado.position().right(3)
    method image() = "noteSuperHit.png"
}



object botonVerdeApagado {
    var property position = botonRojoApagado.position().left(3) // X = 2
    method image() = "note3.png"
}

object botonVerdePrendido {
    var property position = botonRojoApagado.position().left(3)
    method image() = "note3Hit.png"
}
