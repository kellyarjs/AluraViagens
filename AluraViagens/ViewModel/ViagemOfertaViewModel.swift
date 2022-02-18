//
//  ViagemOfertaViewModel.swift
//  AluraViagens
//
//  Created by Kelly Silva Araujo on 07/02/22.
//

import Foundation

class ViagemOfertaViewModel: ViagemViewModel { // nova classe e protocolo anterior - nova viewModel de ofertas
    var titutoSessao: String {
        return "Ofertas"
    }
    
    var tipo: ViagemViewModelType {
        return .ofertas //daquele "enum"
    }
    
    var viagens: [Viagem] // precisa do inicializador abaixo
    
    var numeroDeLinhas: Int {
        return 1
    }
    
    // MARK: Inicializador
    
    init(_ viagens: [Viagem]) {
        self.viagens = viagens //valor setado é o recebido por parâmetro
    }
}
