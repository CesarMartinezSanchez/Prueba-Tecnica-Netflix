//
//  ContentView.swift
//  Prueba Tecnica Netflix
//
//  Created by César MS on 06/07/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var correo = ""
    @State private var contraseña = ""
    @State private var usuarioLoggeado = false
    @State private var errorLabel = false
    @State private var showLoader = false
    
    
    var body: some View {
        if usuarioLoggeado {
            MenuPeliculasView()
        } else {
            contentLogin
        }
    }
    
    var contentLogin: some View {
        
        ZStack  {
            
            
            Color.black
            Image("fondo-pantalla")
                .resizable()
                .frame(width: 450, height: 900)
                .padding(10)
            
            if showLoader {
                ZStack{
                    RoundedRectangle(cornerRadius: 50).fill(.green.opacity(0.9))
                    ProgressView()
                }.frame(width: 100, height: 100, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 50).stroke(.white,lineWidth: 1))
            }
            
            VStack(spacing: 20) {
                Text("Bienvenido a")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .serif))
                    .offset(x: 0, y: -130)
                
                Text("TV Show")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .serif))
                    .offset(x: 0, y: -130)
                
                Text("Inicia sesión")
                    .foregroundColor(.green)
                    .font(.system(size: 30, weight: .bold, design: .serif))
                    .offset(x: 0, y: -100)
                
                TextField("Correo", text: $correo)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: correo.isEmpty){
                        Text("Correo")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .offset(y: -80)
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.green)
                    .offset(y: -90)
                
                SecureField("Contraseña", text: $contraseña)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: contraseña.isEmpty){
                        Text("Contraseña")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .offset(y: -80)
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.green)
                    .offset(y: -90)
                
                
                
                
                if errorLabel {
                    Text("Por favor revisa tus credenciales")
                        .foregroundColor(.red)
                        .offset(y: -90)
                        .frame(width: 350, alignment: .leading)
                        .font(.system(size: 15, weight: .bold, design: .serif))
                }
                
                Button{
                    showLoader.toggle()
                    login()
                } label: {
                    Text("Ingresar")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.green, .green], startPoint: .top, endPoint: .bottomTrailing)))
                        .foregroundColor(.black)
                }
                .padding(.top)
                
                
            }
            .frame(width: 350)
            
            
        }
        .ignoresSafeArea()
        
    }
    
    func login()  {
        Auth.auth().signIn(withEmail: correo, password: contraseña) { result, error in
            if error != nil  {
                errorLabel.toggle()
                showLoader.toggle()
                print("Error al ingresar", error!.localizedDescription)
            } else {
                usuarioLoggeado.toggle()
                showLoader.toggle()
                UserDefaults.standard.set("ConUsuario", forKey: "login")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portraitUpsideDown)
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
