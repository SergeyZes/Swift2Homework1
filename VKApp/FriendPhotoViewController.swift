//
//  FriendPhotoViewController.swift
//  VKApp
//
//  Created by Сергей Зесли on 06.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class FriendPhotoViewController: UIViewController {

    var friendPhoto: UIImageView!
    var img: UIImage!
    var toRight: Bool = true
    var friendimgs: [UIImage]!
    var friendPhotoes = [UIImageView]()
    var friendTransforms = [CGFloat]()
    var maxIndex: Int = 0
    var curIndex: Int = 0
    
    
    var animator: UIViewPropertyAnimator!
    
    private func createFriendPhotoes() {
        let n = friendimgs.count
        maxIndex = n - 1
        

        for i in 0..<n {
            let photo = UIImageView()
            let recognizer = PanDirectionGestureRecognizer(direction: .horizontal, target: self, action: #selector(onSwipe(_:)))

            photo.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(photo)
            //let guide = view.safeAreaLayoutGuide
            photo.leftAnchor.constraint(equalTo: safeLeftAnchor).isActive = true
            photo.rightAnchor.constraint(equalTo: safeRightAnchor).isActive = true
            photo.topAnchor.constraint(equalTo: safeTopAnchor).isActive = true
            photo.bottomAnchor.constraint(equalTo: safeBottomAnchor).isActive = true
            photo.addGestureRecognizer(recognizer)
            photo.isUserInteractionEnabled = true
            
            friendPhotoes.append(photo)

        }
    }
    
    func showI(_ i: Int) {
        let w = friendPhotoes[0].bounds.width
        
        for k in 0..<friendPhotoes.count {
            friendTransforms[k] = CGFloat(k - i) * w
            friendPhotoes[k].transform = CGAffineTransform(translationX: friendTransforms[k], y: 0).scaledBy(x: 0.95, y: 0.95)
        }
    }

    func showI2(_ i: Int) {
        let w = friendPhotoes[0].bounds.width
        
        for k in 0..<friendPhotoes.count {
            friendTransforms[k] = CGFloat(k - i) * w
            friendPhotoes[k].transform = CGAffineTransform(translationX: friendTransforms[k], y: 0)
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createFriendPhotoes()
        
        

        // Do any additional setup after loading the view.
    }
    
    @objc func onSwipe(_ recognizer: UIPanGestureRecognizer){
                print("begun")
        
        switch recognizer.state {
        case .began:
            self.showI(self.curIndex)

            animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.5, animations: {
                //self.friendPhoto.transform = CGAffineTransform(translationX: self.friendPhoto.bounds.width, y: 0)
                if self.curIndex == 0 {
                    self.toRight = false
                    self.showI(self.curIndex + 1)

                } else {
                    self.toRight = true
                    self.showI(self.curIndex - 1)
                }
            })
            
            animator.pauseAnimation()

        case .changed:
            //var translation = recognizer.translation(in: self.friendPhoto).x
            var translation = recognizer.translation(in: self.friendPhotoes[self.curIndex]).x
            
            if toRight && translation < 0 {
                animator.stopAnimation(true)
                animator.addAnimations {
                   // self.friendPhoto.transform = CGAffineTransform(translationX: -self.friendPhoto.bounds.width, y: 0)
                    self.showI(self.curIndex + 1)
                }
                toRight = false
                animator.pauseAnimation()
            } else if !toRight && translation > 0 {
                animator.stopAnimation(true)
                animator.addAnimations {
                    //self.friendPhoto.transform = CGAffineTransform(translationX: self.friendPhoto.bounds.width, y: 0)
                    self.showI(self.curIndex - 1)
                }
                toRight = true
                animator.pauseAnimation()

            }
            if translation < 0 {
                translation = -translation
            }
            
            if (toRight && self.curIndex == 0) || (!toRight && self.curIndex == self.maxIndex) {
                animator.stopAnimation(true)
                //self.showI2(self.curIndex)
            } else  {
                animator.fractionComplete = translation / self.friendPhotoes[self.curIndex].bounds.width
            }
           
        case .ended:
            let fc = animator.fractionComplete
            animator.stopAnimation(true)
            
            if (toRight && self.curIndex == 0) || (!toRight && self.curIndex == self.maxIndex) {
                self.showI2(self.curIndex)
                return
            }

            
            animator.addAnimations {
                if fc > 0.5 {
                    if self.toRight {
                        //self.friendPhoto.transform = CGAffineTransform(translationX: self.friendPhoto.bounds.width, y: 0)
                        self.showI2(self.curIndex - 1)
                        self.curIndex -= 1
                    } else {
                        //self.friendPhoto.transform = CGAffineTransform(translationX: -self.friendPhoto.bounds.width, y: 0)
                        self.showI2(self.curIndex + 1)
                        self.curIndex += 1
                    }
                } else {
                    self.showI2(self.curIndex)
                }
            }
            animator.startAnimation()
            
        default:
            return
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        friendPhoto.image = img
        
        
        for i in 0..<friendimgs.count {
            friendPhotoes[i].image = friendimgs[i]
            if i == 0 {
               friendPhotoes[i].image = img
            }
            
            
            friendPhotoes[i].transform = CGAffineTransform(translationX: CGFloat(i * 1000), y: 0)

        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for i in 0..<friendimgs.count {
            if i == 0 {
                friendPhotoes[i].image = friendimgs[i]
            }
            
            let w = friendPhotoes[i].bounds.width * CGFloat(i)
            friendTransforms.append(w)
                        
            friendPhotoes[i].transform = CGAffineTransform(translationX: w, y: 0)

        }
        showI2(curIndex)
    }
    


}

extension FriendPhotoViewController {

  var safeTopAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
        return self.view.safeAreaLayoutGuide.topAnchor
    }
    return self.view.topAnchor
  }

  var safeLeftAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return self.view.safeAreaLayoutGuide.leftAnchor
    }
    return self.view.leftAnchor
  }

  var safeRightAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return self.view.safeAreaLayoutGuide.rightAnchor
    }
    return self.view.rightAnchor
  }

  var safeBottomAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.view.safeAreaLayoutGuide.bottomAnchor
    }
    return self.view.bottomAnchor
  }
}

enum PanDirection {
    case vertical
    case horizontal
}

class PanDirectionGestureRecognizer: UIPanGestureRecognizer {

    let direction: PanDirection

    init(direction: PanDirection, target: AnyObject, action: Selector) {
        self.direction = direction
        super.init(target: target, action: action)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)

        if state == .began {
            let vel = velocity(in: view)
            switch direction {
            case .horizontal where abs(vel.y) > abs(vel.x):
                state = .cancelled
            case .vertical where abs(vel.x) > abs(vel.y):
                state = .cancelled
            default:
                break
            }
        }
    }
}
