import NotasyBotones.*
object fondoMenu {
    method image() = "fondoProv.jpg" // Replace with your menu background image
    method position() = game.at(0, 3) // Position at top-left
}

object tituloJuego {
    method image() = "game_title.png" // Replace with your game title image or a text visual
    method position() = game.at(5, 15) // Adjust position as needed
}

object botonIniciar {
    method image() = "jugar.png" // Replace with your start button image
    method position() = game.at(5, 5) // Adjust position as needed
}
object dificultad {
    method image() = "dificultad.png"
    method position() = game.at(2,2) 
}
// Optional: for game over screen
object gameOverText {
    method image() = "game_over_text.png" // Or use a text rendering function if available
    method position() = game.at(5, 10)
}
object menu {
    var property estadoJuego = "menuPrincipal" // New property to manage game state

    method iniciar() {
        self.mostrarMenuPrincipal() // Call method to display the main menu
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