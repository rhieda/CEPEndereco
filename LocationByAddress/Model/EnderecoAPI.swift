//
//  EnderecoAPI.swift
//  LocationByAddress
//
//  Created by Rafael  Hieda on 2/6/18.
//  Copyright © 2018 Rafael Hieda. All rights reserved.
//

import UIKit
import Alamofire

class EnderecoAPI: NSObject {
    func EnderecoPorCEP(_ cep:String, sucesso:@escaping (Localizacao) ->Void, erro:@escaping (Error) ->Void) -> Void {
        if cep.count <= 7 {
            return
        }
        Alamofire.request("https://viacep.com.br/ws/\(cep)/json", method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                if let resultado = response.result.value as? Dictionary<String,String> {
                    sucesso(Localizacao(resultado))
                    print(response.result.value)
                }
                break
            case .failure:
                erro(response.error!)
                break
            }
        }
        
    }
}
