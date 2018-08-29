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
    
    let imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Table?.dataSource = self;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadImage(withURL url: URL, forCell cell: UITableViewCell) {
        guard var myCell = cell as? ViewWithUrlAndImageProtocol else {
            return
        }
        
        myCell.imageURL = url;
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            myCell.myImage?.image = cachedImage
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let contentsOfURL = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if url != myCell.imageURL {
                    return
                }
                
                if let imageData = contentsOfURL {
                    let image = UIImage(data: imageData)
                    self.imageCache.setObject(image!, forKey: url.absoluteString as NSString)
                    myCell.myImage?.image = image
                }
                
            }
        }
    }
    
    func prepareImageUrl(forIndex index: Int) -> URL {
        return URL(string: "http://placehold.it/375x150?text=\(index)")!
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        if let mycell = cell as? MyCell {
            let imageUrl = prepareImageUrl(forIndex: indexPath.row)
            downloadImage(withURL: imageUrl, forCell: cell)
        }
        return cell
    }
}
