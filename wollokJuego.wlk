import carteles.*
import Menu.*
import niveles.*
import NotasyBotones.*
import player.*
import teclado.*

object juego {
    var property notasActivas = []
    var property nivelElegido = cancion1
    method estado() = "jugando"
    method añadirVisuals() {
        game.addVisual(botonVerde)
        game.addVisual(botonRojo)
        game.addVisual(botonAmarillo)
        game.addVisual(botonAzul)
        game.addVisual(imagenPuntos)
        game.addVisual(cartelFallos)
        game.addVisual(cartelPuntuacion)
        cartelVida.mostrarVidas()
    }
    method iniciar() {
        self.añadirVisuals()
        nivelElegido.iniciar()
        teclado.iniciar()
        

        game.onTick(50, "verificarFallos", { => self.verificarNotasFalladas() })
        menu.cambiarEstado(self.estado())
    }

    method eliminarVisuals() {
        game.removeVisual(botonAmarillo)
        game.removeVisual(botonAzul)
        game.removeVisual(botonRojo)
        game.removeVisual(botonVerde)
        game.removeVisual(imagenPuntos)
        game.removeVisual(cartelPuntuacion)
        game.removeVisual(cartelFallos)
        game.removeVisual(cartelVida)
        cartelVida.ocultarVidas()

    }
    method eliminarNotasActivas() {
        notasActivas.forEach({ n =>
            game.removeVisual(n)
        })
        notasActivas = []
        
    }
    //////////nuevo
    method pulsarNotaEn(unBoton) {
        const notaCercana = self.buscarNotaCercanaA(unBoton)

        if (notaCercana != null) {
            self.acertarNota(notaCercana)
        } else {
            self.fallarNota()
        }
    }
    method buscarNotaCercanaA(unBoton) {
        return notasActivas.findOrElse({ n => n.esCercanaA(unBoton) }, { null })
    }
    method acertarNota(nota) {
        nota.hit()
        notasActivas.remove(nota)
        player.sumarHit()
        cartelPuntuacion.actualizar(player.puntuacion())
    }   

    method fallarNota() {
        game.sound("sonido2.mp3").play()
        player.sumarFallo()
        player.reiniciarMultiplicador()
        cartelFallos.actualizarFallo(player.fallos())
        player.restarVida()
    }
    
    method verificarNotasFalladas() {
         const notasFalladas = notasActivas.filter({ n =>
            n.position().y() < (n.botonAsignado().position().y() - 2)
        })
        notasFalladas.forEach({ n =>
            game.sound("sonido2.mp3").play()
            n.fail()
            notasActivas.remove(n)
            game.removeVisual(n)
            cartelFallos.actualizarFallo(player.fallos())
            player.restarVida()
        })
    }

    method crearNota(color, velocidad) {
        const notaDisponible = color.notaSinUsar()
        if (self.nivelElegido().tecla()) {
            if (notaDisponible != null) {
                notaDisponible.resetearPosicion()
                game.addVisual(notaDisponible)
                notaDisponible.queCaiga(velocidad)
                notasActivas.add(notaDisponible)
                color.marcarComoUsada(notaDisponible)
            }
        }   
    }
}
object contadorNotas {
    var property id = 0
    method siguienteId() {
        id = id + 1
        return id
    }
}
object verde {
    const notas = [nota1, nota2, nota3, nota4, nota5]
    const notasEnUso = []
    const property nota1= new Notas(image = "note1.png", position = game.at(2,18), botonAsignado = botonVerde, colorDefinido = self)
    const property nota2= new Notas(image = "note1.png", position = game.at(2,18), botonAsignado = botonVerde, colorDefinido = self)
    const property nota3= new Notas(image = "note1.png", position = game.at(2,18), botonAsignado = botonVerde, colorDefinido = self)
    const property nota4= new Notas(image = "note1.png", position = game.at(2,18), botonAsignado = botonVerde, colorDefinido = self)
    const property nota5= new Notas(image = "note1.png", position = game.at(2,18), botonAsignado = botonVerde, colorDefinido = self)
    method notaSinUsar() {
        return notas.findOrElse({n => !notasEnUso.contains(n)}, { null })
    }
    method marcarComoUsada(nota) {
        notasEnUso.add(nota)
    }
    method liberarNota(nota) {
        notasEnUso.remove(nota)
    }
}
object azul  {
    const notas = [nota1,nota2,nota3,nota4,nota5]
    const notasEnUso = []
    const property nota1= new Notas(image = "note4.png", position = game.at(11,18), botonAsignado = botonAzul,  colorDefinido = self)
    const property nota2= new Notas(image = "note4.png", position = game.at(11,18), botonAsignado = botonAzul,  colorDefinido = self)
    const property nota3= new Notas(image = "note4.png", position = game.at(11,18), botonAsignado = botonAzul,  colorDefinido = self)
    const property nota4= new Notas(image = "note4.png", position = game.at(11,18), botonAsignado = botonAzul,  colorDefinido = self)
    const property nota5= new Notas(image = "note4.png", position = game.at(11,18), botonAsignado = botonAzul,  colorDefinido = self)
    method notaSinUsar() {
        return notas.findOrElse({n => !notasEnUso.contains(n)}, { null })
        }
    method marcarComoUsada(nota) {
        notasEnUso.add(nota)
        }
    method liberarNota(nota) {
        notasEnUso.remove(nota)
    }
}
object amarilla {
    const notas = [nota1,nota2,nota3,nota4,nota5]
    const notasEnUso = []
    const property nota1= new Notas(image = "note3.png", position = game.at(8,18), botonAsignado = botonAmarillo,  colorDefinido = self)
    const property nota2= new Notas(image = "note3.png", position = game.at(8,18), botonAsignado = botonAmarillo,  colorDefinido = self)
    const property nota3= new Notas(image = "note3.png", position = game.at(8,18), botonAsignado = botonAmarillo,  colorDefinido = self)
    const property nota4= new Notas(image = "note3.png", position = game.at(8,18), botonAsignado = botonAmarillo,  colorDefinido = self)
    const property nota5= new Notas(image = "note3.png", position = game.at(8,18), botonAsignado = botonAmarillo,  colorDefinido = self)
    method notaSinUsar() {
        return notas.findOrElse({n => !notasEnUso.contains(n)}, { null })
    }
    method marcarComoUsada(nota) {
        notasEnUso.add(nota)
        }
    method liberarNota(nota) {
        notasEnUso.remove(nota)
    }
}
object roja {
    const notas = [nota1,nota2,nota3,nota4,nota5]
    const notasEnUso = []
    const property nota1= new Notas(image = "note2.png", position = game.at(5,18), botonAsignado = botonRojo,  colorDefinido = self)
    const property nota2= new Notas(image = "note2.png", position = game.at(5,18), botonAsignado = botonRojo,  colorDefinido = self)
    const property nota3= new Notas(image = "note2.png", position = game.at(5,18), botonAsignado = botonRojo,  colorDefinido = self)
    const property nota4= new Notas(image = "note2.png", position = game.at(5,18), botonAsignado = botonRojo,  colorDefinido = self)
    const property nota5= new Notas(image = "note2.png", position = game.at(5,18), botonAsignado = botonRojo,  colorDefinido = self)
    method notaSinUsar() {
        return notas.findOrElse({n => !notasEnUso.contains(n)}, { null })
    }
    method marcarComoUsada(nota) {
        notasEnUso.add(nota)
    }
    method liberarNota(nota) {
        notasEnUso.remove(nota)
    }
}
