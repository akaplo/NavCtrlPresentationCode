//
//  RootViewController.swift
//  NavCtrlPresentation
//
//  Created by Aaron Kaplowitz on 10/14/16.
//  Copyright © 2016 Aaron Kaplowitz. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    
    private var familyNames: [String]!
    private var cellPointSize: CGFloat!
    private var favoritesList: FavoritesList!
    private static let familyCell = "FamilyName"
    private static let favoritesCell = "Favorites"

    override func viewDidLoad() {
        super.viewDidLoad()
        // get all the font family names as a sorted string array
        familyNames = (UIFont.familyNames() as [String]).sort()
        // Ask the OS which font we should use in the headline (apparently it's opinionated)
        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        // Get the size (ex 14pt) of the preferred font
        cellPointSize = preferredTableViewFont.pointSize
        // get the favs list and prep for display
        favoritesList = FavoritesList.sharedFavoritesList
        // The font will take up roughly the entire row
        tableView.estimatedRowHeight = cellPointSize

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return favoritesList.favorites.isEmpty ? 1 : 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? familyNames.count : 1
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont? {
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row]
            let fontName = UIFont.fontNamesForFamilyName(familyName).first
            return fontName != nil ? UIFont(name: fontName!, size: cellPointSize) : nil
        } else {
            return nil
        }
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "All Font Families" : "My Favorite Fonts"
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
                // font names list
            let cell = tableView.dequeueReusableCellWithIdentifier(RootViewController.familyCell,
                                                                   forIndexPath: indexPath)
            cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
            cell.textLabel?.text = familyNames[indexPath.row]
            cell.detailTextLabel?.text = familyNames[indexPath.row]
            return cell
        } else {
                // the favorites list
            return tableView.dequeueReusableCellWithIdentifier(RootViewController.favoritesCell,
                                                                   forIndexPath: indexPath)
        }
        

    }
    

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
        let listVC = segue.destinationViewController as! FontListTableViewController
        
        if indexPath.section == 0 {
            //FontNames list
            let familyName = familyNames[indexPath.row]
            listVC.fontNames = (UIFont.fontNamesForFamilyName(familyName) as [String]).sort()
            
        }else{
            //Favorites list
            listVC.fontNames = favoritesList.favorites
            listVC.navigationItem.title = "Favorites"
            listVC.showsFavorites = true
        }
    }
    

}
