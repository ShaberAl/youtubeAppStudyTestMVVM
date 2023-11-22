//
//  NetworkConstant.swift
//  youtubeAppStudyTestMVVM
//
//  Created by MacOS on 22.11.2023.
//

import Foundation

class NetworkConstant {
    
    public static var shared: NetworkConstant = NetworkConstant()
    
    private init() {
        
    }
    
    public var apiKey: String {
        // Your API key
        ""
    }
    
    public var serverAddress: String {
        "https://api.themoviedb.org/3/"
    }
    
    public var imageServerAddress: String {
        "https://image.tmdb.org/t/p/w500/"
    }
}
