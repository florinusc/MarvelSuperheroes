//
//  SessionManager.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 18.05.2022.
//

import Alamofire

class SessionManager {
    
    func request<T: Decodable>(type _: T.Type, requestType: Request, completion handler: @escaping (Result<T, Error>) -> Void) {
        guard let url = requestType.url else {
            handler(.failure(CustomError.network))
            return
        }
        AF.request(url)
          .validate()
          .responseDecodable(of: T.self) { (response) in
            guard let object = response.value else {
                handler(.failure(CustomError.network))
                return
            }
            handler(.success(object))
        }
    }
    
}
