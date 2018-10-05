//
//  LayoutGuideViewController.swift
//  AutolayoutExamples
//
//  Created by Charles Moncada on 04/10/18.
//  Copyright © 2018 Charles Moncada. All rights reserved.
//

import UIKit

class LayoutGuideViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()

		let images = [#imageLiteral(resourceName: "autobots@1x.png"),#imageLiteral(resourceName: "gameover@1x.png"),#imageLiteral(resourceName: "decepticons@1x.png")]
		let imageViews: [UIImageView] = images.map { image in
			let imageView = UIImageView(image: image)
			imageView.translatesAutoresizingMaskIntoConstraints = false
			return imageView
		}
		imageViews.forEach(view.addSubview)

		let spacerGuides = (0..<images.count - 1).map { _ in UILayoutGuide()}
		let containerGuide = UILayoutGuide()

		NSLayoutConstraint.activate(
			[ containerGuide.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor),
			  containerGuide.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor),
			  { let constraint = spacerGuides.first!.widthAnchor.constraint(equalToConstant: 80)
				constraint.priority = UILayoutPriority(749)
				return constraint
				}(),
			  spacerGuides.last!.widthAnchor.constraint(equalTo: spacerGuides.first!.widthAnchor)
			]
		)

	}
}
