//
//  DownloadTracks+CoreDataProperties.swift
//  
//
//  Created by yunus on 13.05.2025.
//
//

import Foundation
import CoreData


extension DownloadTracks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DownloadTracks> {
        return NSFetchRequest<DownloadTracks>(entityName: "DownloadTracks")
    }

    @NSManaged public var title: String?
    @NSManaged public var artists: String?
    @NSManaged public var songData: Data?
    @NSManaged public var image: Data?

}
