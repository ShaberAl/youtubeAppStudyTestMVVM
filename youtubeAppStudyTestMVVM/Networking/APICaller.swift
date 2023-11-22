//
//  APICaller.swift
//  youtubeAppStudyTestMVVM
//
//  Created by MacOS on 22.11.2023.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case cannotParseData
}

public class APICaller {
    
    static func getTrendingMovies(completion: @escaping (_ result: Result<TrendingMovieModel, NetworkError>) -> Void) {
        if NetworkConstant.shared.apiKey.isEmpty {
            print("<!> API KEY is Missing <!>")
            print("<!> Get One from: https://www.themoviedb.org/ <!>")
            return
        }
        
        let urlString = NetworkConstant.shared.serverAddress + "/trending/all/day?api_key=" + NetworkConstant.shared.apiKey
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil, let data = data, let resultData = try? JSONDecoder().decode(TrendingMovieModel.self, from: data) {
                completion(.success(resultData))
            } else {
                completion(.failure(.cannotParseData))
            }
        }.resume()
    }
}
