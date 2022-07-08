//
//  ConexionBD.swift
//  Prueba Tecnica Netflix
//
//  Created by César MS on 06/07/22.
//

import SwiftUI
import Firebase

class ConexionBD: ObservableObject {
    @Published var peliculas: [Pelicula] = []
    @Published var peliculasFavoritas: [Pelicula] = []
    
    func actualizarFavoritos(documentoId: String, estado: Bool) {
        let db = Firestore.firestore()
        let ref = db.collection("Peliculas")
        
        ref.document(documentoId)
            .updateData(
               [
                "favorito" : estado
               ]
              ) { (error) in
              if error != nil{
                  print("Error al actualizar: ", error!.localizedDescription)
              }
              else {
                  self.traerPeliculas()
                print("Actualización exitosa")
              }
            }
    }
    
    func traerPeliculas() {
        let db = Firestore.firestore()
        let ref = db.collection("Peliculas")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                
                DispatchQueue.main.async {
                    for document in snapshot.documents {
                        let data = document.data()
                        
                        let id = data["id"] as! Int
                        let nombre = data["nombre"] as? String ?? ""
                        let duracion = data["duracion"] as? String ?? ""
                        let favorito = (data["favorito"] as? Bool)!
                        let fechaEstreno  = data["fechaEstreno"] as? String ?? ""
                        let lenguajeOriginal = data["lenguajeOriginal"] as? String ?? ""
                        let productora = data["productora"] as? String ?? ""
                        let urlImagen = data["urlImagen"] as? String ?? ""
                        let urlImagenProductora = data["urlImagenProductora"] as? String ?? ""
                        let urlTrailer = data["urlTrailer"] as? String ?? ""
                        let sinopsis = data["sinopsis"] as? String ?? ""
                        
                        let pelicula = Pelicula(id: id, idDocumento: document.documentID, urlImagen: urlImagen, favorito: favorito, urlTrailer: urlTrailer, nombre: nombre, duracion: duracion, fechaEstreno: fechaEstreno, sinopsis: sinopsis, productora: productora, urlImagenProductora: urlImagenProductora, lenguajeOriginal: lenguajeOriginal)
                        if pelicula.favorito == true {
                            self.peliculasFavoritas.append(pelicula)
                        }
                        self.peliculas.append(pelicula)
                    }                    
                }
                
            }
        }
    }
}
