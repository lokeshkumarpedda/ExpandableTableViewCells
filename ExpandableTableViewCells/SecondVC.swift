//
//  SecondVC.swift
//  ExpandableTableViewCells
//
//  Created by Next on 06/01/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit

class SecondVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var parentArray = ["First", "Second", "Third","Fourth","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]
    let childArray = ["1","2"]
    var headerCells = [true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true]
    var isExpandedCells = [false, false, false, false,false, false, false, false,false, false, false, false,false, false, false, false,false, false, false, false]
    var headerArray = ["First", "Second", "Third","Fourth","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"] // For original parent Array reference
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collapse() {
        for i in 0 ..< isExpandedCells.count{
            
            // checking for already expanded cell for collapsing
            if isExpandedCells[i]{
                
                // from the header array reference getting the cell index from parent array
                if let index = parentArray.index(of: headerArray[i]){
                    let indexPath = NSIndexPath.init(row: index, section: 0)
                    deletetingRows(indexPath : indexPath)
                }
            }
        }
    }
    
    // deleteing rows based on the sub array count
    func deletetingRows(indexPath : NSIndexPath) {
        tableView.beginUpdates()
        for i in 1 ... childArray.count {
            parentArray.remove(at: indexPath.row+1)
            headerCells.remove(at: indexPath.row+1)
            tableView.deleteRows(at: [NSIndexPath.init(row: indexPath.row+i, section: 0) as IndexPath], with: .fade)
        }
        tableView.endUpdates()
        headerCells[indexPath.row] = true
        let value = parentArray[indexPath.row]
        if let index = headerArray.index(of: value){
            isExpandedCells[index] = false
        }
    }
    
    //
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return parentArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if headerCells[indexPath.row]{
            cell?.textLabel?.text = parentArray[indexPath.row]
            cell?.textLabel?.textColor = UIColor.red
            cell?.isUserInteractionEnabled = true
        }
        else{
            cell?.textLabel?.text = parentArray[indexPath.row]
            cell?.textLabel?.textColor = UIColor.blue
            cell?.isUserInteractionEnabled = false
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (headerCells[indexPath.row]){
            // Expanding the clicked cell
            tableView.beginUpdates()
            for i in 1 ... childArray.count {
                self.parentArray.insert(childArray[i-1], at: indexPath.row+i)
                headerCells.insert(false, at: indexPath.row+i)
                tableView.insertRows(at: [NSIndexPath.init(row: indexPath.row+i, section: 0) as IndexPath], with: .top)
            }
            tableView.endUpdates()
            headerCells[indexPath.row] = false
            let value = parentArray[indexPath.row]
            
            collapse() // collapsing already expanded cells
            
            if let index = headerArray.index(of: value){
                isExpandedCells[index] = true
            }
        }
        else{
            // if clicked on already expanded cell
            deletetingRows(indexPath : indexPath as NSIndexPath)
        }
    }


}
