//
//  FavouritesProtocols.swift
//  Arena
//
//  Created by Yara Mohamed on 19/05/2025.
//

import Foundation

protocol FavouriteServiceProtocol {
    func getFavourites(completion: @escaping ([Favourites]?, Error?) -> Void)
    func addFavourite(fav:Favourites)
    func removeFavourite(id : Int)
}

protocol FavouritesRepositoryProtocol{
    func getFavourites(completion: @escaping ([Favourites]?, Error?) -> Void)
    func addFavourite(fav : Favourites)
    func removeFavourite(id : Int)
}

protocol FavouritesUsecaseProtocol{
    func FetchFavourites(completion: @escaping ([Favourites]?, Error?) -> Void)
    func saveFavourite(fav : Favourites)
    func deleteFavourite(id : Int)
}
