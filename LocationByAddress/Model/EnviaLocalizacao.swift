//
//  EnviaLocalizacao.swift
//  LocationByAddress
//
//  Created by Rafael  Hieda on 2/12/18.
//  Copyright © 2018 Rafael Hieda. All rights reserved.
//

import UIKit

protocol EnviaLocalizacaoDelegate {
    func enviaLocalizacao(_ localizacao:Localizacao)
}

class EnviaLocalizacao: NSObject {
    var delegate : EnviaLocalizacaoDelegate?
    
    func EnviaLoc(_ localizacao:Localizacao) {
        delegate?.enviaLocalizacao(localizacao)
    }
    
}
