import Menu.*
object juego {
    var property notasActivas = []

    method iniciar() {
        
        game.addVisual(botonVerde)
        game.addVisual(botonRojo)
        game.addVisual(botonAmarillo)
        game.addVisual(botonAzul)
        game.addVisual(cartelPuntuacion)
        game.addVisual(imagenPuntuacion)
        game.addVisual(cartelFallos)
        game.addVisual(cartelVida)

        cancion1.iniciar()
        teclado.iniciar()
        
        game.onTick(50, "verificarFallos", { => self.verificarNotasFalladas() })
        menu.cambiarEstado("jugando")
    }

    method eliminarVisuals() {
        game.removeVisual(botonAmarillo)
        game.removeVisual(botonAzul)
        game.removeVisual(botonRojo)
        game.removeVisual(botonVerde)
        game.removeVisual(cartelFallos)
        game.removeVisual(imagenPuntuacion)
        game.removeVisual(cartelHits)
        game.removeVisual(cartelVida)
    }
    
    method pulsarNotaEn(unBoton) {
        // implementar un codigo que dada la distancia de la nota con el boton, le mande al metodo multiplicador
        // si la nota esta por fuera del botón, no le multiplica la puntuación
        // si la nota esta dentro del botón, le multiplica la puntuación por el multiplicador

    //     const notaCercana = notasActivas.findOrElse({n =>
    //     n.botonAsignado() == unBoton &&
    //     (n.position().equals(unBoton.position()))
    // },{null})

    // guardo la nota que esta por encima del botón, si justo le dio cuando esto sucedía
        const notaPorEncima = notasActivas.findOrElse({n =>
        n.botonAsignado() == unBoton &&
        (n.position().equals(unBoton.position()))
    },{null})
    // si hay una nota cercana (sea a 1 posicion del botón) la toma como válida
        const notaCercana = notasActivas.findOrElse({n =>
        (n.botonAsignado() == unBoton) && ((n.position().y() == unBoton.position().y() + 1))
    },{null})

        if (notaCercana != null ) {
            notaCercana.hit()
            notasActivas.remove(notaCercana)
            cartelPuntuacion.actualizar(player.puntuacion())
        } else if (notaPorEncima != null) {
            notaPorEncima.hit()
            notasActivas.remove(notaPorEncima)
            cartelPuntuacion.actualizar(player.puntuacion())
        } else {
            game.sound("sonido2.mp3").play()
            player.sumarFallo()
            player.reiniciarMultiplicador()
            notasActivas.remove(notaCercana)
            notasActivas.remove(notaPorEncima)
            cartelFallos.actualizarFallo(player.fallos())
            player.restarVida()
        }
    }

    method verificarNotasFalladas() {

        // const notasFalladas = notasActivas.filter({ n =>
        //     n.position().y() < (n.botonAsignado().position().y() + posicionParaFallo)
        // })
        // cambie este código para poder acertar las notas 
        // si estan en +1 posición arriba del botón porque sino
        // era muy difícil acertar las notas en el juego
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



    method crearNotaVerde() {
        const notaNueva = new Notas(image = "note1.png",  position = game.at(2,18), botonAsignado = botonVerde)
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
    }
    method crearNotaRoja() {
        const notaNueva = new Notas(image = "note2.png", position = game.at(5,18), botonAsignado = botonRojo)
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
    }
    method crearNotaAmarilla() {
        const notaNueva = new Notas(image = "note3.png", position = game.at(8,18), botonAsignado = botonAmarillo)
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
    }
    method crearNotaAzul() {
        const notaNueva = new Notas(image = "note4.png", position = game.at(11,18), botonAsignado = botonAzul)
        game.addVisualCharacter(notaNueva)
        notaNueva.queCaiga()
        notasActivas.add(notaNueva)
    }
}

object teclado {
    var property estaVerdePrendido = false
    var property estaRojoPrendido = false
    var property estaAmarilloPrendido = false
    var property estaAzulPrendido = false
    var property juegoAsociado = juego
    var property menus = menu
    var property reglasAsociadas = reglas

