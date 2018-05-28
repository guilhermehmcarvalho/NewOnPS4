//
//  AboutViewController.swift
//  PS4WeekReleases
//
//  Created by Guilherme on 28/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

	// MARK: - Variables
	
	@IBOutlet weak var licensesText: UILabel!
	@IBOutlet weak var contactText: UILabel!
	@IBOutlet weak var aboutText: UILabel!
	let texts = Texts()
	
	// MARK: - AboutViewController
	
	override func viewDidLoad() {
        super.viewDidLoad()

        loadTexts()
		setUpNavBar()
    }
	
	// MARK: - Private
	
	private func setUpNavBar() {
		navigationItem.title = texts.title
		navigationController?.view.backgroundColor = UIColor.black
		if #available(iOS 11.0, *) {
			navigationController?.navigationBar.prefersLargeTitles = false
		}
		self.navigationController?.navigationBar.topItem?.title = texts.backButton
	}
	
	private func loadTexts() {
		licensesText.text = texts.licenses
		contactText.text = texts.contact
		aboutText.text = texts.about
	}

}
