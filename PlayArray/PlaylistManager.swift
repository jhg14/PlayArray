//
//  PlaylistManager.swift
//  PlayArray
//
//  Created by Louis de Beaumont on 21/10/2016.
//  Copyright © 2016 PlayArray. All rights reserved.
//

import Foundation
import RequestManager
import SwiftyJSON

class PlaylistManager {
    /// Request is PlaylistManager's reference to the RequestManager, used to create calls to the API
    private static var Request: RequestProtocol = RequestManager.sharedInstance

    /**
        Requests a playlist from the server which fits the given categories
     
        - Parameters: 
            - categories: List of categories defining the playlist creation criteria
            - completion: The completion handler which returns the playlist from the server when received
     */
    static func getPlaylist(from categories: [Category], completion: @escaping (Playlist, NSError?) -> Void) {
        let dictionary = getDictionary(from: categories)
        Request.getPlaylist(from: dictionary) { (json, error) in
            let playlist = parsePlaylist(from: json)
            completion(playlist, nil)
        }
    }
    
    /**
        Creates and returns a dictionary of keys to values used to send to the server
     
        - Parameters:
            - categories: The categories to be turned into String values
        - Returns:
            A dictionary of [api_category_key, category_value]
     */
    static private func getDictionary(from categories: [Category]) -> [(String, String)] {
        var dictionary: [(String, String)] = []
        
        categories.forEach { category in
            let id = category.getIdentifier()
            let criteria: [String] = category.getCriteria()
            criteria.forEach({ c in
                dictionary.append((id, c))
            })
        }
        
        return dictionary
    }
    
    /**
        Passes feedback for a song to the server to update the servers categorisation of songs
     
        - Parameters:
            - songId: Database ID of the song
            - categories: Suggested categories for the song
            - completion: Returns possible error when request has completed on server     
     */
    static func giveFeedback(for songId: String, with categories: [Category], completion: @escaping (NSError?) -> Void) {
        
    }
    
    /**
        Parses the servers JSON into a Playlist
     
        - Parameters:
            - json: The JSON (from the server) containing information about the playlist
        - Returns:
            The Playlist object containing the server's passed playlist
     */
    static func parsePlaylist(from json: JSON) -> Playlist {
        var songs_: [Song] = []
        let songs = json["songs"].arrayValue
        
        songs.forEach { songJSON in
            let id = songJSON["_id"].stringValue
            let title = songJSON["title"].stringValue
            let artist = songJSON["artist"].stringValue
            let album = songJSON["album"].stringValue
            songs_.append(Song(id: id, title: title, artist: artist, album: album))
        }
        
        return Playlist(name: "Test Playlist Name", songs: songs_)
    }
}
