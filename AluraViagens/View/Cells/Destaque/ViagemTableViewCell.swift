//
//  ViagemTableViewCell.swift
//  AluraViagens
//
//  Created by Kelly Silva Araujo on 06/02/22.
//

import UIKit

class ViagemTableViewCell: UITableViewCell {

    // MARK: IBOutlets
   // outlets que seta as informações de viagem da célula
    
    @IBOutlet weak var backgroundViewCell: UIView!
    @IBOutlet weak var viagemImage: UIImageView!
    @IBOutlet weak var tituloViagemLabel: UILabel!
    @IBOutlet weak var subtituloViagemLabel: UILabel!
    @IBOutlet weak var diariaViagemLabel: UILabel!
    @IBOutlet weak var precoSemDescontoLabel: UILabel!
    @IBOutlet weak var precoViagemLabel: UILabel!
    @IBOutlet weak var statusCancelamentoViagemLabel: UILabel!
 
    func configuraCelula(_ viagem: Viagem?) { // método que configura os outlets segundo as informações do json
        
        viagemImage.image = UIImage(named: viagem?.asset ?? "") // configuração dos elementos: inicializador onde o nome é passado -> o nome da viagem é de acordo com o que receber no parâmetro do método acima -> verificação: ele vai tentar receber esse valor, se não conseguir, vai setar uma string vazia
        
        tituloViagemLabel.text = viagem?.titulo
        subtituloViagemLabel.text = viagem?.subtitulo
        precoViagemLabel.text = "R$ \(viagem?.preco ?? 0)"
        
        let atributoString: NSMutableAttributedString = NSMutableAttributedString(string: "R$ \(viagem?.precoSemDesconto ?? 0)")  // atributo pra efeito de risco na string
        atributoString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, atributoString.length))
        precoSemDescontoLabel.attributedText = atributoString //adição do atributo à label
        
        if let numeroDeDias = viagem?.diaria, let numeroDeHospedes = viagem?.hospedes { // desembrulha o n. de dias e de hóspedes
            let diarias = numeroDeDias == 1 ? "Diária" : "Diárias"// verificação, porque pode ter uma diária ou > 1
            let hospedes = numeroDeHospedes == 1 ? "Pessoa" : "Pessoas"
            
            diariaViagemLabel.text = "\(numeroDeDias) \(diarias) - \(numeroDeHospedes) \(hospedes)" // string customizada com as validações feitas anteriormente
        }
        
        DispatchQueue.main.async { // atualização em outra thread desse efeito (sombra) de UI
            self.backgroundViewCell.addSombra() // por estar dentro de uma closure precisa do self -> viewCell lá de cima
        }
    }
}
