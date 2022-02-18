//
//  OfertaTableViewCell.swift
//  AluraViagens
//
//  Created by Kelly Silva Araujo on 07/02/22.
//

import UIKit

protocol OfertaTableViewCellDelegate: AnyObject {
    func didSelectView(_ viagem: Viagem?) // seleciona a view e envia a viagem que foi selecionada
}

class OfertaTableViewCell: UITableViewCell {
    
// MARK: IBOutlets
// outlets criados pra conseguir manejar esses elementos no código

    @IBOutlet var viagemImages: [UIImageView]!
    @IBOutlet var tituloViagemLabels: [UILabel]!
    @IBOutlet var subtituloViagemLabels: [UILabel]!
    @IBOutlet var precoSemDescontoLabels: [UILabel]!
    @IBOutlet var precoLabels: [UILabel]!
  
    @IBOutlet var fundoViews: [UIView]!
    
    weak var delegate: OfertaTableViewCellDelegate? // vai ser do tipo do protocolo criado acima
    
    private var viagens: [Viagem]?
    
    
    func configuraCelula(_ viagens: [Viagem]?) {
        
        self.viagens = viagens
        
        guard let listaDeViagem = viagens else { return }
        
        for i in 0..<listaDeViagem.count {
            setOutlets(i, viagem: listaDeViagem[i])
        }
        
        fundoViews.forEach { viewAtual in // percorre lista e add efeito de sombra
            viewAtual.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectView(_:))))
            viewAtual.addSombra()
        }
    }
    
    func setOutlets(_ index: Int, viagem: Viagem) {
        let imageOutlet = viagemImages[index]
        imageOutlet.image = UIImage(named: viagem.asset)
        
        let tituloOutlet = tituloViagemLabels[index]
        tituloOutlet.text = viagem.titulo
        
        let subtituloOutlet = subtituloViagemLabels[index]
        subtituloOutlet.text = viagem.subtitulo
        
        let precoSemDescontoOutlet = precoSemDescontoLabels[index]
        precoSemDescontoOutlet.text = "A partir de R$ \(viagem.precoSemDesconto)"
        
        let precoOutlet = precoLabels[index]
        precoOutlet.text = "R$ \(viagem.preco)"
    }
    
    @objc func didSelectView(_ gesture: UIGestureRecognizer) { // método dispara com um clique em uma das views
        if let selectedView = gesture.view {
            let viagemSelecionada = viagens?[selectedView.tag] // pega a viagem selecionada
            delegate?.didSelectView(viagemSelecionada)
        }
    }
}
