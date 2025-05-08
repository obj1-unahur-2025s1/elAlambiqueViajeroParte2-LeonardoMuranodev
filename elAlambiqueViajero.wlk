object centroDeInscripcion {
    var property ciudad = paris
    const inscriptos = []
    const rechazados = []

    //Metodos de consulta

    method inscriptos() {
        return inscriptos
    }
    method realizarCarrera(){
        return inscriptos.min({p =>  p.vehiculo().tiempoDeCarrera()})
    }

    //Metodos de indicacion
    method agregarParticipante(unParticipante){
        if(ciudad.puedeLlegar(unParticipante.vehiculo())){
            inscriptos.add(unParticipante)
        } else {
            rechazados.add(unParticipante)
        }
    }

    method replanificacionDeLaCarrera(unaCiudad){
        ciudad = unaCiudad
        const todos = inscriptos + rechazados
        inscriptos.clear()
        rechazados.clear()
        todos.forEach({p => self.agregarParticipante(p)})
    }

    method irALaCarrera(){
        inscriptos.forEach({p => p.vehiculo().desgaste()})
    }
}

//Participantes
object luke{
    var  property vehiculo = alambiqueVeloz
    var cantidadViajes = 0
    var recuerdo = null
    method cantidadViajes() = cantidadViajes 
    method recuerdo() = recuerdo
    
    method viajar(lugar){
        if (lugar.puedeLlegar(vehiculo)) {
            cantidadViajes = cantidadViajes + 1
            recuerdo = lugar.recuerdoTipico()
            vehiculo.desgaste()
        }
    }
}

object gangsters{
    const miembros = []

    //metodos de consulta
    method vehiculo() = antigualla
    method sonPar() = miembros.size().even()
    method totalLetras() = miembros.sum({m => m.size()})

    //metodos de indicacion
    method agregarGangster(unGangster) {
        miembros.add(unGangster)
    }

    method eliminarGangster() {
        miembros.remove(miembros.last())
    }
}

object nodoyunaYPan{
    method vehiculo() = doblePP
    method esOSonTramposos() = true
}

object profesorLocovich {
    method vehiculo() = convertible
}

//Lugares
object paris{
    method recuerdoTipico() = "Llavero Torre Eiffel"
    method puedeLlegar(auto) =  auto.puedeFuncionar()
    method esAdecuadaParaCarreraRapida() = false 
    method esAdecuadaParaAutosGrandes() = false
}

object buenosAires{
    method recuerdoTipico() = "Mate"
    method puedeLlegar(auto) =  auto.esRapido()
    method esAdecuadaParaCarreraRapida() = true
    method esAdecuadaParaAutosGrandes() = false
}

object bagdad {
    var property recuerdoTipico = "bidon de petroleo"
    method puedeLlegar(auto) = true
    method esAdecuadaParaCarreraRapida() = false
    method esAdecuadaParaAutosGrandes() = false
}

object lasVegas{
    var homenaje = paris
    method homenaje(lugar) {homenaje = lugar}
    method recuerdoTipico() = homenaje.recuerdoTipico()
    method puedeLlegar(auto) = homenaje.puedeLlegar(auto)
    method esAdecuadaParaCarreraRapida() = homenaje.esAdecuadaParaCarreraRapida()
    method esAdecuadaParaAutosGrandes() = homenaje.esAdecuadaParaAutosGrandes()
}

//Nuevo lugar turistico
object hurlingham{
    method puedeLlegar(auto){
        return auto.puedeFuncionar() and auto.esRapido() 
        and auto.patenteValida()
    }
    method recuerdoTipico() = "sticker de la Unahur"
    method esAdecuadaParaCarreraRapida() = true
    method esAdecuadaParaAutosGrandes() = false
}


//Vehiculos
object alambiqueVeloz {
    var property combustible = 20
    const consumoPorViaje = 10
    
    //Metodos de consulta
    method esRapido() = true
    method esGrande() = false
    method patente() = "AB123JK"
    method patenteValida() = self.patente().take(1) == "A"
    method puedeFuncionar() = combustible >= consumoPorViaje

    //Metodos de indicacion
    method desgaste() {
        combustible = combustible - consumoPorViaje
    }

    method tiempoDeCarrera(){
        var tiempo = 0
        if(centroDeInscripcion.ciudad().esAdecuadaParaCarreraRapida()){
            if(self.esRapido()){
                tiempo += 5
            } else {
                tiempo += 15
            }
        } else {
            if(self.esRapido()){
                tiempo += 5
            } else {
                tiempo += 10
            }
        }

        if(centroDeInscripcion.ciudad().esAdecuadaParaAutosGrandes()){
            if(self.esGrande()){
                tiempo += 10
            } else {
                tiempo += 10
            }
        } else {
            if(self.esGrande()){
                tiempo += 15
            } else {
                tiempo += 5
            }
        }
        return tiempo
    }
}


object antigualla {
    //Metodos de consulta
    method puedeFuncionar() = gangsters.sonPar()
    method esRapido() = gangsters.totalLetras() > 35
    method esGrande() = true
    method patenteValida() = chatarra.esRapido() 

