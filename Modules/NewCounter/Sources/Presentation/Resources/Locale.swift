import Foundation

enum Locale: String {
    
    /// Dismiss
    case alertButtonDismiss = "alert.button.dismiss"
    
    /// Couldn't create the counter
    case exceptionTitleCantCreateCounter = "exception.title.cantCreateCounter"
    
    /// The internet connection appears to be offline.
    case exceptionMessageCantCreateCounter = "exception.message.cantCreateCounter"

}

extension Locale {
    
    var localized: String {
        return NSLocalizedString(self.rawValue, bundle: .module, comment: "")
    }
    
    func localized(with arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
    
}