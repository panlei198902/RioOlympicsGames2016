//
//  EventsViewController.swift
//  RioOlympicsGames2016
//
//  Created by Derexpan on 2016/11/8.
//  Copyright © 2016年 derex pan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

var colum_count = 2

class EventsViewController: UICollectionViewController {
    
    var events : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            colum_count = 5 //如果是pad，列数是5
        }

        if self.events == nil || self.events.count == 0 {
            let bl = EventsBL()
            let array = bl.readData()
            self.events = array
            self.collectionView?.reloadData()
        }
        print(events.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return self.events.count / colum_count  //如果没有整除要+1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
       return colum_count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EventsViewCell
        
        let index = indexPath.section * colum_count + indexPath.row  //index.section表示的是当前行数索引，index.raw当前列数索引
        // Configure the cell
        
        let event = self.events.object(at: index) as! Events
        cell.imageView.image = UIImage(named: event.EventIcon as! String)
        return cell
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            let indexPaths = self.collectionView?.indexPathsForSelectedItems
//            let indexPath = indexPaths![0]
//            
//            let event = self.events[indexPath.section * colum_count + indexPath.row] as! Events
//            
//            let detailVC = segue.destination as! EventsV
//            
//        }
//    }

}
