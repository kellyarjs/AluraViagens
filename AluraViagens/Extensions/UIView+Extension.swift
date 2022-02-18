//
//  UIView+Extension.swift
//  alura-viagens
//
//  Created by Ândriu Felipe Coelho on 30/05/21.
//

import UIKit

extension UIView { // método que auxilia na adição de sombra
    func addSombra() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.cornerRadius = 10
    }
}
