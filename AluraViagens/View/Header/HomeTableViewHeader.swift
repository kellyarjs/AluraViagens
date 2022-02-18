//
//  HomeTableViewHeader.swift
//  AluraViagens
//
//  Created by Kelly Silva Araujo on 04/02/22.
//

import UIKit

class HomeTableViewHeader: UIView { // classe criada pra controlar o header -> classe setada lá nas propriedades da view

    // MARK: IBOutlets
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var bannerView: UIView!
    
    func configuraView() { // método que seta uma cor de fundo pro header
        headerView.backgroundColor = UIColor(red: 30.0/255.0, green: 59.0/255.0, blue: 119.0/255.0, alpha: 1)
        
        bannerView.layer.cornerRadius = 10 // arredondar view
        bannerView.layer.masksToBounds = true // máscara de corte pra view ficar arredondada
        
        headerView.layer.cornerRadius = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 500 : 200 // verificação pra saber se é iphone (500) ou ipad (200)
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] // arredonda a parte inferior do header
    }
}
