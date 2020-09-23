//
//  AlertManager.swift
//  TextRecognitionWithVision
//
//  Created by Paula Leite on 23/09/20.
//

import UIKit

internal class AlertManager {

    /**
     An action sheet alert with title messages is created.
     - Parameter viewController: the UIViewController that will be used.
     - Parameter title: the title in the alert.
     - Parameter message: the message in the alert.
     - Parameter action: which actions will be taken.
     */
    class func createMultipleActionsAlert(on viewController: UIViewController, title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        for i in 0..<actions.count {
            alert.addAction(actions[i])
        }

        let dismissAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(dismissAction)
        viewController.present(alert, animated: true, completion: nil)

    }

}

