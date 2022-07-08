//
//  DetallePeliculaView.swift
//  Prueba Tecnica Netflix
//
//  Created by César MS on 07/07/22.
//

import SwiftUI
import AVKit

struct DetallePeliculaView: View {
    let pelicula: Pelicula
    @ObservedObject var conexionBD = ConexionBD()
    @State private var favorito = false
    
    init(pelicula: Pelicula){
        self.pelicula = pelicula
        conexionBD.traerPeliculas()
    }
    
    
    var body: some View {
        VStack {
            HStack{
                
                AsyncImage(url: URL(string: pelicula.urlImagen)){ image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.frame(width: 150, height: 250)
                .shadow(color: .green, radius: 5)
                
                VStack {
                    
                    HStack {
                        Text(pelicula.fechaEstreno)
                            .foregroundColor(.white)
                        Text(pelicula.duracion)
                            .foregroundColor(.white)
                    }
                    Text("Ahora puedes verla en:")
                        .foregroundColor(.white)
                    Text(pelicula.productora)
                        .foregroundColor(.white)
                    
                    AsyncImage(url: URL(string: pelicula.urlImagenProductora)){ image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }.frame(width: 60, height: 60)
                    
                    Text("Lenguaje Original: " + pelicula.lenguajeOriginal)
                        .foregroundColor(.white)
                    if pelicula.favorito {
                        Button {
                            conexionBD.actualizarFavoritos(documentoId: pelicula.idDocumento, estado: false)
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
                            conexionBD.actualizarFavoritos(documentoId: pelicula.idDocumento, estado: true)
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
                
            }
            
            Text(pelicula.sinopsis)
                .foregroundColor(.green)
            
            VideoPlayer(player: .init(url: URL(string: pelicula.urlTrailer)!)) {
            }
        }.background(.black)
            .navigationTitle(pelicula.nombre)
            .navigationBarTitleTextColor(.green)
    }
}

struct DetallePeliculaView_Previews: PreviewProvider {
    static var previews: some View {
        DetallePeliculaView(pelicula: Pelicula(id: 0, idDocumento: "0", urlImagen: "", favorito: false, urlTrailer: "", nombre: "Nombre Pelicula", duracion: "1 h 47 m", fechaEstreno: "22 / Junio / 2021", sinopsis: "After a particle accelerator causes a freak storm, CSI Investigator Barry Allen is struck by lightning and falls into a coma. For now, only a few close friends and associates know that Barry is literally the fastest man alive, but it won't be long before the world learns what Barry Allen has become...The Flash.", productora: "Netflix", urlImagenProductora: "", lenguajeOriginal: "Español"))
    }
}
