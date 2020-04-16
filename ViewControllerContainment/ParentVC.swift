//
//  ParentVC.swift
//  ViewControllerContainment
//
//  Created by Russell Archer on 15/04/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

class ParentVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    let childVCIds = ["vc1", "vc2", "vc3"]
    var childVCs = [UIViewController]()
    var childVCIndex = 0
    var currentChildVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let storyboard = storyboard else { return }
        
        // Store refs to our child view controllers in an array
        childVCIds.forEach { childVCId in
            childVCs.append(storyboard.instantiateViewController(identifier: childVCId))
        }
    }
    
    @IBAction func addNextVC(_ sender: Any) {
        if let current = currentChildVC {
            // If we have a current child view controller remove it
            current.willMove(toParent: nil)
            current.view.removeFromSuperview()
            current.removeFromParent()
        }

        currentChildVC = childVCs[childVCIndex]  // Get he next child view controller
        
        addChild(currentChildVC!)  // Add the view controller as a child of this view controller
        currentChildVC!.view.frame = containerView.bounds  // Size the child view controller's view to fill the container view
        containerView.addSubview(currentChildVC!.view)  // Add the child view controller's view as a subview of the container view
        currentChildVC!.didMove(toParent: self)  // You must tell the child VC that it has been added as a child of a VC
        
        childVCIndex += 1
        if childVCIndex == childVCs.count { childVCIndex = 0 }
    }
}
