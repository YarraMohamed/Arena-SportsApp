//
//  FavouriteService.swift
//  Arena
//
//  Created by Yara Mohamed on 19/05/2025.
//

import Foundation
import UIKit
import CoreData

class FavouriteService : FavouriteServiceProtocol {

     var context : NSManagedObjectContext!
     var entity : NSEntityDescription!
    
    static let shared = FavouriteService()
    private init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
        self.entity = NSEntityDescription.entity(forEntityName: "FavouriteLeagues", in: context)!
    }
    
    func getFavourites(completion: @escaping ([Favourites]?, (any Error)?) -> Void) {
        let req = NSFetchRequest<NSManagedObject>(entityName: "FavouriteLeagues")
        
        do{
            let fetchedFav = try context.fetch(req)
            let favourites = fetchedFav.compactMap { object -> Favourites? in
                guard let title = object.value(forKey: "title") as? String,
                      let img = object.value(forKey: "img") as? String,
                      let id = object.value(forKey: "id") as? Int,
                     let map = object.value(forKey: "map") as? Int else {
                    return nil
                }
                return Favourites(map:map, id:id, title: title, img: img)
            }
            completion(favourites,nil)
        }catch{
            completion(nil, error)
        }
    }
    
    func addFavourite(fav: Favourites) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteLeagues")
        fetchRequest.predicate = NSPredicate(format: "id == %d and map == %d", fav.id,fav.map)

        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                let favourite = NSManagedObject(entity: entity, insertInto: context)
                favourite.setValue(fav.title, forKey: "title")
                favourite.setValue(fav.img, forKey: "img")
                favourite.setValue(fav.id, forKey: "id")
                favourite.setValue(fav.map, forKey: "map")
                try context.save()
            } else {
                print("Favourite with id \(fav.id) already exists.")
            }
        } catch let error {
            print("Failed to fetch or save: \(error.localizedDescription)")
        }
    }

    
    func removeFavourite(id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteLeagues")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        do {
            if let fav = try context.fetch(fetchRequest).first as? NSManagedObject {
                context.delete(fav)
                try context.save()
                print("Deleted favourite with id: \(id)")
            } else {
                print("No favourite found with id: \(id)")
            }
        } catch let error {
            print("Failed to remove favourite: \(error.localizedDescription)")
        }
    }

}
