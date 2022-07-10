// Copyright © 2022 Brian Drelling. All rights reserved.

// Source: https://developer.apple.com/documentation/uikit/uicommand/adding_menus_and_shortcuts_to_the_menu_bar_and_user_interface
final class MenuController: NSObject {
    init(with builder: UIMenuBuilder) {
        builder.insertSibling(Self.referencesMenu(), beforeMenu: .window)
    }

    class func referencesMenu() -> UIMenu {
        .init(
            title: "References",
//            identifier: .references,
            options: [],
            children: [
                UICommand(
                    title: "Note Frequency Chart",
                    action: #selector(test(_:))
//                    propertyList: [CommandPListKeys.ReferencesIdentifierKey: "note_frequency"]
                ),
            ]
        )
    }

    @objc
    func test(_ sender: UICommand) {
        print("Tested")
    }
}

final class OpenNoteFrequencyChart: NSObject {
    @objc
    static func run(_ sender: UICommand) {
        print("Wow")
//        Swift.debugPrint(#function)
    }
}

extension MenuController {
    enum CommandPListKeys {
        static let ReferencesIdentifierKey = "reference"
    }
}

extension UIMenu.Identifier {
    static let references: UIMenu.Identifier = .init("com.briandrelling.tuner.menus.references")
}
