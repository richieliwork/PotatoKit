import UIKit

/// present动画类型
///
/// - present: present
/// - dismiss: dismiss
enum PresentAnimateType {
    case present
    case dismiss
}

/// Present 动画 （模仿push）
class PresentAnimation: NSObject {
    private let animationType: PresentAnimateType
    init(animation type:PresentAnimateType) {
        animationType = type
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension PresentAnimation : UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from), let toView = transitionContext.view(forKey: .to), let to = transitionContext.viewController(forKey: .to), let from = transitionContext.viewController(forKey: .from) else {
            return
        }
        let containerView = transitionContext.containerView
        let finalFrame: CGRect = transitionContext.finalFrame(for: to)
        switch self.animationType {
        case .present:
            containerView.addSubview(toView)
            toView.frame = finalFrame.offsetBy(dx: finalFrame.width, dy: 0)
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                to.view.frame = finalFrame
            }) { (completeion) in
                transitionContext.completeTransition(true)
            }
        default:
            containerView.addSubview(toView)
            containerView.addSubview(fromView)
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                from.view.frame = finalFrame.offsetBy(dx: finalFrame.width, dy: 0)
            }) { (completeion) in
                transitionContext.completeTransition(true)
            }
        }
    }
}
