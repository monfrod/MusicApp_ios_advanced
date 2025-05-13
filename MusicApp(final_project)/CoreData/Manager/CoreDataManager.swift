//
//  CoreDataManager.swift
//  MusicApp(final_project)
//
//  Created by yunus on 13.05.2025.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    var context: NSManagedObjectContext { container.viewContext }
    var models = [DownloadTracks]()
    
    private init() {
        container = NSPersistentContainer(name: "MusicApp_final_project_")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    public func createNewTrack(title: String, artists: String, songData: Data, image: Data){
        let newTrack = DownloadTracks(context: context)
        newTrack.title = title
        newTrack.artists = artists
        newTrack.songData = songData
        newTrack.image = image
        
        do {
            try context.save()
            getAllTracks()
        } catch{
            print(error)
        }
    }
    
    public func getAllTracks(){
        let fetchingContact = DownloadTracks.fetchRequest()
        do {
            models = try context.fetch(fetchingContact)
        } catch{
         print(error)
        }
    }
    
    public func deleteTrack(track: DownloadTracks){
        context.delete(track)
        
        do{
            try context.save()
        } catch {
            print("Error delete item")
        }
    }
    
    public func updateTrack(updatedTrack: DownloadTracks, newTitle: String, newArtists: String, newSongData: Data, newImage: Data){
        updatedTrack.title = newTitle
        updatedTrack.artists = newArtists
        updatedTrack.songData = newSongData
        updatedTrack.image = newImage
        
        do{
            try context.save()
            getAllTracks()
        } catch {
            print("Error update contact")
        }
    }
}
