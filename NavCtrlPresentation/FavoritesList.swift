//
//  FavoritesList.swift
//  NavCtrlPresentation
//
//  Created by Aaron Kaplowitz on 10/14/16.
//  Copyright © 2016 Aaron Kaplowitz. All rights reserved.
//

import Foundation
import UIKit

class FavoritesList {
    // singleton constructor
    // has ability to add fonts to favs to show at top, so never want more than one instance of list
    static let sharedFavoritesList = FavoritesList()
    // make variable readonly outside of this class
    private(set) var favorites:[String]
    
    init() {
        // pull saved prefs
        let defaults = NSUserDefaults.standardUserDefaults()
        let storedFavorites = defaults.objectForKey("favorites") as? [String]
        // if theres any favs we retrieved, use them, otherwise dont
        favorites = storedFavorites != nil ? storedFavorites! : []
    }
    func addFavorite(fontName: String) {
        if !favorites.contains(fontName) {
            favorites.append(fontName)
            saveFavorites()
        }
    }
    func removeFavorite(fontName: String) {
        if let index = favorites.indexOf(fontName) {
            favorites.removeAtIndex(index)
            saveFavorites()
        }
    }
    
    private func saveFavorites() {
        // load the defaults (aka favorites in this case)
        let defaults = NSUserDefaults.standardUserDefaults()
        // we've updated the list of favorites, save them
        defaults.setObject(favorites, forKey: "favorites")
        // actually save the favorites
        defaults.synchronize()
    }
}