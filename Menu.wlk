import NotasyBotones.*
object fondoMenu {
    method image() = "fondomenu4.png" 
    method position() = game.at(0,-8) 
}

object tituloJuego {
    method image() = "game_title.png" 
    method position() = game.at(5, 15) 
}

object botonIniciar {
    method image() = "jugar4.png"
    method position() = game.at(7, 9) 
}
object dificultad {
    method image() = "dificultad3.png"
    method position() = game.at(6,4) 
}

object gameOverText {
    method image() = "game_over_text.png" 
    method position() = game.at(5, 10)
}



object menu {
    var property estado = "menuPrincipal" // puede ser: "menuPrincipal", "jugando", "reglas"

    method iniciar() {
        self.mostrarMenuPrincipal()
    }


    method estadoJuego() = estado
    method cambiarEstado(nuevoEstado) {
        estado = nuevoEstado
    }

    method ocultarMenuPrincipal() {
        game.removeVisual(dificultad)
        game.removeVisual(fondoMenu)
        game.removeVisual(tituloJuego)
        game.removeVisual(botonIniciar)
        self.cambiarEstado("jugando")
    }

    method mostrarMenuPrincipal() {
        juego.eliminarVisuals()
        game.addVisual(fondoMenu)
        game.addVisual(dificultad)
        game.addVisual(tituloJuego)
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