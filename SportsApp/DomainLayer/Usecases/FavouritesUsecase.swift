//
//  FavouritesUsecase.swift
//  Arena
//
//  Created by Yara Mohamed on 19/05/2025.
//

import Foundation

class FavouritesUsecase : FavouritesUsecaseProtocol {
    
    let repo : FavouritesRepositoryProtocol
    init(repo: FavouritesRepositoryProtocol) {
        self.repo = repo
    }
    
    func FetchFavourites(completion: @escaping ([Favourites]?, (Error)?) -> Void) {
        repo.getFavourites { favs, err in
            if let err = err {
                completion(nil,err)
            }
            guard let favs = favs else{
                completion(nil,err)
                return
            }
            completion(favs,nil)
        }
    }
    
    func saveFavourite(fav: Favourites) {
        repo.addFavourite(fav: fav)
    }
    
    func deleteFavourite(id: Int) {
        repo.removeFavourite(id: id)
    }
    
    
}
