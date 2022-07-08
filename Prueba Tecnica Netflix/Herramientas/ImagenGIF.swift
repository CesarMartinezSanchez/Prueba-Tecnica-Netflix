//
//  ImagenGIF.swift
//  Prueba Tecnica Netflix
//
//  Created by César MS on 07/07/22.
//

import SwiftUI
import WebKit

struct ImagenGIF: UIViewRepresentable {
    private let nombre: String
    
    init(_ nombre: String){
        self.nombre = nombre
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: nombre, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}

struct ImagenGIF_Previews: PreviewProvider {
    static var previews: some View {
        ImagenGIF("ejemplo")
    }
}


extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
    
        // Set appearance for both normal and large sizes.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
    
        return self
    }
}
