//
//  Roles.swift
//  LMS
//
//  Created by PHN Tech 2 on 29/02/24.
//

import UIKit

var role: Roles = .student

enum Roles : String, Codable{
    case student = "Student"
    case trainer = "Trainer"
    case principal = "Principal"
    case manager = "Manager"
    
    func getViewController() -> UIViewController? {
        
        let viewController: UIViewController? = {
            switch self{
            case .student:
                return AppStoryboard.student.viewController(viewControllerClass: ViewController.self)
            case .manager:
                return AppStoryboard.manager.viewController(viewControllerClass: ViewController.self)
            case .trainer:
                return AppStoryboard.trainer.viewController(viewControllerClass: ViewController.self)
            case .principal:
                return AppStoryboard.principal.viewController(viewControllerClass: ViewController.self)
            }
        }()
       return viewController
    }
}


