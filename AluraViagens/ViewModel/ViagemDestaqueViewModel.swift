//
//  ViagemDestaqueViewModel.swift
//  AluraViagens
//
//  Created by Kelly Silva Araujo on 06/02/22.
//

import Foundation

class ViagemDestaqueViewModel: ViagemViewModel {     // implementação do protocolo criado anteriormente, ou seja, todo view model criado terá aquelas variáveis declaradas - responsável por montar a seção de destaques da lista
    
    var titutoSessao: String {
        return "Destaques"
    }
    
    var tipo: ViagemViewModelType {
        return .destaques
    }
    
    var viagens: [Viagem]
    
    var numeroDeLinhas: Int {
        return viagens.count
    }
    
    init(_ viagens: [Viagem]) { // método construtor que pega a lista de viagens acima
        self.viagens = viagens // = lista recebida pelo parâmetro
    }
}
