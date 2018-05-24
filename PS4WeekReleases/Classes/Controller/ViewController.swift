//
//  ViewController.swift
//  PS4WeekReleases
//
//  Created by Guilherme Carvalho on 20/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	let releaseDateService = ReleaseDateService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		releaseDateService.delegate = self
		releaseDateService.getPlaystationWeek()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: ReleaseDateServiceDelegate {
	func getPlaystationWeekDidComplete(releaseDates: [ReleaseDate]) {
		print(releaseDates)
	}
	
	func getPlaystationWeekDidComplete(failure: ServiceFailureType) {
		print(failure)
	}
}
