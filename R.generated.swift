//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 colors.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 2 files.
  struct file {
    /// Resource file `GoogleService-Info.plist`.
    static let googleServiceInfoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "GoogleService-Info", pathExtension: "plist")
    /// Resource file `Xcode.gitignore`.
    static let xcodeGitignore = Rswift.FileResource(bundle: R.hostingBundle, name: "Xcode", pathExtension: "gitignore")
    
    /// `bundle.url(forResource: "GoogleService-Info", withExtension: "plist")`
    static func googleServiceInfoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "Xcode", withExtension: "gitignore")`
    static func xcodeGitignore(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.xcodeGitignore
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 0 images.
  struct image {
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 0 nibs.
  struct nib {
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 3 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `AddUsersViewCell`.
    static let addUsersViewCell: Rswift.ReuseIdentifier<AddUsersViewCell> = Rswift.ReuseIdentifier(identifier: "AddUsersViewCell")
    /// Reuse identifier `AdminTableViewCell`.
    static let adminTableViewCell: Rswift.ReuseIdentifier<TopicTableViewCell> = Rswift.ReuseIdentifier(identifier: "AdminTableViewCell")
    /// Reuse identifier `ListaAlbumTableViewCell`.
    static let listaAlbumTableViewCell: Rswift.ReuseIdentifier<ListaAlbumTableViewCell> = Rswift.ReuseIdentifier(identifier: "ListaAlbumTableViewCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 7 view controllers.
  struct segue {
    /// This struct is generated for `CreateTopicController`, and contains static references to 1 segues.
    struct createTopicController {
      /// Segue identifier `segueToAddUser`.
      static let segueToAddUser: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, CreateTopicController, AddUsersTopicController> = Rswift.StoryboardSegueIdentifier(identifier: "segueToAddUser")
      
      /// Optionally returns a typed version of segue `segueToAddUser`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func segueToAddUser(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, CreateTopicController, AddUsersTopicController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.createTopicController.segueToAddUser, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    /// This struct is generated for `LoginViewController`, and contains static references to 1 segues.
    struct loginViewController {
      /// Segue identifier `segueToOptions`.
      static let segueToOptions: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, LoginViewController, ViewController> = Rswift.StoryboardSegueIdentifier(identifier: "segueToOptions")
      
      /// Optionally returns a typed version of segue `segueToOptions`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func segueToOptions(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, LoginViewController, ViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.loginViewController.segueToOptions, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    /// This struct is generated for `MainViewController`, and contains static references to 3 segues.
    struct mainViewController {
      /// Segue identifier `segueToAccount`.
      static let segueToAccount: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, MainViewController, CreateTopicController> = Rswift.StoryboardSegueIdentifier(identifier: "segueToAccount")
      /// Segue identifier `segueToAddTopic`.
      static let segueToAddTopic: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, MainViewController, CreateTopicController> = Rswift.StoryboardSegueIdentifier(identifier: "segueToAddTopic")
      /// Segue identifier `segueToAlbums`.
      static let segueToAlbums: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, MainViewController, AdminListaAlbumController> = Rswift.StoryboardSegueIdentifier(identifier: "segueToAlbums")
      
      /// Optionally returns a typed version of segue `segueToAccount`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func segueToAccount(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, MainViewController, CreateTopicController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.mainViewController.segueToAccount, segue: segue)
      }
      
      /// Optionally returns a typed version of segue `segueToAddTopic`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func segueToAddTopic(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, MainViewController, CreateTopicController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.mainViewController.segueToAddTopic, segue: segue)
      }
      
      /// Optionally returns a typed version of segue `segueToAlbums`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func segueToAlbums(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, MainViewController, AdminListaAlbumController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.mainViewController.segueToAlbums, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    /// This struct is generated for `RegisterViewController`, and contains static references to 1 segues.
    struct registerViewController {
      /// Segue identifier `segueToAdditionalData`.
      static let segueToAdditionalData: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, RegisterViewController, UIKit.UINavigationController> = Rswift.StoryboardSegueIdentifier(identifier: "segueToAdditionalData")
      
      /// Optionally returns a typed version of segue `segueToAdditionalData`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func segueToAdditionalData(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, RegisterViewController, UIKit.UINavigationController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.registerViewController.segueToAdditionalData, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    /// This struct is generated for `SaveViewController`, and contains static references to 1 segues.
    struct saveViewController {
      /// Segue identifier `segueToOptions`.
      static let segueToOptions: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, SaveViewController, ViewController> = Rswift.StoryboardSegueIdentifier(identifier: "segueToOptions")
      
      /// Optionally returns a typed version of segue `segueToOptions`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func segueToOptions(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, SaveViewController, ViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.saveViewController.segueToOptions, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    /// This struct is generated for `StartViewController`, and contains static references to 2 segues.
    struct startViewController {
      /// Segue identifier `toLoginSegue`.
      static let toLoginSegue: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, StartViewController, LoginViewController> = Rswift.StoryboardSegueIdentifier(identifier: "toLoginSegue")
      /// Segue identifier `toRegisterSegue`.
      static let toRegisterSegue: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, StartViewController, RegisterViewController> = Rswift.StoryboardSegueIdentifier(identifier: "toRegisterSegue")
      
      /// Optionally returns a typed version of segue `toLoginSegue`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func toLoginSegue(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, StartViewController, LoginViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.startViewController.toLoginSegue, segue: segue)
      }
      
      /// Optionally returns a typed version of segue `toRegisterSegue`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func toRegisterSegue(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, StartViewController, RegisterViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.startViewController.toRegisterSegue, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    /// This struct is generated for `ViewController`, and contains static references to 2 segues.
    struct viewController {
      /// Segue identifier `segueToLogin`.
      static let segueToLogin: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, ViewController, UIKit.UINavigationController> = Rswift.StoryboardSegueIdentifier(identifier: "segueToLogin")
      /// Segue identifier `segueToMain`.
      static let segueToMain: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, ViewController, UIKit.UINavigationController> = Rswift.StoryboardSegueIdentifier(identifier: "segueToMain")
      
      /// Optionally returns a typed version of segue `segueToLogin`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func segueToLogin(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, ViewController, UIKit.UINavigationController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.viewController.segueToLogin, segue: segue)
      }
      
      /// Optionally returns a typed version of segue `segueToMain`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func segueToMain(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, ViewController, UIKit.UINavigationController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.viewController.segueToMain, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 5 storyboards.
  struct storyboard {
    /// Storyboard `AlbumStoryboard`.
    static let albumStoryboard = _R.storyboard.albumStoryboard()
    /// Storyboard `Authentication`.
    static let authentication = _R.storyboard.authentication()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `MainStoryboard`.
    static let mainStoryboard = _R.storyboard.mainStoryboard()
    /// Storyboard `WhiteStoryboard`.
    static let whiteStoryboard = _R.storyboard.whiteStoryboard()
    
    /// `UIStoryboard(name: "AlbumStoryboard", bundle: ...)`
    static func albumStoryboard(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.albumStoryboard)
    }
    
    /// `UIStoryboard(name: "Authentication", bundle: ...)`
    static func authentication(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.authentication)
    }
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "MainStoryboard", bundle: ...)`
    static func mainStoryboard(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.mainStoryboard)
    }
    
    /// `UIStoryboard(name: "WhiteStoryboard", bundle: ...)`
    static func whiteStoryboard(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.whiteStoryboard)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 0 localization tables.
  struct string {
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try authentication.validate()
      try whiteStoryboard.validate()
    }
    
    struct albumStoryboard: Rswift.StoryboardResourceType {
      let bundle = R.hostingBundle
      let name = "AlbumStoryboard"
      
      fileprivate init() {}
    }
    
    struct authentication: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let name = "Authentication"
      let saveViewController = StoryboardViewControllerResource<SaveViewController>(identifier: "SaveViewController")
      
      func saveViewController(_: Void = ()) -> SaveViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: saveViewController)
      }
      
      static func validate() throws {
        if _R.storyboard.authentication().saveViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'saveViewController' could not be loaded from storyboard 'Authentication' as 'SaveViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      fileprivate init() {}
    }
    
    struct mainStoryboard: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let name = "MainStoryboard"
      
      fileprivate init() {}
    }
    
    struct whiteStoryboard: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = ViewController
      
      let bundle = R.hostingBundle
      let name = "WhiteStoryboard"
      let viewController = StoryboardViewControllerResource<ViewController>(identifier: "ViewController")
      
      func viewController(_: Void = ()) -> ViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: viewController)
      }
      
      static func validate() throws {
        if _R.storyboard.whiteStoryboard().viewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'viewController' could not be loaded from storyboard 'WhiteStoryboard' as 'ViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
