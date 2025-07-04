import NotasyBotones.*
import Menu.*
import carteles.*
import player.*
import niveles.*
import wollokJuego.*
object tecladoMenu {
    var property juegoAsociado = juego
    var property reglasAsociadas = reglas
    var property dificultadesVistas = false
    var property iniciado = false
    method estaIniciado() = iniciado
    
    method iniciar() {
        iniciado = true
        keyboard.enter().onPressDo {
            if (menu.estadoJuego() == menuPrincipal.estado()) {
            game.sound("sonido4.mp3").play()
            menu.cambiarEstado(juego.estado()) 
            menuPrincipal.ocultarMenuPrincipal()
            dificultades.ocultarDificultades()
            juego.iniciar()
            
         } 
        }
    
        keyboard.r().onPressDo({
        const enMenu = menu.estadoJuego() == menuPrincipal.estado() || menu.estadoJuego() == reglas.estado()
        if (enMenu) {
            if (reglas.estaVisible()) {
                game.sound("sonido4.mp3").play()
                menu.ocultarReglas()
            } else {
                game.sound("sonido4.mp3").play()
                menu.mostrarReglas()
            }
            reglas.cambioVisible()
        }
})
        keyboard.t().onPressDo({
            if (menu.estadoJuego() == menuPrincipal.estado()) {
                if (!dificultadesVistas) {
                    game.sound("sonido5.mp3").play()
                    dificultadesVistas = true
                    dificultades.mostrarDificultades()
                    game.addVisual(menuPrincipal.botonNiveles())
                } else {
                    game.sound("sonido5.mp3").play()
                    dificultadesVistas = false
                    dificultades.ocultarDificultades()
                    game.removeVisual(menuPrincipal.botonNiveles())
                }
            }
        }
        )
        keyboard.n().onPressDo({
            if (menu.estadoJuego() == menuPrincipal.estado() && dificultadesVistas) {
                juego.nivelElegido(cancion1)
                game.sound("sonido5.mp3").play()
                dificultades.selector().position(game.at(2, 0))
        }
    })
        keyboard.m().onPressDo({
            if (menu.estadoJuego() == menuPrincipal.estado() && dificultadesVistas) {
                juego.nivelElegido(cancion2)
                game.sound("sonido5.mp3").play()
                dificultades.selector().position(game.at(10, 0))
            }
        })
        keyboard.right().onPressDo({
            if (menu.estadoJuego() == reglas.estado() && reglas.estaVisible() && reglas.image() == "textoreglas1.jpg") {
                reglas.imagenPuesta("textoreglas2.jpg")
                game.sound("sonido3.mp3").play()
            }
            else if (menu.estadoJuego() == reglas.estado() && reglas.estaVisible() && reglas.image() == "textoreglas2.jpg") {
                reglas.imagenPuesta("textoreglas3.jpg")
                game.sound("sonido3.mp3").play()
            }
            else if (menu.estadoJuego() == reglas.estado() && reglas.estaVisible() && reglas.image() == "textoreglas3.jpg") {
                reglas.imagenPuesta("textoreglas4.jpg")
                game.sound("sonido3.mp3").play()
            }
            else if (menu.estadoJuego() == reglas.estado() && reglas.estaVisible() && reglas.image() == "textoreglas4.jpg") {
                reglas.imagenPuesta("textoreglas5.jpg")
                game.sound("sonido3.mp3").play()
            }
        })
        keyboard.left().onPressDo({
              if (menu.estadoJuego() == reglas.estado() && reglas.estaVisible() && reglas.image() == "textoreglas5.jpg") {
                reglas.imagenPuesta("textoreglas4.jpg")
                game.sound("sonido3.mp3").play()
            }
            else if (menu.estadoJuego() == reglas.estado() && reglas.estaVisible() && reglas.image() == "textoreglas4.jpg") {
                reglas.imagenPuesta("textoreglas3.jpg")
                game.sound("sonido3.mp3").play()
            }
            else if (menu.estadoJuego() == reglas.estado() && reglas.estaVisible() && reglas.image() == "textoreglas3.jpg") {
                reglas.imagenPuesta("textoreglas2.jpg")
                game.sound("sonido3.mp3").play()
            }
            else if (menu.estadoJuego() == reglas.estado() && reglas.estaVisible() && reglas.image() == "textoreglas2.jpg") {
                reglas.imagenPuesta("textoreglas1.jpg")
                game.sound("sonido3.mp3").play()
        }})
        }
}

object teclado {
    var property estaVerdePrendido = false
    var property estaRojoPrendido = false
    var property estaAmarilloPrendido = false
    var property estaAzulPrendido = false
    var property juegoAsociado = juego
    var property menus = menu
    method iniciar(){
        keyboard.a().onPressDo({=>
        if (menus.estadoJuego() == juego.estado() && !estaVerdePrendido) {
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
        if (menus.estadoJuego() == juego.estado() && !estaRojoPrendido) {
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
            if (menus.estadoJuego() == juego.estado() && !estaAmarilloPrendido) {
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
            if (menus.estadoJuego() == juego.estado() && !estaAzulPrendido) {
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
            if(menus.estadoJuego() == win1.estado() || menus.estadoJuego() == gameOver.estado()) {
                    juego.nivelElegido().cerrarNivel()
            }})
    }
}

