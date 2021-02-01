//
//  SceneDelegate.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 7/1/21.
//
import Foundation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        //self.scene(_scene: scene, openURLContexts: connectionOptions.urlContexts) //1
    }

    
//    func scene(_scene:UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>){
//        guard let windowScene = (_scene as? UIWindowScene) else { return }
//        if let url = URLContexts.first?.url{
//            let urlStr = url.absoluteString //1
//
//            print(urlStr)
//
//            if "\(urlStr)" == "ConnectMAD2://" {
//                        let vc = ViewController()
//                        let navController = UINavigationController(rootViewController: vc)
//
//                        window?.rootViewController = navController
//                        window?.makeKeyAndVisible()
//                        window?.windowScene = windowScene
//
//                        let cameraController = HomepageViewController()
//                        let camNavController = UINavigationController(rootViewController: cameraController)
//                        navController.present(camNavController, animated: true, completion: nil)
//                    }
//
//
//            if let productID = urlStr.replacingOccurrences(of: "ConnectMAD2://", with: "") as String?{
//                self.pushToDetailScreen(detail: productID) //4
//            }
//        }
//    }
//
//    func pushToDetailScreen(detail: String){
//        let MAD2VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomepageViewController")
//
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                        let initialViewController = storyboard.instantiateViewController(withIdentifier: "HomepageViewController")
//                        self.window?.rootViewController = HomepageViewController()
//                        self.window?.makeKeyAndVisible()
//
//    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

