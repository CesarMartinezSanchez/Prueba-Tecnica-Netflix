//
//  CeldaPeliculasView.swift
//  Prueba Tecnica Netflix
//
//  Created by César MS on 07/07/22.
//

import SwiftUI

struct CeldaPeliculasView: View {
    @State private var favorito = false
    var pelicula: Pelicula
    
    var body: some View {
        HStack {
            
            AsyncImage(url: URL(string: pelicula.urlImagen)){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 85, height: 150)
            .cornerRadius(15)
            .padding(10)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(pelicula.nombre)
                        .font(.system(size: 17, weight: .bold, design: .serif))
                        .foregroundColor(.green)
                        .lineLimit(2)
                    Spacer()
                    
                    if pelicula.favorito {
                        Button {
                            ConexionBD().actualizarFavoritos(documentoId: pelicula.idDocumento, estado: false)
                            favorito.toggle()
                        } label: {
                            if favorito {
                                Image("no-favorito")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(10)
                            } else {
                                Image("favorito")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(10)
                            }
                        }
                        
                    } else {
                        Button {
                            ConexionBD().actualizarFavoritos(documentoId: pelicula.idDocumento, estado: true)
                            favorito.toggle()
                        } label: {
                            if favorito {
                                Image("favorito")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(10)
                            } else {
                                Image("no-favorito")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(10)
                            }
                        }
                    }
                    
                }
                HStack {
                    Text(pelicula.fechaEstreno)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold, design: .serif))
                    Text(pelicula.duracion)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold, design: .serif))
                }
                Text(pelicula.sinopsis)
                    .font(.system(size: 10, weight: .bold, design: .serif))
                    .foregroundColor(.green)
                    .lineLimit(7)
            }
            
        }
        .ignoresSafeArea()
        .cornerRadius(20)
    }
}

struct CeldaPeliculasView_Previews: PreviewProvider {
    static var previews: some View {
        CeldaPeliculasView(pelicula: Pelicula(id: 0, idDocumento: "0", urlImagen: "", favorito: false, urlTrailer: "", nombre: "Nombre Pelicula", duracion: "1 h 47 m", fechaEstreno: "22 / Junio / 2021", sinopsis: "After a particleTh that Barry is literally the fastest man alive, but it won't be long before the world learns what Barry Allen has become...The Flash.", productora: "", urlImagenProductora: "", lenguajeOriginal: ""))
    }
}
