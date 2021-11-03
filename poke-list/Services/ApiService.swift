//
//  ApiService.swift
//  poke-list
//
//  Created by Nicola Innocenti on 31/10/21.
//

import UIKit
import Alamofire



typealias JSON = [String:Any]
typealias ProgressCompletion = (_ message: String?, _ percentage: Float) -> Void
typealias StringCompletion = (_ success: Bool, _ message: String?) -> Void
typealias DataCompletion = (_ success: Bool, _ data: JSON?, _ message: String?) -> Void
typealias DataListCompletion = (_ success: Bool, _ data: [JSON]?, _ message: String?) -> Void
typealias ResultsCompletion = (_ success: Bool, _ data: ApiListResult?, _ message: String?) -> Void

class ApiService: NSObject {
    private let baseUrl = "https://pokeapi.co/api/v2/"
    private var dataService: DataService!
    
    override init() {
        super.init()
        self.dataService = DataService()
    }
    
    func getTypeList(stringUrl: String?, completion: @escaping ResultsCompletion) {
        getListResults(stringUrl: stringUrl, path: ApiEndpoints.type) { success, data, message in
            completion(success, data, message)
        }
    }
    
    func getPokemonList(stringUrl: String?, completion: @escaping ResultsCompletion) {
        getListResults(stringUrl: stringUrl, path: ApiEndpoints.pokemon) { success, data, message in
            completion(success, data, message)
        }
    }
    
    func getStatList(stringUrl: String?, completion: @escaping ResultsCompletion) {
        getListResults(stringUrl: stringUrl, path: ApiEndpoints.stat) { success, data, message in
            completion(success, data, message)
        }
    }

    private func getListResults(stringUrl: String?, path: ApiEndpoints, completion: @escaping ResultsCompletion) {
        let url = stringUrl ?? "\(baseUrl)\(path.rawValue)?offset=0&limit=100"
        request(fullUrl: url, path: nil, params: nil) { success, data, message in
            if success, let data = data, let response = ApiListResult.parse(fromJSON: data) {
                completion(true, response, nil)
            } else {
                completion(success, nil, message)
            }
        }
    }
    
    func getItemDetail(stringUrl: String?, completion: @escaping DataCompletion) {
        request(fullUrl: stringUrl, path: nil, params: nil) { success, data, message in
            if success, let data = data {
                completion(true, data, nil)
            } else {
                completion(success, nil, message)
            }
        }
    }
    
    private func request(fullUrl: String?, path: String?, params: JSON?, completion: @escaping DataCompletion) {
        let stringUrl = fullUrl != nil ? fullUrl! : path != nil ? "\(baseUrl)\(path!)" : ""
        guard let url = URL(string: stringUrl) else {
            completion(false, nil, nil)
            return
        }
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding(), headers: nil, interceptor: nil, requestModifier: nil).validate(statusCode: 200..<400).responseJSON { response in
            
            if let data = response.value as? JSON {
                //print("[ApiService] Response: \(data)")
                completion(true, data, nil)
            } else if let error =  response.error {
                print("[ApiService] Error: \(error.localizedDescription)")
                completion(false, nil, error.localizedDescription)
            } else {
                print("[ApiService] Response: \("network_error".localized ?? "nil")")
                completion(false, nil, "network_error".localized)
            }
        }
    }
}
