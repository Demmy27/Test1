//
// Created by Dmitry Shishov on 29.08.2018.
// Copyright (c) 2018 Шишов Дмитрий (Shishov_DR). All rights reserved.
//

import Foundation
import UIKit

class ImageService {

    let imageCache = NSCache<NSString, UIImage>()

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

