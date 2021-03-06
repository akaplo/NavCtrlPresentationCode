//
//  FontListTableViewController.swift
//  NavCtrlPresentation
//
//  Created by Sam N on 10/14/16.
//  Copyright © 2016 Aaron Kaplowitz. All rights reserved.
//

import UIKit

class FontListTableViewController: UITableViewController {
    var fontNames: [String] = []
    var showsFavorites:Bool = false
    private var cellPointSize = CGFloat!(nil)
    private static let cellIdentifier = "FontName"
    
    //utility function for causing the font listed in a cell to be displayed with it's own font face
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont {
        let fontName = fontNames[indexPath.row]
        return UIFont(name: fontName, size: cellPointSize)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferedTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize = preferedTableViewFont.pointSize
        tableView.estimatedRowHeight = cellPointSize
    }
    
    //this function will populate fontNames to be listed if the variable showsFavorites is true
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if showsFavorites {
            fontNames = FavoritesList.sharedFavoritesList.favorites
            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontNames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FontListTableViewController.cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
        cell.textLabel?.text = fontNames[indexPath.row]
        cell.detailTextLabel?.text = fontNames[indexPath.row]
        return cell
    }
    
    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //get the new view controller using [segue destinationViewController].
        //pass the selected object to the new view controller
        
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(tableViewCell)!
        let font = fontForDisplay(atIndexPath: indexPath)
        
        if segue.identifier == "ShowFontSizes" {
            let sizesVC = segue.destinationViewController as! FontSizesViewController
            sizesVC.title = font.fontName
            sizesVC.font = font
        }else{ //identifier = "ShowFontInfo"
            let infoVC = segue.destinationViewController as! FontInfoViewController
            infoVC.title = font.fontName
            infoVC.font = font
            infoVC.favorite = FavoritesList.sharedFavoritesList.favorites.contains(font.fontName)
        }
    }

}