    method iniciar(){
        
        keyboard.enter().onPressDo {
            if (menus.estadoJuego() == "menuPrincipal") {
                menus.ocultarMenuPrincipal()
                juego.iniciar()
            }
        }

        // keyboard.r().onPressDo({
        // if (reglasAsociadas.estaVisible()) {
        // game.removeVisual(reglasAsociadas)
        // menus.mostrarMenuPrincipal()   // <- Volver a mostrar el menú
        // } else {
        // menus.ocultarMenuPrincipal()   // <- Ocultar menú
        // game.addVisual(reglasAsociadas)
        // }
        // reglasAsociadas.cambioVisible()
        // })


        keyboard.r().onPressDo({
    if (menu.estadoJuego() == "menuPrincipal" || menu.estadoJuego() == "reglas") {
        if (reglas.estaVisible()) {
            menu.ocultarReglas()
        } else {
            menu.mostrarReglas()
        }
        reglas.cambioVisible()
    }
})



        keyboard.a().onPressDo({=>juegoAsociado.pulsarNotaEn(botonVerde)
        if (!estaVerdePrendido) {
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
        if (!estaRojoPrendido) {
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
            if (!estaAmarilloPrendido) {
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
            if (!estaAzulPrendido) {
                estaAzulPrendido = true
                botonAzul.cambiarImage(botonAzul.botonHit()) 
                game.removeTickEvent("apagadoBotonAzul")
                game.onTick(300, "apagadoBotonAzul", { =>
                    estaAzulPrendido = false
                    botonAzul.cambiarImage(botonAzul.imagenApagado())
                    game.removeTickEvent("apagadoBotonAzul")
                })
            }})
        keyboard.space().onPressDo({ => cancion1.cerrarNivel()})
    }
}


object cancion1 {
    //METODO CERRAR NIVEL A TERMINAR (NO SE COMO PARAR LA MUSICA :( ))
    method cerrarNivel() {
        juego.eliminarVisuals()
        game.addVisual(dificultad)
        game.addVisual(botonIniciar)
        game.addVisual(fondoMenu)
        game.addVisual(tituloJuego)
        game.addVisual(botonIniciar)

    }
    method iniciar() {
        game.sound("cancionNivel1.mp3").play()
        game.schedule(4300, {=>self.iniciaMusica()})

    }
    method tresNotas() {
        juego.crearNotaVerde()
        juego.crearNotaRoja()
        game.schedule(250, {=>juego.crearNotaAzul()})
    }
    method cuatroNotas() {
        game.schedule(0, {=>self.tresNotas()})
        game.schedule(750, {=>juego.crearNotaAmarilla()})
    }
    method primerParte() {
        self.tresNotas()
        game.schedule(1300, {=>self.cuatroNotas()})


        game.schedule(2500, {=>self.tresNotas()})
        game.schedule(3800, {=>self.cuatroNotas()})


        game.schedule(5000, {=>self.tresNotas()})
        game.schedule(6100, {=>self.cuatroNotas()})

        game.schedule(7400, {=>self.tresNotas()})

    }
    method segundaParte() {
        self.tresNotas()

        game.schedule(600, {=>
        juego.crearNotaAmarilla()
        juego.crearNotaAzul()
        })
        game.schedule(1100, {=>
        juego.crearNotaRoja()})

    }
    method terceraParte() {
        self.tresNotas()

        game.schedule(1200, {=>
            // juego.crearNotaAmarilla()
            juego.crearNotaAzul()
        })
        // secuencia doble
        game.schedule(1300, {=>
            self.secuenciaDoble()
        })
        game.schedule(2100, {=>
            juego.crearNotaRoja() 
        })

        //NOTA AMARILLA RAPIDA DESPUES DE UNA NOTA ROJA
        // NO ES DIFICIL DE DAR, PERO LAGUEA EL JUEGO CUANDO HAY MUCHAS NOTAS EN LA PANTALLA
       game.schedule(2200, {=>
           juego.crearNotaAmarilla() 
       })  
    }
    method secuenciaDoble() {
        game.schedule(0, {=> 
        juego.crearNotaVerde() 
        juego.crearNotaRoja()
         })
        game.schedule(500, {=>
        // juego.crearNotaAmarilla()
        juego.crearNotaAzul() 
        })
    }
    method midGame() {
        self.tresNotas()
        game.schedule(2300, {=>self.terceraParte()})
        game.schedule(5000, {=>self.tresNotas()}) 

        game.schedule(7300, {=>
            // juego.crearNotaAmarilla()
            juego.crearNotaAzul()
                game.schedule(300, {=>
                    // juego.crearNotaRoja()
                    juego.crearNotaVerde()
            })
        })

        game.schedule(8400, {=>
            self.secuenciaDoble()})    
         game.schedule(9200, {=>
            juego.crearNotaRoja()})
        game.schedule(9500, {=>
            juego.crearNotaAmarilla()})

    }

    //ANTES DEL DROP CUARTA PARTE
    method cuartaParte() {
        game.schedule(0, {=> 
            juego.crearNotaVerde() 
            juego.crearNotaRoja() })
        game.schedule(300, {=>
            // juego.crearNotaAmarilla()
            juego.crearNotaAzul() })

        game.schedule(1400, {=> 
            //juego.crearNotaAmarilla()
            juego.crearNotaAzul() })
        game.schedule(1700, {=>
            // juego.crearNotaVerde() 
            juego.crearNotaRoja() })
        game.schedule(2700, {=>
            // juego.crearNotaVerde() 
            juego.crearNotaRoja() })
        game.schedule(3000, {=>
            juego.crearNotaAmarilla()})
        game.schedule(4000, {=>
            juego.crearNotaAzul()})
    }
    method drop() { 
        juego.crearNotaVerde()
        game.schedule(650, {=>
            juego.crearNotaRoja()
            game.schedule(650, {=>
                juego.crearNotaAmarilla()
                game.schedule(650, {=>
                    juego.crearNotaAzul()
                    game.schedule(650, {=>
                        juego.crearNotaVerde()
                        game.schedule(650, {=>
                            juego.crearNotaRoja()
                            game.schedule(650, {=>
                                juego.crearNotaAmarilla()
                                game.schedule(500, {=>
                                    juego.crearNotaAzul()
                                })
                            })
                        })
                    })
                })
            })
        })
        game.schedule(4800, {=> 
            juego.crearNotaVerde()
            game.schedule(350, {=>
                juego.crearNotaRoja()
                game.schedule(300, {=>
                    juego.crearNotaAmarilla()
                    game.schedule(300, {=>
                        juego.crearNotaAzul()
                        game.schedule(300, {=>
                            juego.crearNotaVerde()
                            game.schedule(300, {=> 
                                juego.crearNotaAzul()
                                game.schedule(300, {=>
                                    juego.crearNotaAmarilla()
                            })
                        })
                    })
                })
            })
        })
        game.schedule(2600, {=> 
            juego.crearNotaRoja()
            juego.crearNotaAzul()
            game.schedule(400, {=> 
                juego.crearNotaAmarilla()    
            })})
        game.schedule(3500, {=> 
            juego.crearNotaVerde()
            juego.crearNotaAmarilla()
            game.schedule(600, {=> 
                juego.crearNotaRoja()
                juego.crearNotaAzul()  
                game.schedule(900, {=> 
                    juego.crearNotaAmarilla()
                })  
            })
    })})
    }
    method iniciaMusica() {
        self.primerParte()
        //7400 termina la primera parte
        game.schedule(8500, {=>self.segundaParte()})
        game.schedule(11600, {=>self.terceraParte()
        })
        game.schedule(14200, {=>self.midGame()})

        game.schedule(23900, {=>self.cuartaParte()})
        
        game.schedule(33000, {=>
            self.drop()
        })
    }
}


object imagenPuntuacion {
    method position() = game.at(14, 14.5)
    method image() = "puntuacionchica.png"
}

object cartelPuntuacion {
    var property position = game.at(16.5, 14)
    var property text = ": 0"
    var property size = 50

    method actualizar(nuevaPuntuacion) {
        self.text(": " + nuevaPuntuacion)
    }
    
}

object cartelHits {
    var property position = game.at(17,14)
    var property text = "Hits: 0"
    var property size = 20 

    method actualizarHits(nuevoHits) {
        self.text("Puntuación: " + nuevoHits)
    }
    
}
object cartelFallos {
    var property text = "Fallos: 0" 
    var property size = 20
    var property position = game.at(17,13)
    
    method actualizarFallo(cantFallos) {
        self.text("Fallos: " + cantFallos)
    }
}

object cartelVida {
    var property text = "Vida: 3" 
    var property size = 20
    var property position = game.at(17,12)
    
    method actualizarVida(cantVida) {
        self.text("Vida: " + cantVida)
    }
}


object reglas {
    var property estaVisible = false
    method position() = game.at(-10, 0) //game.at(1,-14)
    method image() = "ruless.png"
    method cambioVisible() {
        estaVisible = !estaVisible
    }
}

// PLAYER 
object player {
    // seguro
    var property puntuacion = 0 // puntuacion del jugador
    var property multiplicador = 1 // maximo 4 sin poder, maximo 8 con poder
    var property energia =  0 //maximo 10
    var property fallos = 0 // cantidad de fallos
    var property consecutiveHits = 0
    var property vida = 3

    method restarVida() {
        if(fallos >= 20) {
            vida = (vida- 1).max(0)
            fallos = 0
            cartelVida.actualizarVida(self.vida())
        }
    }
    
    
    method sumarFallo() {fallos += 1}
    method sumarPuntuacion(valor) {puntuacion += valor}
    method aumentarMultiplicador() {
        consecutiveHits += 1 // Increment streak
        if (consecutiveHits == 4) { 
            multiplicador = 2
        } else if (consecutiveHits == 8) {
            multiplicador = 3
        } 
    }

    method reiniciarMultiplicador() {
        multiplicador = 1
        consecutiveHits = 0 
    }


    // method activarPoder() {
    //     if (energia == 10){ 
    //         //cancion.notas.forEach({n=>n.cambiarImage("noteSuper.png")}) 
    //         //cancion.notas.forEach({n=>n.cambiarImage("noteSuperHit.png")})
    //         multiplicador *= 2
    //         energia = 0
    //         poder = true
    //         self.desactivarPoder()
    //     } else {
    //         throw new Exception(message="No hay suficiente energia")
    //     }
    // }

    // method desactivarPoder() {
    //     game.onTick(300,"desactivarPoder", {poder = false})
    // }
}

//NOTAS

class Notas {
    var property image   
    var property puntuacion = 2
    var property position
    var property botonAsignado


     //ELIMINA LA NOTA
    method eliminar() {
        game.removeVisual(self)
        
    }

    

    method queCaiga() {
        game.onTick(100,"caerse", {self.position(self.position().down(1))})
    }

    //SISTEMA DE PUNTUACION
    method hit() {
        
        player.sumarPuntuacion(puntuacion * player.multiplicador())
        self.eliminar()
        player.aumentarMultiplicador()

        }
        
    

    // SISTEMA DE REINICIO 
    method fail() {
        player.sumarFallo()
        player.reiniciarMultiplicador()
        
        
    }
}
// // BOTONES

class Botones {
    var property position
    var property imagenApagado     
    var property imagenActual      
    var property botonHit

    method image() = imagenActual
    method position() = position
    method cambiarImage(png) { imagenActual = png }
}

object botonVerde inherits Botones(position = game.at(2,1), imagenApagado = "boton1.png", imagenActual = "boton1.png" ,botonHit = "boton1Hit.png"){

}
object botonRojo inherits Botones(position = game.at(5,1), imagenApagado = "boton2.png", imagenActual = "boton2.png", botonHit = "boton2Hit.png"){

}
object botonAmarillo inherits Botones(position = game.at(8,1), imagenApagado = "boton3.png", imagenActual ="boton3.png", botonHit = "boton3Hit.png"){

}
object botonAzul inherits Botones(position = game.at(11,1), imagenApagado = "boton4.png", imagenActual = "boton4.png", botonHit = "boton4Hit.png"){

}
object botonNaranja inherits Botones(position = game.at(14,1), imagenApagado = "boton5.png", imagenActual = "boton5.png", botonHit = "boton5Hit.png"){

}

