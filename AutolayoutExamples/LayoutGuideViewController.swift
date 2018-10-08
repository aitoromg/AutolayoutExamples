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

		let images = [UIImage(named: "autobots"), UIImage(named: "decepticons"), UIImage(named: "gameover")]
		let imageViews: [UIImageView] = images.map { image in
			let imageView = UIImageView(image: image)
			imageView.translatesAutoresizingMaskIntoConstraints = false
			return imageView
		}
		imageViews.forEach(view.addSubview)

		let spacerGuides = (0..<images.count - 1).map { _ in UILayoutGuide()}
		let containerGuide = UILayoutGuide()

		spacerGuides.forEach(view.addLayoutGuide)
		view.addLayoutGuide(containerGuide)

		containerGuide.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

		NSLayoutConstraint.activate(
			[
				containerGuide.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor),
				containerGuide.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor),
				{ let constraint = spacerGuides.first!.widthAnchor.constraint(equalToConstant: 80)
					constraint.priority = UILayoutPriority(749)
					return constraint
				}(),
				spacerGuides.last!.widthAnchor.constraint(equalTo: spacerGuides.first!.widthAnchor)
			]
		)

		NSLayoutConstraint.activate(
				imageViews.enumerated().flatMap { index, imageView in
					[
						imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
						imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
						imageView.leadingAnchor.constraint(equalTo:
							imageView == imageViews.first!
							? containerGuide.leadingAnchor
							: spacerGuides[index - 1].trailingAnchor
						),
						imageView.trailingAnchor.constraint(equalTo:
							imageView == imageViews.last!
								? containerGuide.trailingAnchor
								: spacerGuides[index].leadingAnchor
						),
					]
				}
		)

		imageViews.dropFirst().forEach({ $0.widthAnchor.constraint(equalTo: imageViews.first!.widthAnchor).isActive = true })
	}
}
