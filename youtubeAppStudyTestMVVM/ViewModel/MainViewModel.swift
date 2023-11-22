//
//  MainViewModel.swift
//  youtubeAppStudyTestMVVM
//
//  Created by MacOS on 22.11.2023.
//

import Foundation

class MainViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource : Observable<[Movie]> = Observable(nil)
    var dataSource: TrendingMovieModel?
    
    func numberOfSections() -> Int {
        1
    }
    
    func numbersOfRows(in section: Int) -> Int {
        self.dataSource?.results.count ?? 0
    }
    
    func getData() {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        APICaller.getTrendingMovies { [weak self] result in
            self?.isLoading.value = false
            
            switch result {
            case .success(let data):
                self?.dataSource = data
                self?.mapCellData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func mapCellData() {
        self.cellDataSource.value = self.dataSource?.results ?? []
    }
    
    func getMovieTitle(_ movie: Movie) -> String {
        movie.title ?? movie.name ?? ""
    }
}
