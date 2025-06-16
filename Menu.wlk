import NotasyBotones.*
object fondoMenu {
    method image() = "fondomenu.jpg" 
    method position() = game.at(-10,-1) 
}

object tituloJuego {
    method image() = "game_title.png" 
    method position() = game.at(5, 15) 
}

object botonIniciar {
    method image() = "jugar4.png"
    method position() = game.at(7, 8) 
}
object dificultad {
    method image() = "dificultad3.png"
    method position() = game.at(6,5) 
}

object gameOverText {
    method image() = "game_over_text.png" 
    method position() = game.at(5, 10)
}
object menu {
    var property estadoJuego = "menuPrincipal" 

    method iniciar() {
        self.mostrarMenuPrincipal() 
    }

    method mostrarMenuPrincipal() {
        // Clear any existing visuals
        juego.eliminarVisuals()
        // Add menu background
        game.addVisual(fondoMenu)

        game.addVisual(dificultad)
        // Add game title
        game.addVisual(tituloJuego)

        // Add start button
        game.addVisual(botonIniciar)

        // Listen for "Enter" key press to start the game
        keyboard.enter().onPressDo {
            if (self.estadoJuego() == "menuPrincipal") {
                self.ocultarMenuPrincipal()
                juego.iniciar()
            }
        }
    }

    method ocultarMenuPrincipal() {
        game.removeVisual(dificultad)
        game.removeVisual(fondoMenu)
        game.removeVisual(tituloJuego)
        game.removeVisual(botonIniciar)
        keyboard.enter().onPressDo {} // Clear the event listener
    }
}