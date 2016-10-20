//
//  RequestProtocol.swift
//  PlayArray
//
//  Created by Louis de Beaumont on 15/10/2016.
//  Copyright © 2016 PlayArray. All rights reserved.
//

import Foundation

/// The public protocol which lists available API calls to be used by PlayArray
public protocol RequestProtocol {
    // criteria: Data will probably change to a custom class in future
    func getPlaylist(from time: TimeOfDay, completion: @escaping ([Song], NSError?) -> Void)
    func getPlaylist(from weather: Weather, completion: @escaping ([Song], NSError?) -> Void)
    
    func getWeather(_ lat: Double, lon: Double, completion: @escaping (String, NSError?) -> Void)
}