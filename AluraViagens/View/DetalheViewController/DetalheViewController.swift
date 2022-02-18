//
//  DetalheViewController.swift
//  AluraViagens
//
//  Created by Kelly Silva Araujo on 07/02/22.
//

import UIKit

class DetalheViewController: UIViewController {
    
    // MARK: - IBOutlets
  
    @IBOutlet weak var viagemImage: UIImageView! //imagem cancun??
    @IBOutlet weak var tituloViagemLabel: UILabel!
    @IBOutlet weak var subtituloViagemLabel: UILabel!
    @IBOutlet weak var diariaViagemLabel: UILabel!
    @IBOutlet weak var precoSemDescontoLabel: UILabel!
    @IBOutlet weak var precoViagemLabel: UILabel!
    
    // MARK: Atributos
    
    var viagem: Viagem?
    
    
    // MARK: View life cycle
    
    class func instanciar(_ viagem: Viagem) -> DetalheViewController {
        let detalhesViewController = DetalheViewController(nibName: String(describing: self), bundle: nil) // o describing pega o nome da classe e converte pra string
        detalhesViewController.viagem = viagem
        
        return detalhesViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraView() // chama o método abaixo

    }
    
    func configuraView() { // método que configura os outlets criados - peguei o código abaixo lá de ViagemTable...
        
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
    }
        
    // MARK: - Actions
    
    @IBAction func botaoVoltar(_ sender: UIButton) {
        navigationController?.popViewController(animated: true) // voltar a view (que já estava instanciada no viewController)
        
    }
    
}
