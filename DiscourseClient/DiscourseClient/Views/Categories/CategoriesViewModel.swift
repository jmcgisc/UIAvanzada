//
//  CategoriesViewModel.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 20/3/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//


import Foundation


protocol CategoriesCoordinatorDelegate  {
    
}


protocol CategoriesViewDelegate  {
    func categoriesFetched()
    func errorFetchingCategories()
}

/// ViewModel representando un listado de categorías
class CategoriesViewModel {
    var coordinatorDelegate: CategoriesCoordinatorDelegate?
    var viewDelegate: CategoriesViewDelegate?
    let categoriesDataManager: CategoriesDataManager
    var categoriesViewModels: [CategoryCellViewModel] = []
    
    init(categoriesDataManager: CategoriesDataManager) {
        self.categoriesDataManager = categoriesDataManager
    }
    
    func viewWasLoaded() {
        fetchCategories()
    }
    
    private func fetchCategories() {
        categoriesDataManager.fetchAllCategories { [weak self] result in
            guard let self = self else { return}
            
            switch result {
            case .success(let categoriesResp):
                guard let categories = categoriesResp?.categories else { return }
                self.categoriesViewModels = categories.map { CategoryCellViewModel(category: $0) }
                
                self.viewDelegate?.categoriesFetched()
                
            case .failure(_):
                self.viewDelegate?.errorFetchingCategories()
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return categoriesViewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> CategoryCellViewModel? {
        guard indexPath.row < categoriesViewModels.count else { return nil }
        return categoriesViewModels[indexPath.row]
    }
}