    method tiempoDeCarrera(){
        var tiempo = 0
        if(centroDeInscripcion.ciudad().esAdecuadaParaCarreraRapida()){
            if(self.esRapido()){
                tiempo += 5
            } else {
                tiempo += 15
            }
        } else {
            if(self.esRapido()){
                tiempo += 5
            } else {
                tiempo += 10
            }
        }

        if(centroDeInscripcion.ciudad().esAdecuadaParaAutosGrandes()){
            if(self.esGrande()){
                tiempo += 10
            } else {
                tiempo += 10
            }
        } else {
            if(self.esGrande()){
                tiempo += 15
            } else {
                tiempo += 5
            }
        }
        return tiempo
    }

    //Metodos de indicacion
    method desgaste(){
        gangsters.eliminarGangster()
    }
}
object chatarra {
    var property cañones = 10
    var property municiones = "ACME"

    //Metodos de consulta
    method puedeFuncionar() = municiones == "ACME" and cañones.between(6,12)
    method esRapido() = municiones.size() < cañones
    method esGrande() = cañones > 5
    method patenteValida() = municiones.take(4) == "ACME" 
    method cañones() = cañones

    //Metodos de indicacion
    method desgaste(){
        cañones = (cañones / 2).roundUp(0)
        if (cañones < 5 )
          municiones = municiones + " Obsoleto"
    }

     method tiempoDeCarrera(){
        var tiempo = 0
        if(centroDeInscripcion.ciudad().esAdecuadaParaCarreraRapida()){
            if(self.esRapido()){
                tiempo += 5
            } else {
                tiempo += 15
            }
        } else {
            if(self.esRapido()){
                tiempo += 5
            } else {
                tiempo += 10
            }
        }

        if(centroDeInscripcion.ciudad().esAdecuadaParaAutosGrandes()){
            if(self.esGrande()){
                tiempo += 10
            } else {
                tiempo += 10
            }
        } else {
            if(self.esGrande()){
                tiempo += 15
            } else {
                tiempo += 5
            }
        }
        return tiempo
    }
}

object convertible{
    const vehiculos = []

    //Metodos de consulta
    method ultimoTransformado() = vehiculos.last()
    method puedeFuncionar() = self.ultimoTransformado().puedeFuncionar() 
    method esRapido() = self.ultimoTransformado().esRapido()
    method esGrande() = self.ultimoTransformado().esGrande()
    method patenteValida() = self.ultimoTransformado().patenteValida()

    //Metodos de indicacion
    method desgaste(){
        self.ultimoTransformado().desgaste()
    }

    method agregarVehiculo(unVehiculo){
        vehiculos.add(unVehiculo)
    }

     method tiempoDeCarrera(){
        var tiempo = 0
        if(centroDeInscripcion.ciudad().esAdecuadaParaCarreraRapida()){
            if(self.esRapido()){
                tiempo += 5
            } else {
                tiempo += 15
            }
        } else {
            if(self.esRapido()){
                tiempo += 5
            } else {
                tiempo += 10
            }
        }

        if(centroDeInscripcion.ciudad().esAdecuadaParaAutosGrandes()){
            if(self.esGrande()){
                tiempo += 10
            } else {
                tiempo += 10
            }
        } else {
            if(self.esGrande()){
                tiempo += 15
            } else {
                tiempo += 5
            }
        }
        return tiempo
    }
}

object moto{
    //metodos de consulta
    method esRapido() = true
    method esGrande() = false
    method puedeFuncionar() = !self.esRapido()
    method patenteValida() = false

    //Metodos de indicacion
    method desgaste() { }

     method tiempoDeCarrera(){
        var tiempo = 0
        if(centroDeInscripcion.ciudad().esAdecuadaParaCarreraRapida()){
            if(self.esRapido()){
                tiempo += 5
            } else {
                tiempo += 15
            }
        } else {
            if(self.esRapido()){
                tiempo += 5
            } else {
                tiempo += 10
            }
        }

        if(centroDeInscripcion.ciudad().esAdecuadaParaAutosGrandes()){
            if(self.esGrande()){
                tiempo += 10
            } else {
                tiempo += 10
            }
        } else {
            if(self.esGrande()){
                tiempo += 15
            } else {
                tiempo += 5
            }
        }
        return tiempo
    }
}

object doblePP{
    var property combustible = 200
    const consumoPorViaje = 2 * self.patente().size()
    
    //Metodos de consulta
    method esRapido() = true
    method esGrande() = true
    method patente() = "PPPPP"
    method patenteValida() = self.patente().take(self.patente().size()) == "PPPPP"
    method puedeFuncionar() = combustible >= consumoPorViaje

    //Metodos de indicacion
    method desgaste() {
        combustible = combustible - consumoPorViaje
    }

    method tiempoDeCarrera(){
        var tiempo = 5 //ya que son tramposos nodoyuna y pan
        if(centroDeInscripcion.ciudad().esAdecuadaParaCarreraRapida()){
            if(self.esRapido()){
                tiempo += 5
            } else {
                tiempo += 15
            }
        } else {
            if(self.esRapido()){
                tiempo += 5
            } else {
                tiempo += 10
            }
        }

        if(centroDeInscripcion.ciudad().esAdecuadaParaAutosGrandes()){
            if(self.esGrande()){
                tiempo += 10
            } else {
                tiempo += 10
            }
        } else {
            if(self.esGrande()){
                tiempo += 15
            } else {
                tiempo += 5
            }
        }
        return tiempo
    }
}