//
//  LocationStatus.swift
//  Domain
//
//  Created by gnksbm on 4/2/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Foundation
import CoreLocation

public enum LocationStatus {
    case notDetermined, error
    case denied
    case authorized(CLLocation), alwaysAllowed(CLLocation)
}
