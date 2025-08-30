//
//  WebService.swift
//  CryptoAppSwiftUI
//
//  Created by Zeliha İnan on 30.08.2025.
//

import Foundation

func downloadCurrencies(url : URL, completion: @escaping (Result<[CryptoCurrency]?, DownloaderError>) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(.invalidURL))
        }
        
        guard let data = data, error == nil else {
            return completion(.failure(.noData))
        }
        
        guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else {
            return completion(.failure(.decodingFailed))
        }
        
        completion(.success(currencies))
    }.resume()
}

enum DownloaderError : Error {
    case invalidURL
    case noData
    case decodingFailed
}
