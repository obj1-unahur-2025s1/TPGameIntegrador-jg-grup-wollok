import wollok.mirror.*
import NotasyBotones.*
import teclado.*
import carteles.*
import player.*

class ImagenesMenu {
    method image()
    method position()
}
class FondoMenu inherits ImagenesMenu {
    override method image() = "fondomenu8.png" 
    override method position() = game.at(0,-12) 
}

class BotonNiveles inherits ImagenesMenu{
    override method position() = game.at(18,0)
    override method image() ="nivelesBoton.png"
}

class BotonesPrincipales inherits ImagenesMenu {
    override method image() = "reglasdefinitivo3.png"
    override method position() = game.at(0,0)
}

class BotonIniciar inherits ImagenesMenu {
    override method image() = "togar.png"
    override method position() = game.at(6, 9) 
}
class Dificultad inherits ImagenesMenu{
    override method image() = "dificultaadd.png"
    override method position() = game.at(6,4) 
}
class Selector inherits ImagenesMenu{
    var property position = game.at(2, 0)
    override method image() = "selectorChico.png"
}
class Normal inherits ImagenesMenu {
    override method image() = "normal3.png"
    override method position() = game.at(4, 1) 
}
class Dificil inherits ImagenesMenu{
    override method image() = "dificil5.png"
    override method position() = game.at(12, 1) 
}

object dificultades {
    const property nivelNormal = new Normal()
    const property nivelDificil = new Dificil()
    const property selector = new Selector()

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
object menu {
    var property estado = "menuPrincipal" // puede ser: "menuPrincipal", "jugando", "reglas"
    const musicaDeFondo = game.sound("sonidoM.mp3")
    const property dificultad = new Dificultad()
    const property fondoMenu = new FondoMenu()
    const property botonReglas = new BotonesPrincipales()
    const property botonNiveles = new BotonNiveles()
    const property botonIniciar = new BotonIniciar()

    method iniciar() {
        musicaDeFondo.volume(0.2)
        musicaDeFondo.play()
        self.mostrarMenuPrincipal()
    }
    
    method estadoJuego() = estado
    method cambiarEstado(nuevoEstado) {
        estado = nuevoEstado
    }

    method detenerMusica() {
        musicaDeFondo.stop()
    }

    method ocultarMenuPrincipal() {
        game.removeVisual(dificultad)
        game.removeVisual(fondoMenu)
        game.removeVisual(botonReglas)
        game.removeVisual(botonIniciar)
        game.removeVisual(botonNiveles)
        self.cambiarEstado("jugando")
        self.detenerMusica()
    }

    method mostrarMenuPrincipal() {
        juego.eliminarVisuals()
        game.addVisual(fondoMenu)
        game.addVisual(botonReglas)
        game.addVisual(dificultad)
        game.addVisual(botonIniciar)
        if (!tecladoMenu.estaIniciado()) {
            tecladoMenu.iniciar()
        }
        self.cambiarEstado("menuPrincipal")
    }

    method mostrarReglas() {
        game.addVisual(reglas)
        self.cambiarEstado("reglas")
    }

    method ocultarReglas() {
        game.removeVisual(reglas)
        self.cambiarEstado("menuPrincipal")
    }
}
// object menu {
//     var property estadoJuego = "menuPrincipal" 

//     method iniciar() {
//         self.mostrarMenuPrincipal()
        
//     }

//     method mostrarMenuPrincipal() {
//         // Clear any existing visuals
//         juego.eliminarVisuals()
//         // Add menu background
//         game.addVisual(fondoMenu)

//         game.addVisual(dificultad)
//         // Add game title
//         game.addVisual(tituloJuego)

//         // Add start button
//         game.addVisual(botonIniciar)
//         teclado.iniciar()
//     }

//     method ocultarMenuPrincipal() {
//         game.removeVisual(dificultad)
//         game.removeVisual(fondoMenu)
//         game.removeVisual(tituloJuego)
//         game.removeVisual(botonIniciar)
//         keyboard.enter().onPressDo {} // Clear the event listener
//     }
// }