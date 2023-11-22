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
        "07f2c0c059417d20e9c24cbf356a9466"
    }
    
    public var serverAddress: String {
        "https://api.themoviedb.org/3/"
    }
    
    public var imageServerAddress: String {
        "https://image.tmdb.org/t/p/w500/"
    }
}
