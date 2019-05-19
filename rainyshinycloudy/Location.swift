//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Amr fawzy on 5/16/19.
//  Copyright © 2019 Amr fawzy. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    
    static var sherdInstance = Location()
    private init() {}
    
    var latitude : Double!
    var longitude : Double!
}
