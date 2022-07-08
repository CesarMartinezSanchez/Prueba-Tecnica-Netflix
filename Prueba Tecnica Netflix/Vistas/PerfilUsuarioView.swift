//
//  PerfilUsuarioView.swift
//  Prueba Tecnica Netflix
//
//  Created by César MS on 07/07/22.
//

import SwiftUI
import Firebase

struct PerfilUsuarioView: View {
    @ObservedObject var conexionBD = ConexionBD()
    @State private var irMenu = false
    @State private var irLogin = false
    
    var body: some View {
        if irMenu {
            MenuPeliculasView()
        } else {
            contentPerfil
        }
    }
    
    init(){
        conexionBD.traerPeliculas()
    }
    
    var contentPerfil: some View {
        VStack {
            
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 4))
                    .shadow(color: .green, radius: 5)
                    .foregroundColor(.green)
                    .padding(10)
                VStack{
                    
                    Button{
                        self.irMenu.toggle()
                    } label: {
                        Text("Menu Principal")
                            .bold()
                            .frame(width: 150, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(colors: [.green, .green], startPoint: .top, endPoint: .bottomTrailing)))
                            .foregroundColor(.white)
                    }
                    let correo = Auth.auth().currentUser?.email
                    Text(correo!)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold, design: .serif))
                }
            }
            
            Text("Favoritos")
                .font(.system(size: 17, weight: .bold, design: .serif))
                .foregroundColor(.green)
                .lineLimit(2)
            
            
            List(conexionBD.peliculasFavoritas, id: \.id) { pelicula in
                CeldaPeliculasView(pelicula: pelicula).background(.gray.opacity(0.5)).cornerRadius(15).listRowBackground(Color.black)
            }
            .background(Color.black.ignoresSafeArea())
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
            
        }.background(.black)
        
    }
}

struct PerfilUsuarioView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilUsuarioView()
    }
}
