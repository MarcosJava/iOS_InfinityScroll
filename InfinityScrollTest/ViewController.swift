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
    
    var datas:[NSDate] = []
    let totalDatas:Int = 20
    let identifier = "cell"
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    
    override func viewDidLoad() {
        createDatas()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createDatas(){
        for _ in 0...totalDatas {
            datas.append(NSDate())
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = String.init(describing: datas[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath){

        print(indexPath.row)
        if indexPath.row < 10 {
            spinner.startAnimating()
            spinner.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 44)
            self.tableView.tableFooterView = spinner;
        }
//        if (indexPath.row == self.data.count - 1) {
//            getMoreData() // network request to get more data
//        }
    }
    
}
