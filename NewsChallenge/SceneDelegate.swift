//
//  SceneDelegate.swift
//  NewsChallenge
//
//  Created by Dai Tran on 8/19/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var navigationController: UINavigationController?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let remoteFeedLoader = RemoteFeedLoader(client: URLSessionHTTPClient())
        let localFeedLoader = LocalFeedLoader()
        let loader = RemoteFeedLoaderWithLocalFallback(remoteLoader: remoteFeedLoader, localLoader: localFeedLoader)
        let dataSource = AllFeedsSceneDataSource(items: [], didTapItem: { _ in })
        let allFeedsScene = AllFeedsScene(vm: AllFeedsViewModel(loader: loader), dataSource: dataSource)
        navigationController = UINavigationController(rootViewController: allFeedsScene)
        window?.rootViewController = navigationController
    }
}

