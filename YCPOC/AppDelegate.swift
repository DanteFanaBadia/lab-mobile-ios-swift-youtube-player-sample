//
//  AppDelegate.swift
//  YCPOC
//
//  Created by Dante Faña Badía on 5/7/20.
//  Copyright © 2020 DFB. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController()
        window!.makeKeyAndVisible()

        return true
    }
}

import UIKit
import WebKit
import youtube_ios_player_helper

class MainViewController: UIViewController, YTPlayerViewDelegate {

    let playerVars = [
           "playsinline": 1,
           "autoplay": 1,
           "enablejsapi": 1
    ]

    let videoId = "xwwAVRyNmgQ"

    lazy var playerView: YTPlayerView = {
        let ytp = YTPlayerView()
        ytp.translatesAutoresizingMaskIntoConstraints = false
        ytp.delegate = self
        return ytp
    }()

    lazy var btnStop: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Stop", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(stopVideo), for: .touchUpInside)
        return btn
    }()

    lazy var btnPause: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Pause", for: .normal)
        btn.backgroundColor = UIColor.yellow
        btn.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(pauseVideo), for: .touchUpInside)
        return btn
    }()

    lazy var btnStart: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Start", for: .normal)
        btn.backgroundColor = UIColor.green
        btn.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(startVideo), for: .touchUpInside)
        return btn
    }()

    lazy var btnsStack: UIStackView = {
        let btns = UIStackView(arrangedSubviews: [
            btnStart,
            btnPause,
            btnStop
        ])
        btns.axis = .horizontal
        btns.spacing = 15.0
        btns.translatesAutoresizingMaskIntoConstraints = false
        return btns
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(playerView)
        view.addSubview(btnsStack)

        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0),
            playerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 250),
            playerView.widthAnchor.constraint(equalToConstant: 400),

            btnsStack.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 5.0),
            btnsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        playerView.load(withVideoId: self.videoId, playerVars: self.playerVars)
    }

    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch (state) {
        case .ended:
            playerView.stopVideo()
        default:
            break
        }
    }

    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        //autoplay hack
        //playerView.playVideo()
    }

    @objc func stopVideo(sender: UIButton!) {
       playerView.stopVideo()
    }

    @objc func pauseVideo(sender: UIButton!) {
       playerView.pauseVideo()
    }

    @objc func startVideo(sender: UIButton!) {
       playerView.playVideo()
    }
}

