//
//  Prueba_Tecnica_NetflixApp.swift
//  Prueba Tecnica Netflix
//
//  Created by César MS on 06/07/22.
//

import SwiftUI
import Firebase

@main
struct Prueba_Tecnica_NetflixApp: App {
    @StateObject var conexionBD = ConexionBD()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            let value = (UserDefaults.standard.string(forKey: "login"))
            if value == "ConUsuario" {
                MenuPeliculasView()
            } else {
                ContentView()
            }
        }
    }
}
