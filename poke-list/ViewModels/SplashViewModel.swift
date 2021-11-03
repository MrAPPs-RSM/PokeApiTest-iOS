//
//  SplashViewModel.swift
//  poke-list
//
//  Created by Nicola Innocenti on 31/10/21.
//

import UIKit

class SplashViewModel: NSObject {
    private var apiService: ApiService!
    private var dataService: DataService!
    private var types: [JSON] = []
    private var stats: [JSON] = []
    private var pokemons: [JSON] = []
    private(set) var setupCompletion: (Bool, String?)? {
        didSet {
            self.onSetupComplete(setupCompletion?.0 == true, setupCompletion?.1)
        }
    }
    var onProgress: ProgressCompletion = { _, _ in }
    var onSetupComplete: StringCompletion = { _, _ in }
    
    override init() {
        super.init()
        setup()
    }
    
    private func setup() {
        apiService = ApiService()
        dataService = DataService()
        DispatchQueue.global(qos: .background).async {
            self.getTypes(stringUrl: nil) { success, data, message in
                self.dataService.fetchTypes(data: self.types)
                self.getStats(stringUrl: nil) { success2, data2, message2 in
                    self.dataService.fetchStats(data: self.stats)
                    self.getPokemons(stringUrl: nil) { success3, data3, message3 in
                        self.dataService.fetchPokemons(data: self.pokemons)
                        DispatchQueue.main.async {
                            UIApplication.shared.lastSync = Date().timeIntervalSince1970
                            self.setupCompletion = (success2, message2)
                        }
                    }
                }
            }
        }
    }
    
    private func updateProgress(type: String, index: Int, count: Int) {
        let percentage = Float(index) / Float(count)
        DispatchQueue.main.async {
            self.onProgress(
                "\("downloading".localized) \(type.lowercased())\n \(index+1)/\(count)",
                percentage
            )
        }
    }
    
    // MARK: - Get Types
    
    func getTypes(stringUrl: String?, completion: @escaping ResultsCompletion) {
        apiService.getTypeList(stringUrl: stringUrl) { success, data, message in
            if success, let data = data {
                self.getMultiTypeDetails(response: data, list: data.results) { success2, message2 in
                    if success2 {
                        if let next = data.next {
                            self.getTypes(stringUrl: next, completion: completion)
                        } else {
                            completion(true, data, nil)
                        }
                    } else {
                        completion(false, nil, nil)
                    }
                }
            } else {
                completion(false, nil, nil)
            }
        }
    }
    
    private func getMultiTypeDetails(response: ApiListResult, list: [ApiListResultItem], completion: @escaping StringCompletion) {
        var copy = list
        if let resultItem = copy.popLast() {
            self.updateProgress(type: "types".localized, index: self.types.count, count: response.count)
            apiService.getItemDetail(stringUrl: resultItem.url) { success, data, message in
                if success, let data = data {
                    self.types.append(data)
                    self.getMultiTypeDetails(response: response, list: copy, completion: completion)
                } else {
                    completion(false, nil)
                }
            }
        } else {
            completion(true, nil)
        }
    }
    
    // MARK: - Get Stats
    
    func getStats(stringUrl: String?, completion: @escaping ResultsCompletion) {
        apiService.getStatList(stringUrl: stringUrl) { success, data, message in
            if success, let data = data {
                self.getMultiStatDetails(response: data, list: data.results) { success2, message2 in
                    if success2 {
                        if let next = data.next {
                            self.getStats(stringUrl: next, completion: completion)
                        } else {
                            completion(true, data, nil)
                        }
                    } else {
                        completion(false, nil, nil)
                    }
                }
            } else {
                completion(false, nil, nil)
            }
        }
    }
    
    private func getMultiStatDetails(response: ApiListResult, list: [ApiListResultItem], completion: @escaping StringCompletion) {
        var copy = list
        if let resultItem = copy.popLast() {
            self.updateProgress(type: "stats".localized, index: self.stats.count, count: response.count)
            apiService.getItemDetail(stringUrl: resultItem.url) { success, data, message in
                if success, let data = data {
                    self.stats.append(data)
                    self.getMultiStatDetails(response: response, list: copy, completion: completion)
                } else {
                    completion(false, nil)
                }
            }
        } else {
            completion(true, nil)
        }
    }
    
    // MARK: - Get Pokemons
    
    func getPokemons(stringUrl: String?, completion: @escaping ResultsCompletion) {
        apiService.getPokemonList(stringUrl: stringUrl) { success, data, message in
            if success, let data = data {
                self.getMultiPokemonDetails(response: data, list: data.results) { success2, message2 in
                    if success2 {
                        if let next = data.next {
                            self.getPokemons(stringUrl: next, completion: completion)
                        } else {
                            completion(true, data, nil)
                        }
                    } else {
                        completion(false, nil, nil)
                    }
                }
            } else {
                completion(false, nil, nil)
            }
        }
    }
    
    private func getMultiPokemonDetails(response: ApiListResult, list: [ApiListResultItem], completion: @escaping StringCompletion) {
        var copy = list
        if let resultItem = copy.popLast() {
            self.updateProgress(type: "pokemons".localized, index: self.pokemons.count, count: response.count)
            apiService.getItemDetail(stringUrl: resultItem.url) { success, data, message in
                if success, let data = data {
                    self.pokemons.append(data)
                    self.getMultiPokemonDetails(response: response, list: copy, completion: completion)
                } else {
                    completion(false, nil)
                }
            }
        } else {
            completion(true, nil)
        }
    }
}
