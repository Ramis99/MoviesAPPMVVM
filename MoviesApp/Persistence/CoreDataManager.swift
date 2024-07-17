//
//  CoreDataManager.swift
//  MoviesApp
//
//  Created by Ramiro Gutierrez on 14/07/24.
//

import Foundation
import CoreData


class CoreDataManager {
    
    static let coreManager = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MoviesApp")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func updateShow(show: ShowsModel, entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: "idShow = %ld", show.idShow!)

        do {
            if let result = try context.fetch(fetchRequest).first as? NSManagedObject {
                result.setValue(show.isFavorite, forKey: "isFavorite")
                try context.save()
                print("Se actualizo el show")
            }
        } catch {
            print("Failed to update show: \(error)")
        }
    }
    
    func addShows(shows: [ShowsModel], entity: String) {
        let entity = NSEntityDescription.entity(forEntityName: entity, in: context)
        
            for show in shows {
                let newShow = NSManagedObject(entity: entity!, insertInto: context)
                newShow.setValue(show.idShow, forKey: "idShow")
                newShow.setValue(show.name, forKey: "name")
                newShow.setValue(show.external?.imdb, forKey: "external")
                newShow.setValue(show.genres?.joined(separator: ", "), forKey: "genres")
                newShow.setValue(show.imageUrl?.imageMedium, forKey: "imageUrl")
                newShow.setValue(show.isFavorite, forKey: "isFavorite")
                newShow.setValue(show.language, forKey: "language")
                newShow.setValue(show.summary, forKey: "summary")
                newShow.setValue(show.rating?.average, forKey: "rating")
                newShow.setValue(show.premiered, forKey: "premiered")
                newShow.setValue(show.url, forKey: "url")

            }
        
        do {
            try context.save()
            print("Información guardada correctamente")
        } catch {
            print("Hubo un error al guardar la información")
        }
    }
    
    func getShows(entity: String) -> [ShowsModel] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            var model: [ShowsModel] = []
            for data in  result as! [NSManagedObject] {
                let idShow = data.value(forKey: "idShow") as? Int
                let name = data.value(forKey: "name") as? String
                let imageUrl = data.value(forKey: "imageUrl") as? String
                let summary = data.value(forKey: "summary") as? String
                let language = data.value(forKey: "language") as? String
                let genres = data.value(forKey: "genres") as? [String]
                let rating = data.value(forKey: "rating") as? Double
                let premiered = data.value(forKey: "premiered") as? String
                let isFavorite = data.value(forKey: "isFavorite") as? Bool
                let external = data.value(forKey: "external") as? String
                let url = data.value(forKey: "url") as? String

                
                let showModel = ShowsModel(idShow: idShow, name: name, imageUrl: ShowsModel.ImageShows(imageMedium: imageUrl), summary: summary, language: language, genres: genres, rating: ShowsModel.Rating(average: rating), external: ShowsModel.External(imdb: external), premiered: premiered, isFavorite: isFavorite, url: url)
                model.append(showModel)
            }
            print("se obtuvo correctamente la informacion")
            return model
        } catch {
           return []
        }
    }
    
    func deleteShows(entity: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TvShows")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("se borro correctamente la informacion")
        } catch (let error) {
            print("Error al borrar la información", error)
        }
    }
    
}
