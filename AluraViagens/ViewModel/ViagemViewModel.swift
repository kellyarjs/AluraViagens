//
//  ViagemViewModel.swift
//  AluraViagens
//
//  Created by Kelly Silva Araujo on 06/02/22.
//

import Foundation

enum ViagemViewModelType: String {
case destaques // primeiro tipo de viagem
case ofertas
case internacionais
}

protocol ViagemViewModel { //esse protocolo tem algumas caraterísticas de viagem, o que precisa que alguma célula exiba na tableView - as infos que precisam ser visualizadas foram implementadas nesse protocolo - facilita na hora de criar um novo viewModel, isso é, um novo tipo de viagem
    var titutoSessao: String {get}
    var tipo: ViagemViewModelType { get } // tipos de viagens - enum criado acima
    var viagens: [Viagem] { get set } //lista de viagens
    var numeroDeLinhas: Int { get } // como a ideia é avançar com o projeto e ter mais de uma seção na tabela, é necessário saber quantas linhas tem em cada seção
}
