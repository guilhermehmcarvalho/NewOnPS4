//
//  ViewController.swift
//  PS4WeekReleases
//
//  Created by Guilherme Carvalho on 20/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import UIKit
import VegaScrollFlowLayout
import NVActivityIndicatorView

// MARK: - Configurable constants
private let itemHeight: CGFloat = 304
private let lineSpacing: CGFloat = 20
private let xInset: CGFloat = 20
private let topInset: CGFloat = 10

class ViewController: UIViewController {
	
	// MARK: - Variables
	
	fileprivate let cellId = "ReleaseDateCell"
	let releaseDateService = ReleaseDateService()
	@IBOutlet weak var collectionView: UICollectionView!
	fileprivate var games: [Game] = []
	@IBOutlet weak var activityIndicator: NVActivityIndicatorView!
	
	// MARK: - View Controller
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let nib = UINib(nibName: cellId, bundle: nil)
		collectionView.register( nib, forCellWithReuseIdentifier: cellId)
		collectionView.contentInset.bottom = itemHeight
		configureCollectionViewLayout()
		//setUpNavBar()
		
		releaseDateService.delegate = self
		activityIndicator.type = .pacman
		activityIndicator.color = UIColor.App.yellow
		activityIndicator.startAnimating()
		releaseDateService.getPlaystationWeek()
		
		PushNotificationManager().authorizeAndSchedule()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		setUpNavBar()
	}
	
	// MARK: - Private

	private func setUpNavBar() {
		navigationItem.title = "New on PS4"
		navigationController?.view.backgroundColor = UIColor.black
		if #available(iOS 11.0, *) {
			navigationController?.navigationBar.prefersLargeTitles = true
		}
	}
	
	private func configureCollectionViewLayout() {
		guard let layout = collectionView.collectionViewLayout as? VegaScrollFlowLayout else { return }
		layout.minimumLineSpacing = lineSpacing
		layout.sectionInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
		let itemWidth = UIScreen.main.bounds.width - 2 * xInset
		layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
		collectionView.collectionViewLayout.invalidateLayout()
	}
}

// MARK: - UICollectionView

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                         for: indexPath) as? ReleaseDateCell {
            let game = games[indexPath.row]
            cell.configureWith(game)

            return cell
        }

        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return games.count
	}

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = games[indexPath.row].getOficialWebsite() else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

// MARK: - ReleaseDateServiceDelegate

extension ViewController: ReleaseDateServiceDelegate {
    func getPlaystationWeekDidComplete(games: [Game]) {
        self.games = games
        activityIndicator.stopAnimating()
        self.collectionView.reloadData()
    }
	
	func getPlaystationWeekDidComplete(failure: ServiceFailureType) {
		print(failure)
		activityIndicator.stopAnimating()
	}
}
