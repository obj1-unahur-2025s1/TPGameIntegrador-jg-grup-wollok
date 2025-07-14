import NotasyBotones.*
import teclado.*
import carteles.*
import player.*
import wollokJuego.*

// Clase para la interfaz del menu 
class ImagenesMenu {
    var property  image
    var  property position
}

// objeto dificultades
object dificultades {
    const property nivelNormal = new ImagenesMenu(image = "normal3.png",position = game.at(4, 1)  )
    const property nivelDificil = new ImagenesMenu(image = "dificil5.png", position = game.at(12, 1) )
    const property selector = new ImagenesMenu(position = game.at(2, 0), image = "selectorChico.png")

    method mostrarDificultades() {
        game.addVisual(nivelNormal)
        game.addVisual(nivelDificil)
        game.addVisual(selector)

    }
    method ocultarDificultades() {
        game.removeVisual(nivelNormal)
        game.removeVisual(nivelDificil)
        game.removeVisual(selector)

    }
}
// objeto menu
object menu {
    var property estado = menuPrincipal.estado() // puede ser: menuPrincipal, jugando, reglas
    const musicaDeFondo = game.sound("sonidoM.mp3")

    method iniciar() {
        musicaDeFondo.volume(0.2)
        musicaDeFondo.play()
        menuPrincipal.mostrarMenuPrincipal()
    }
    
    method estadoJuego() = estado
    method cambiarEstado(nuevoEstado) {
        estado = nuevoEstado
    }

    method detenerMusica() {
        musicaDeFondo.stop()
    }

    method mostrarReglas() {
        game.addVisual(reglas)
        self.cambiarEstado(reglas.estado())
    }

    method ocultarReglas() {
        game.removeVisual(reglas)
        self.cambiarEstado(menuPrincipal.estado())
    }
}
object menuPrincipal {
    const property dificultad = new ImagenesMenu(image = "dificultaadd.png", position = game.at(6,4) )
    const property fondoMenu = new ImagenesMenu(image = "fondomenu8.png" , position = game.at(0,-12) )
    const property botonReglas = new ImagenesMenu(image = "reglasdefinitivo3.png", position = game.at(0,0) )
    const property botonNiveles = new ImagenesMenu(image ="nivelesBoton.png", position = game.at(18,0))
    const property botonIniciar = new ImagenesMenu(image = "togar.png", position = game.at(6, 9) )
    method estado() = "menuPrincipal"
    method ocultarMenuPrincipal() {
        game.removeVisual(dificultad)
        game.removeVisual(fondoMenu)
        game.removeVisual(botonReglas)
        game.removeVisual(botonIniciar)
        game.removeVisual(botonNiveles)
        menu.cambiarEstado(juego.estado())
        menu.detenerMusica()
    }

    method mostrarMenuPrincipal() {
        juego.eliminarVisuals()
        juego.eliminarNotasActivas()
        game.addVisual(fondoMenu)
        game.addVisual(botonReglas)
        game.addVisual(dificultad)
        game.addVisual(botonIniciar)
        if (!tecladoMenu.estaIniciado()) {
            tecladoMenu.iniciar()
        }
        menu.cambiarEstado(self.estado())
    }
}