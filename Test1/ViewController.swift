//
//  ViewController.swift
//  Test1
//
//  Created by Шишов Дмитрий (Shishov_DR) on 29.08.2018.
//  Copyright © 2018 Шишов Дмитрий (Shishov_DR). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Table: UITableView!
    let imageService = ImageService()

    override func viewDidLoad() {
        super.viewDidLoad()
        Table?.dataSource = self;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        if cell is MyCell {
            let imageUrl = imageService.prepareImageUrl(forIndex: indexPath.row)
            imageService.downloadImage(withURL: imageUrl, forCell: cell)
        }
        return cell
    }
}
