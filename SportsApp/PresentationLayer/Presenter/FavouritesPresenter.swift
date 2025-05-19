//
//  FavouritesPresenter.swift
//  Arena
//
//  Created by Yara Mohamed on 19/05/2025.
//

import Foundation

class FavouritesPresenter {
    
    weak var favouritesView: FavouritesProtocol?
    let useCase: FavouritesUsecaseProtocol
    
    init(useCase: FavouritesUsecaseProtocol) {
        self.useCase = useCase
    }
    
    func setTableView(_ favouritesView: FavouritesProtocol){
        self.favouritesView = favouritesView
    }
    
    func getFavs(){
        useCase.FetchFavourites { [weak self] res, err in
            if let error = err {
                print("\(error.localizedDescription)")
            }
            
            guard let res = res else {
                self?.favouritesView?.renderFavourites(result: [])
                return
            }
            self?.favouritesView?.renderFavourites(result: res)
        }
    }
    
    func deleteFav(id: Int){
        useCase.deleteFavourite(id: id)
    }
}
