//
//  Pelicula.swift
//  Prueba Tecnica Netflix
//
//  Created by César MS on 06/07/22.
//

import SwiftUI

struct Pelicula: Identifiable{
    var id: Int
    var idDocumento: String
    var urlImagen: String
    var favorito: Bool
    var urlTrailer: String
    var nombre: String
    var duracion: String
    var fechaEstreno: String
    var sinopsis: String
    var productora: String
    var urlImagenProductora: String
    var lenguajeOriginal: String
}
