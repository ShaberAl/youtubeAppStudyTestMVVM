//
//  MainViewController.swift
//  youtubeAppStudyTestMVVM
//
//  Created by MacOS on 22.11.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: MainViewModel = MainViewModel()
    
    var cellDataSource: [MovieTableCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData()
    }
    
    func configView() {
        self.title = "Top Trending Movies"
        self.view.backgroundColor = .systemBackground
        
        setupTableView()
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let isLoading = isLoading else { return }
            
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] movies in
            guard let self = self, let movies = movies else { return }
            
            self.cellDataSource = movies
            self.reloadTableView()
        }
    }
    
    func openDetails(movieId: Int) {
        guard let movie = viewModel.retriveMovie(with: movieId) else { return }
        
        DispatchQueue.main.async {
            let detailsViewModel = DetailsMovieViewModel(movie: movie)
            let detailsController = DetailsMovieViewController(viewModel: detailsViewModel)
            self.navigationController?.pushViewController(detailsController, animated: true)
        }
    }
}
