//
//  ViewWithUrlAndImageProtocol.swift
//  Test1
//
//  Created by Шишов Дмитрий (Shishov_DR) on 29.08.2018.
//  Copyright © 2018 Шишов Дмитрий (Shishov_DR). All rights reserved.
//

import Foundation
import UIKit

protocol ViewWithUrlAndImageProtocol {
    var myImage: UIImageView! { get }
    var imageURL: URL? { get set }
    
}
