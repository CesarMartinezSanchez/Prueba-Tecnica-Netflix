//
//  MenuPeliculasView.swift
//  Prueba Tecnica Netflix
//
//  Created by César MS on 06/07/22.
//

import SwiftUI
import Firebase

struct MenuPeliculasView: View {
    @ObservedObject var conexionBD = ConexionBD()
    @State private var usuarioLoggeado = false
    @State private var mostrarAlerta = false
    @State private var irPerfil = false
    
    var body: some View {
        if usuarioLoggeado {
            ContentView()
        } else {
            if irPerfil{
                PerfilUsuarioView()
            } else {
                contentPeliculas
            }
        }
    }
    
    
    init() {
        conexionBD.traerPeliculas()
    }
    
    var contentPeliculas: some View {
        
        NavigationView {
            
            List(conexionBD.peliculas, id: \.id) { pelicula in
                NavigationLink(destination: DetallePeliculaView(pelicula: pelicula)){
                    CeldaPeliculasView(pelicula: pelicula).background(.gray.opacity(0.5)).cornerRadius(15)
                }.listRowBackground(Color.black)
            }.background(Color.black.ignoresSafeArea())
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
            .navigationTitle("TV Show")
            .navigationBarTitleTextColor(Color.green)
            .navigationBarItems(trailing: Button(action: {
                self.mostrarAlerta.toggle()
            }, label: {
                Image("perfil")
                    .frame(width: 30, height: 30)
                
            }).actionSheet(isPresented: $mostrarAlerta){
                ActionSheet(title: Text("¿Qué es lo que quieres hacer?"), buttons: [
                
                    ActionSheet.Button.default(Text("Ver Perfil"), action: {
                        self.irPerfil.toggle()
                    }),
                    ActionSheet.Button.destructive(Text("Cerrar sesión"), action: {
                        LogOut()
                    }),
                    ActionSheet.Button.cancel()
                    
                ])
            }
            
            )
        }
    }

    func LogOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            usuarioLoggeado.toggle()
            UserDefaults.standard.set("SinUsuario", forKey: "login")
            print("Cerro sesion con exito")
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

struct MenuPeliculasView_Previews: PreviewProvider {
    static var previews: some View {
        MenuPeliculasView()
    }
}
