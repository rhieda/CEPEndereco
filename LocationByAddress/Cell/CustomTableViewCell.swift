//
//  CustomTableViewCell.swift
//  LocationByAddress
//
//  Created by Rafael  Hieda on 2/11/18.
//  Copyright © 2018 Rafael Hieda. All rights reserved.
//

import UIKit

enum CellLabel:Int {
    case Endereco = 2
    case Complemento =  3
    case Latitude = 5
    case Longitude = 7
}

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var CellLabels: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        // Configure the view for the selected state
    }
    
    func preencheCelula(_ loc:Localizacao) {
        for tf in CellLabels {
            if(CellLabel.Endereco == CellLabel(rawValue: tf.tag)) {
                tf.text = loc.rua
            }
            else if(CellLabel.Complemento == CellLabel(rawValue: tf.tag)) {
                tf.text = "\(loc.bairro), \(loc.localidade), \(loc.uf)"
            }
            else if(CellLabel.Latitude == CellLabel(rawValue: tf.tag)) {
                tf.text = loc.localizacao?.coordinate.latitude.description
            }
            else if(CellLabel.Longitude == CellLabel(rawValue: tf.tag)) {
                tf.text = loc.localizacao?.coordinate.longitude.description
            }
        }

    }
}
