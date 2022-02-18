//
//  DecodableData.swift
//  AluraViagens
//
//  Created by Ândriu Felipe Coelho on 28/01/21.
//

import Foundation // classe que vai ler o json e fazer a desserialização

let secaoDeViagens: [ViagemViewModel]? = load("server-response.json")

func load(_ filename: String) -> [ViagemViewModel]? {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            fatalError("error to read json dictionary")
        }
        
        guard let listaDeViagens = json["viagens"] as? [String: Any] else {
            fatalError("error to read travel list")
        }
        
        guard let jsonData = TiposDeViagens.jsonToData(listaDeViagens) else { return nil }
        
        let tiposDeViagens = TiposDeViagens.decodeJson(jsonData)
        
        var listaViagemViewModel: [ViagemViewModel] = []
        
        for sessao in listaDeViagens.keys {
            switch ViagemViewModelType(rawValue: sessao)  {
            case .destaques:
                if let destaques = tiposDeViagens?.destaques {
                    let destaqueViewModel = ViagemDestaqueViewModel(destaques)
                    listaViagemViewModel.insert(destaqueViewModel, at: 0)
                }
                
            case .ofertas: // criação de nova viewModel e adição da lista de viagens nela
                if let ofertas = tiposDeViagens?.ofertas {   // verificação pra ver se existe esse tipo / tiposd... constante lá de cima
                let ofertaViewModel = ViagemOfertaViewModel(ofertas) // se essa lista existir, a viewModel será criada
                    listaViagemViewModel.append(ofertaViewModel)
                }
            default:
                break
            }
        }
        
        return listaViagemViewModel
    } catch {
        fatalError("Couldn't parse")
    }
}
