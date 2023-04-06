//
//  BeerAPI.swift
//  BeerList-MVC
//
//  Created by Vladyslav Nhuien on 06.04.2023.
//

import Foundation

protocol NetworkingService {
    func getBeerList(page: Int, completion: @escaping ([Beer]) -> ())
    func searchBeer(id: Int, completion: @escaping ([Beer]) -> ())
    func getRandomBeer(completion: @escaping ([Beer]) -> ())
}

final class NetworkingAPI: NetworkingService {
    let session = URLSession.shared
    
    func getBeerList(page: Int, completion: @escaping ([Beer]) -> ()) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?per_page=25&page=\(page)") else { return }
        let task = session.dataTask(with: URLRequest(url: url)) { (data, _, _) in
                guard let data = data,
                      let response = try? JSONDecoder().decode([Beer].self, from: data) else {
                    completion([])
                    return
                }
                completion(response)
            }
        task.resume()
    }
    
    func searchBeer(id: Int, completion: @escaping ([Beer]) -> ()) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?ids=\(id)") else { return }
        let task = session.dataTask(with: URLRequest(url: url)) { (data, _, _) in
            guard let data = data,
                  let response = try? JSONDecoder().decode([Beer].self, from: data) else {
                completion([])
                return
            }
            completion(response)
        }
        task.resume()
    }
    
    func getRandomBeer(completion: @escaping ([Beer]) -> ()) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers/random") else { return }
        let task = session.dataTask(with: URLRequest(url: url)) { (data, _, _) in
            guard let data = data,
                  let response = try? JSONDecoder().decode([Beer].self, from: data) else {
                completion([])
                return
            }
            completion(response)
        }
        task.resume()
    }
}
