//
//  RootRouter.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 19/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import UIKit

final class RootRouter {
    
    func presentAuthorizationScreen() {
        let window = UIApplication.shared.keyWindow!
        let storyboardName = GlobalConstants.Storyboards.authorization
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        window.rootViewController = storyboard.instantiateInitialViewController()
    }
    
}
