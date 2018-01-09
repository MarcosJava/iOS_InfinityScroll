//
//  ViewController.swift
//  InfinityScrollTest
//
//  Created by Marcos Felipe Souza Pinto on 09/01/2018.
//  Copyright © 2018 Marcos Felipe Souza Pinto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var datas:[Date] = {
        let dateInit = Date().dateFromDays(-10)
        let dateEnd = Date().dateFromDays(10)
        return self.generateDays(dateInit, endDate: dateEnd)
    }()
    
    let totalDatas:Int = 5
    let identifier = "cell"
    let dateFormatter = DateFormatter()
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dateFormatter.dateFormat = "dd-MM-yyyy"
        configSpinner()
    }
    
    func configSpinner(){
        self.spinner.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 44)
        self.spinner.hidesWhenStopped = true
        self.tableView.tableFooterView = spinner;
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
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = dateFormatter.string(from: self.datas[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath){
        print(indexPath.row)
        
        if indexPath.row < 10 || (indexPath.row + 1) == self.datas.count {
            spinner.startAnimating()
            
            Timer.scheduledTimer(withTimeInterval: 10, repeats: false, block: { (time) in
                self.spinner.stopAnimating()
                
                //Add more dates to the bottom
                print("Add more dates to the bottom")
                let lastDate = self.datas.last!
                let additionalDays = self.generateDays(
                    lastDate.dateFromDays(1),
                    endDate: lastDate.dateFromDays(self.totalDatas)
                )
                self.datas.append(contentsOf: additionalDays)
                
                // Update the tableView
                print("Update the tableView")
                self.tableView.reloadData()
            })
        }
    }
    
}
