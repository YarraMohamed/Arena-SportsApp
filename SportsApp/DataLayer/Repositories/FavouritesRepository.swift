//
//  FavouritesRepository.swift
//  Arena
//
//  Created by Yara Mohamed on 19/05/2025.
//

import Foundation

class FavouritesRepository : FavouritesRepositoryProtocol {
    
    let service : FavouriteServiceProtocol
    init(service: FavouriteServiceProtocol) {
        self.service = service
    }
    
    func getFavourites(completion: @escaping ([Favourites]?, (Error)?) -> Void) {
        service.getFavourites { favs, err in
            if let err = err {
                completion(nil,err)
            }
            guard let favs = favs else {
                completion(nil,err)
                return
            }
            completion(favs,nil)
        }
    }
    
    func addFavourite(fav: Favourites) {
        service.addFavourite(fav: fav)
    }
    
    func removeFavourite(id: Int) {
        service.removeFavourite(id: id)
    }
}
