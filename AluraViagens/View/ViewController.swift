//
//  ViewController.swift
//  AluraViagens
//
//  Created by Kelly Silva Araujo on 03/02/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viagensTableView: UITableView! //referencia da tableView do storyboard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuraTableView()
        
        view.backgroundColor = UIColor (red: 30.0/255.0, green: 59.0/255.0, blue: 119.0/255.0, alpha: 1) // correção para que a parte de cima não fique com outra cor -> troquei view.back... pra viagensTab...
    }
    
    func configuraTableView() {
        viagensTableView.register(UINib(nibName: "ViagemTableViewCell", bundle: nil), forCellReuseIdentifier: "ViagemTableViewCell") // registrar a célula criada (indicar pra tableView quais células ela vai renderizar) -> esse método construtor nib é utilizado para interface builder e o cellclass para programaticamente -> nibname: nome da classe -> id da célula (altero em propriedades)
        
        viagensTableView.register(UINib(nibName: "OfertaTableViewCell", bundle: nil), forCellReuseIdentifier: "OfertaTableViewCell") // registro de célula pós colocar o identifier dela -> nome da cell -> id da cell
        
        viagensTableView.dataSource = self // tabela do storyboard -> afirma que essa tabela vai implementar o protocolo de datasource -> self: afirma que esse datasource é o próprio controller
        viagensTableView.delegate = self // afirma que a tableView vai implementar o protocolo de delegate nesse arquivo viewController
    }
    
    func irParaDetalhe(_ viagem: Viagem?) { // método para ir para os destaques
        
        if let viagemSelecionada = viagem { // verificar se a viagem abaixo existe
            let detalheController = DetalheViewController.instanciar(viagemSelecionada)
            navigationController?.pushViewController(detalheController, animated: true) // navegação pra próxima tela
        }
            
        
//        let detalheController = DetalheViewController(nibName: "DetalheViewController", bundle: nil) // inicialização do xib
//        detalheController.viagem = viagem (apaguei na aula 5 atv 3 curso 2 layout)
        
       // quando a view está no storyBoard: let detalheController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetalheViewController") // instancia o viewController criado: declaração da constante -> invoca da classe (porque ele tá dentro do main do sb) -> inicializa -> especifica que quero acessar só uma view -> coloca identificador na view em propriedades e seta aqui
    }
}

extension ViewController: UITableViewDataSource { //protocolo pra tableView funcionar
   
    func numberOfSections(in tableView: UITableView) -> Int { // método que indica qual o n. de seções que a tableView tem
        return secaoDeViagens?.count ?? 0 // retorna o n. de elementos que tem dentro dessa lista -> validação por ser opcional -> implementar nova célula abaixo no método cellForRow
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secaoDeViagens?[section].numeroDeLinhas ?? 0  // alterar o n de linhas de acordo com a seção: constante do decodable -> acessada de acordo com a section da tableView -> de acordo com a section, o número de linhas foi acessado -> vai verificar se tem valor, se não tiver, é zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // qual vai ser a célula para a linha 1 etc / preenchimento da linha
        
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        cell.textLabel?.text = "viagem \(indexPath.row)" // setei o título e o número da linha que o método tá passando no momento (essas linhas foram comentadas depois que instanciei a célula criada, pois essa aqui instanciava uma célula genérica)
//        return cell
      
        
        let viewModel = secaoDeViagens?[indexPath.section] // método configuraCell foi chamado aqui -> verificação pra saber qual o tipo (ex: destaques, internacionais ou ofertas) pra conseguir passar a lista certa de acordo com a seção que a tableView vai acessar
        
        switch viewModel?.tipo { // verificação de qual é o tipo da seção que será acessada
        case .destaques: // caso seja "destaques
            
            guard let celulaViagem = tableView.dequeueReusableCell(withIdentifier: "ViagemTableViewCell") as? ViagemTableViewCell else {// o "deque" reutiliza a célula da tableView -> casting -> verificação com guard -> - significa que a célula viagem tableViewCell foi instanciada
            fatalError("error to create ViagemTableViewCell")
            }
            
            celulaViagem.configuraCelula(viewModel?.viagens[indexPath.row])
            return celulaViagem
            
        case .ofertas: // caso seja "ofertas
            
            guard let celulaOferta = tableView.dequeueReusableCell(withIdentifier: "OfertaTableViewCell") as? OfertaTableViewCell else { // nome lá da célula de oferta -> casting
                fatalError("error to create OfertaTableViewCell") // se não conseguir instanciar a célula, dá erro
            }
            
            celulaOferta.delegate = self // significa que o viewController vai implementar o delegate da célula de oferta
            celulaOferta.configuraCelula(viewModel?.viagens) // essa linha não estava aqui na aula 5 atividade 4
           
            return celulaOferta // precisa retornar objeto conctreto, não pode ser opcional
            
        default: // se não cair no anterior
            return UITableViewCell()
        }
    }
}

extension ViewController: UITableViewDelegate { // protocolo pra usar os métodos do header da tableView
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // dispara o método após a seleção do usuário nesse item
       
        let viewModel = secaoDeViagens?[indexPath.section] // atv 3 aula 5 - o index é pra ter acesso ao qual viewModel foi selecionado
        
        switch viewModel?.tipo { // pega a viagem da viewModel de destaques
        case .destaques, .internacionais:
            let viagemSelecionada = viewModel?.viagens[indexPath.row] // pega a viagem selecionada
        irParaDetalhe(viagemSelecionada) // método lá de cima
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        if section == 0 { // estava sendo renderizado um header pra cada seção -> se for a primeira seção, fará: criar o header (abaixo)
            
            let headerView = Bundle.main.loadNibNamed("HomeTableViewHeader", owner: self, options: nil)?.first as? HomeTableViewHeader // bundle traz o diretório dos arquivos - first pega a primeira view que ele encontra - casting pra classe criada
          
            headerView?.configuraView() // chama o método criado na homeTableViewHeader
            
            return headerView // retorna a constante instanciada na linha anterior
        }
        
        return nil // se não for a primeira
       
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { // altura do header
        if section == 0 { // validação pra caso seja a primeira seção
        return 300 // altura que está nas propriedades da view
        }
        return 0 // se não for a primeira seção, retorna 0, pra não ter nenhum espaçamento a mais
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { // configurar altura da tableViewCell
         return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 400 : 475 // return 400 (antes) retorna altura da célula criada -> verificação pra retornar altura iphone vs ipad
    }
}

extension ViewController: OfertaTableViewCellDelegate { // implementa o protocolo
    func didSelectView(_ viagem: Viagem?) {
        irParaDetalhe(viagem) // chama o método de navegação pra tela de detalhe
    }
}
