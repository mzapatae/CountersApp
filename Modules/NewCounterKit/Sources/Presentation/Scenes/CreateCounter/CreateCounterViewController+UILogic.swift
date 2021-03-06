import UIKit
import DesignKit
import AltairMDKCommon

// MARK: Handle States

extension CreateCounterViewController {
    
    func handleCreateSuccess() {
        dismissScreen()
    }
    
    func handleCreatingInProgress(_ inProgress: Bool) {
        if inProgress {
            startActivityIndicator()
        } else {
            stopActivityIndicator()
        }
    }
    
    func handleOccuredException(_ exception: Exception?) {
        guard let exception = exception else { return }
        showExceptionAlert(exception: exception)
    }

}

// MARK: UI Operations

extension CreateCounterViewController {
    
    func startActivityIndicator() {
        innerView.startActivityIndicator()
    }
    
    func stopActivityIndicator() {
        innerView.stopActivityIndicator()
    }
    
    func showExceptionAlert(exception: Exception) {
        if let currentAlert = self.presentedViewController as? UIAlertController {
            currentAlert.title = exception.errorTitle
            currentAlert.message = exception.errorDescription
            return
        }
        let dismissAction = UIAlertAction(title: Locale.alertButtonDismiss.localized, style: .cancel) { _ in
            self.dismissDialog()
        }
        let alert = UIAlertController(title: exception.errorTitle, message: exception.errorDescription, preferredStyle: .alert)
        alert.view.tintColor = Palette.accent.uiColor
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: Events Actions

extension CreateCounterViewController {
    
    @objc func didTapSaveButtonAction(_ sender: Any) {
        guard let counterTitle = innerView.titleInserted else { return }
        saveCounter(title: counterTitle)
    }
    
    @objc func didTapCanceButtonAction(_ sender: Any) {
        dismissScreen()
    }

}

// MARK:  View Delegates

extension CreateCounterViewController: CreateCounterViewDelegate {
    
    func didTapSeeExamplesLabel() {
        openExamplesCounterScreen()
    }
    
    func isTitleValid(_ isValid: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = isValid ? true : false
    }
    
}
