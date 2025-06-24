import NotasyBotones.*
import Menu.*
import carteles.*
import player.*
import niveles.*
object tecladoMenu {
    var property juegoAsociado = juego
    var property menus = menu
    var property reglasAsociadas = reglas
    var property dificultadesVistas = false
    method iniciar() {
        keyboard.enter().onPressDo {
            game.sound("sonido4.mp3").play()
            menus.estado("jugando") 
            dificultades.ocultar()
            menus.ocultarMenuPrincipal()
            juego.iniciar()
        }
        keyboard.r().onPressDo({
        const enMenu = menu.estadoJuego() == "menuPrincipal" || menu.estadoJuego() == "reglas"

        if (enMenu) {
        if (reglas.estaVisible()) {
            menu.ocultarReglas()
        } else {
            menu.mostrarReglas()
        }
        reglas.cambioVisible()
    }
})
        keyboard.t().onPressDo({
            if (menu.estadoJuego() == "menuPrincipal") {
                game.sound("sonido3.mp3").play()
                if (!dificultadesVistas) {
                    self.mostrarDificultades()
                    dificultadesVistas = true
                    game.addVisual(botonNiveles)
                } else {
                    self.ocultarDificultades()
                    dificultadesVistas = false
                    game.removeVisual(botonNiveles)
                }
            }
        })
        keyboard.n().onPressDo({
            if (menu.estadoJuego() == "menuPrincipal" && dificultadesVistas) {
                juego.nivelElegido(cancion1)
                game.sound("sonido5.mp3").play()
                selector.position(game.at(2, 0))
        }
    })
        keyboard.m().onPressDo({
            if (menu.estadoJuego() == "menuPrincipal" && dificultadesVistas) {
                juego.nivelElegido(cancion2)
                game.sound("sonido5.mp3").play()
                selector.position(game.at(10, 0))
            }
        })
    }
    method mostrarDificultades() {
            game.addVisual(normal)
            game.addVisual(dificil)
            game.addVisual(selector)
    }
    method ocultarDificultades() {
            game.removeVisual(normal)
            game.removeVisual(dificil)
            game.removeVisual(selector)
    }
}

object teclado {
    var property estaVerdePrendido = false
    var property estaRojoPrendido = false
    var property estaAmarilloPrendido = false
    var property estaAzulPrendido = false
    var property juegoAsociado = juego
    var property menus = menu
    // var property reglasAsociadas = reglas

    method iniciar(){
        keyboard.a().onPressDo({=>juegoAsociado.pulsarNotaEn(botonVerde)
        if (menus.estadoJuego() == "jugando" && !estaVerdePrendido) {
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
        if (menus.estadoJuego() == "jugando" && !estaRojoPrendido) {
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
            if (menus.estadoJuego() == "jugando" && !estaAmarilloPrendido) {
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
            if (menus.estadoJuego() == "jugando" && !estaAzulPrendido) {
                estaAzulPrendido = true
                botonAzul.cambiarImage(botonAzul.botonHit()) 
                game.removeTickEvent("apagadoBotonAzul")
                game.onTick(300, "apagadoBotonAzul", { =>
                    estaAzulPrendido = false
                    botonAzul.cambiarImage(botonAzul.imagenApagado())
                    game.removeTickEvent("apagadoBotonAzul")
                })
            }})
        keyboard.space().onPressDo({ => 
            cancion1.cerrarNivel()
        })
    }
}