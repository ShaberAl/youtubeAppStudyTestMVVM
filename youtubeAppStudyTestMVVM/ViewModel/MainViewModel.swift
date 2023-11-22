//
//  MainViewModel.swift
//  youtubeAppStudyTestMVVM
//
//  Created by MacOS on 22.11.2023.
//

import Foundation

class MainViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource : Observable<[MovieTableCellViewModel]> = Observable(nil)
    var dataSource: TrendingMovieModel?
    
    func numberOfSections() -> Int {
        1
    }
    
    func numbersOfRows(in section: Int) -> Int {
        dataSource?.results.count ?? 0
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
        cellDataSource.value = self.dataSource?.results.compactMap({MovieTableCellViewModel(movie: $0)})
    }
    
    func getMovieTitle(_ movie: Movie) -> String {
        movie.title ?? movie.name ?? ""
    }
    
    func retriveMovie(with id: Int) -> Movie? {
        guard let movie = dataSource?.results.first(where: {$0.id == id}) else {
            return nil
        }
        return movie
    }
}
