import Foundation

enum Locale: String {
    
    /// Create a counter
    case navigationBarCreateCounter = "navigationBar.title.createCounter"
    
    /// Examples
    case navigationBarExamples = "navigationBar.title.examples"
    
    /// Create
    case navigationBack = "navigationBar.back"
    
    /// Save
    case buttonItemSave = "button.item.save"
    
    /// Cancel
    case buttonItemCancel = "button.item.cancel"

    /// Dismiss
    case alertButtonDismiss = "alert.button.dismiss"

    /// Cups of coffe
    case textFieldHintExampleTitle = "textfield.hint.exampleTitle"

    /// Give it a name. Creative block?
    case labelTextGiveACreativeName = "label.text.giveACreativeName"
    
    /// See Examples
    case labelTextSeeExamples = "label.text.seeExamples"
    
    /// "Select an example to add it to your counters."
    case labelTextSelectExampleToAdd = "label.text.selectExampleToAdd"
}

extension Locale {
    
    var localized: String {
        return NSLocalizedString(self.rawValue, bundle: .module, comment: "")
    }
    
    func localized(with arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
    
}
