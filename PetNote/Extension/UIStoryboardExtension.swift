//
//  UIStoryboardExtension.swift
//  PetNote
//
//  Created by iching chen on 2019/8/29.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UIKit

private struct StoryboardCategory {
    static let main = "Main"
    static let profile = "Profile"
    static let record = "Record"
    static let medical = "Medical"
    static let other = "Other"
    static let notify = "Notify"
    static let basic = "Basic"
}

extension UIStoryboard {
    static var main: UIStoryboard { return storyboard(name: StoryboardCategory.main) }

    static var profile: UIStoryboard { return
        storyboard(name: StoryboardCategory.profile)
    }
    static var record: UIStoryboard { return
        storyboard(name: StoryboardCategory.record)
    }
    static var medical: UIStoryboard { return
        storyboard(name: StoryboardCategory.medical)
    }
    static var other: UIStoryboard { return
        storyboard(name: StoryboardCategory.other)
    }
    static var notify: UIStoryboard { return
        storyboard(name: StoryboardCategory.notify)
    }
    static var basic: UIStoryboard { return
        storyboard(name: StoryboardCategory.basic)
    }
        
    private static func storyboard(name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
}
