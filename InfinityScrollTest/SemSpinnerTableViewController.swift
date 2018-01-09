//
//  SemSpinnerTableViewController.swift
//  InfinityScrollTest
//
//  Created by Marcos Felipe Souza Pinto on 09/01/2018.
//  Copyright © 2018 Marcos Felipe Souza Pinto. All rights reserved.
//

import UIKit

class SemSpinnerTableViewController: UITableViewController {

    let totalDatas:Int = 15
    let cellBuffer: CGFloat = 2
    let identifier = "cell"
    let cellHeight:CGFloat = 44
    
    
    let dateFormatter = DateFormatter()
    
    lazy var days: [Date] = {
        let beginDate = Date().dateFromDays(-29)
        let endDate = Date().dateFromDays(30)
        return self.generateDays(beginDate, endDate: endDate)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.dateFormatter.dateFormat = "dd/MM/yyyy"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func generateDays(_ beginDate: Date, endDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = beginDate
        
        while date.compare(endDate) != .orderedDescending {
            dates.append(date)
            date = date.dateFromDays(1)
        }
        return dates
    }
    
    
    func createDatas(){
        for _ in 0...totalDatas {
            self.days.append(NSDate() as Date)
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = self.dateFormatter.string(from: days[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath){
        
        print(indexPath.row)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        let bottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        let buffer: CGFloat = self.cellBuffer * self.cellHeight
        let scrollPosition = scrollView.contentOffset.y
        
        // Reached the bottom of the list
        if scrollPosition > bottom - buffer {
            // Add more dates to the bottom
            print("Add more dates to the bottom")
            let lastDate = self.days.last!
            let additionalDays = self.generateDays(
                lastDate.dateFromDays(1),
                endDate: lastDate.dateFromDays(self.totalDatas)
            )
            self.days.append(contentsOf: additionalDays)
            
            // Update the tableView
            print("Update the tableView")
            self.tableView.reloadData()
        }
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
