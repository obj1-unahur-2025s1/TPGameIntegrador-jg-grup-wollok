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
    var property iniciado = false
    method estaIniciado() = iniciado
    
    method iniciar() {
        iniciado = true
        keyboard.enter().onPressDo {
            if (menu.estadoJuego() == "menuPrincipal") {
            game.sound("sonido4.mp3").play()
            menus.cambiarEstado("jugando") 
            menus.ocultarMenuPrincipal()
            dificultades.ocultarDificultades()
            juego.iniciar()
            
         } 
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
                if (!dificultadesVistas) {
                    game.sound("sonido5.mp3").play()
                    dificultadesVistas = true
                    dificultades.mostrarDificultades()
                    game.addVisual(menu.botonNiveles())
                } else {
                    game.sound("sonido5.mp3").play()
                    dificultadesVistas = false
                    dificultades.ocultarDificultades()
                    game.removeVisual(menu.botonNiveles())
                }
            }
        }
        )
        keyboard.n().onPressDo({
            if (menu.estadoJuego() == "menuPrincipal" && dificultadesVistas) {
                juego.nivelElegido(cancion1)
                game.sound("sonido5.mp3").play()
                dificultades.selector().position(game.at(2, 0))
        }
    })
        keyboard.m().onPressDo({
            if (menu.estadoJuego() == "menuPrincipal" && dificultadesVistas) {
                juego.nivelElegido(cancion2)
                game.sound("sonido5.mp3").play()
                dificultades.selector().position(game.at(10, 0))
            }
        })
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
        keyboard.a().onPressDo({=>
        if (menus.estadoJuego() == "jugando" && !estaVerdePrendido) {
                juegoAsociado.pulsarNotaEn(botonVerde)
                estaVerdePrendido = true
                botonVerde.cambiarImage(botonVerde.botonHit()) 

                game.removeTickEvent("apagadoBotonVerde")
                game.onTick(300, "apagadoBotonVerde", {
                estaVerdePrendido = false
                botonVerde.cambiarImage(botonVerde.imagenApagado())
                game.removeTickEvent("apagadoBotonVerde")
                })
            }})
        keyboard.s().onPressDo({=>
        if (menus.estadoJuego() == "jugando" && !estaRojoPrendido) {
                juegoAsociado.pulsarNotaEn(botonRojo)
                estaRojoPrendido = true
                botonRojo.cambiarImage(botonRojo.botonHit()) 

                game.removeTickEvent("apagadoBotonRojo")
                game.onTick(300, "apagadoBotonRojo", { =>
                    estaRojoPrendido = false
                    botonRojo.cambiarImage(botonRojo.imagenApagado())
                    game.removeTickEvent("apagadoBotonRojo")
                })
            }})
        keyboard.d().onPressDo({=>
            if (menus.estadoJuego() == "jugando" && !estaAmarilloPrendido) {
                juegoAsociado.pulsarNotaEn(botonAmarillo)
                estaAmarilloPrendido = true
                botonAmarillo.cambiarImage(botonAmarillo.botonHit())

                game.removeTickEvent("apagadoBotonAmarillo")
                game.onTick(300, "apagadoBotonAmarillo", { =>
                    estaAmarilloPrendido = false
                    botonAmarillo.cambiarImage(botonAmarillo.imagenApagado())
                    game.removeTickEvent("apagadoBotonAmarillo")
                })
            }})

        keyboard.f().onPressDo({=>
            if (menus.estadoJuego() == "jugando" && !estaAzulPrendido) {
                juegoAsociado.pulsarNotaEn(botonAzul)
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
            if(menus.estadoJuego() == "win1") {
                juego.nivelElegido(cancion2)
                juego.nivelElegido().iniciar()
                win1.ocultarWin()
                juego.añadirVisuals()
            }
            else if ( menus.estadoJuego() == "win2") {
                juego.nivelElegido().cerrarNivel()
            } else if (menus.estadoJuego() == "gameOver") {
                
                cancion1.iniciar()
                gameOver.ocultar()
            }
        })
    }
}