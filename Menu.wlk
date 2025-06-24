import NotasyBotones.*
import teclado.*
import carteles.*
import player.*
object fondoMenu {
    method image() = "fondomenu8.png" 
    method position() = game.at(0,-12) 
}

object botonNiveles {
    method position() = game.at(18,0)
    method image() ="nivelesBoton.png"
}

object botonReglas {
    method image() = "reglasdefinitivo3.png"
    method position() = game.at(0,0)
}

object botonIniciar {
    method image() = "togar.png"
    method position() = game.at(6, 9) 
}
object dificultad {
    method image() = "dificultaadd.png"
    method position() = game.at(6,4) 
}
object selector {
    var property position = game.at(2, 0)
    method image() = "selectorChico.png"
}
object normal {
    method image() = "normal3.png"
    method position() = game.at(4, 1) 
}
object dificil {
    method image() = "dificil5.png"
    method position() = game.at(12, 1) 
}
object gameOverText {
    method image() = "game_over_text.png" 
    method position() = game.at(5, 10)
}
object dificultades {
    const property nivelNormal = normal
    const property nivelDificil = dificil

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
object menu {
    var property estado = "menuPrincipal" // puede ser: "menuPrincipal", "jugando", "reglas"
    const musicaDeFondo = game.sound("sonidoM.mp3")

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
       
        tecladoMenu.iniciar()
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