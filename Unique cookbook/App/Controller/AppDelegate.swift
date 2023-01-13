//
//  AppDelegate.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 29.09.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupTabBar()
        return true
    }

    private func setupTabBar() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.CustomColors.gray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor.CustomColors.lightGray,
                NSAttributedString.Key.font: UIFont.CustomFont.tabBarItem
            ]
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.CustomColors.lightGray
            
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor.CustomColors.green,
                NSAttributedString.Key.font: UIFont.CustomFont.tabBarItem
            ]
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.CustomColors.green

            UITabBar.appearance().standardAppearance = appearance
            #warning("Протестить автоматическую транзистентность таб и нав баров, когда будет скролл")
            UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        } else {
            UITabBar.appearance().barTintColor = UIColor.CustomColors.gray
            UITabBar.appearance().unselectedItemTintColor = UIColor.CustomColors.lightGray
            UITabBar.appearance().tintColor = UIColor.CustomColors.green
            UITabBarItem.appearance().setTitleTextAttributes(
                [NSAttributedString.Key.font: UIFont.CustomFont.tabBarItem],
                for: .normal
            )
            UITabBarItem.appearance().setTitleTextAttributes(
                [NSAttributedString.Key.font: UIFont.CustomFont.tabBarItem],
                for: .selected
            )
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Unique_cookbook")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
