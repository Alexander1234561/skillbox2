import UIKit
import Foundation

//4
//Дженерики позволяют создавать многократно используемые функции с разными с типами данных, которые также могут соответствовать разным ограничениям

//5

// associatedtype используется с протоколами.

//6

//a

func equtableObjects<T: Equatable>(first: T, second: T) {
    first == second ? print("Equal") : print("Not equal")
}
equtableObjects(first: "Hello", second: "Hell")

//b

func comparableMax<T: Comparable>(first: T, second: T) {
    first > second ? print(first) : print(second)
}
comparableMax(first: 23, second: 10)

//c

func comparableCanChange<T: Comparable>(first: inout T, second: inout T) {
    if (second < first){
        let tmp: T = first
        first = second
        second = tmp
    }
}
var a = 2
var b = 6
comparableCanChange(first: &b, second: &a)
a
b

//d

func f<T>(first: @escaping (T)->Void, second: @escaping (T)->Void) -> (T)->Void{
    return { (t : T) -> Void in
        first(t)
        second(t)
    }
}
//7

//a

extension Array where Element: Comparable {
    var maxEl: Element {
        get{    var max = self[0]
                for i in self {
                    if (i > max) {max = i} }
                return max
        }
    }
}

var arr = [10,10,3,4,5,1,2,10,2,3,5,63,3,3,10,2,3,4]
arr.maxEl
//b

extension Array where Element: Equatable{
    mutating func delEq(){ //Если элементы чисто Equitable
        
        var indexArr: Array<Int> = []
        for i in 0...self.count - 2 {
            for j in i + 1...self.count - 1 {
                if self[j] == self[i] { indexArr.append(j) }
            }
        }
        indexArr = Array<Int>(Set(indexArr))
        indexArr.sort()
        indexArr.reverse()
        for index in indexArr {
            self.remove(at: index)
        }
    }
   /* mutating func delEq2(){ // Если Hashable
        self = Array(Set(self))
    }*/
}
arr.delEq()
arr

//8

//a

extension Int {
    static func ^ (left: Int, right: Int) -> Int{
        var res = 1
        guard (right != 0) else { return res }
        for _ in 0...abs(right) - 1{
            res *= right > 0 ? left : 1/left
        }
        return res
    }
}
2^(10)

//b

infix operator ~>

extension Int {
    static func ~>(left: Int, right: inout Int) {
        right = 2 * left
    }
}
var s: Int = 0
4 ~> s
s

//c

infix operator <*
func <* (left: UITableViewDelegate, right:UITableView) {
    right.delegate = left
}

//d

func +(left: CustomStringConvertible, right: CustomStringConvertible) -> CustomStringConvertible{
    return "\(left) \(right)"
}


var g: CustomStringConvertible = 2
var k: CustomStringConvertible = "Hello"

var v = g + k

//9

protocol Animator {
    associatedtype Target
    associatedtype Value
    init (_ value: Value)
    func animate(_ target: Target)
}

infix operator >>>
func >>> <T: Animator>(left: T, right: T.Target) {
    left.animate(right)
}

//a

class BackGroundAnimator: Animator {
   
    let newValue: UIColor
    
    required init (_ value: UIColor) {
        self.newValue = value
    }
    func animate(_ target: UIView) {
        UIView.animate(withDuration: 0.4) {
            target.backgroundColor = self.newValue
            
        }
    }
}

var vi: UIView = UIView(frame: CGRect(x: 5, y: 5, width: 10, height: 10))

BackGroundAnimator(UIColor.green) >>> vi
//b


class CenterAnimator: Animator {
    
    typealias Target = UIView
    typealias Value = CGPoint
    
    
    let newValue: CGPoint
    
    required init (_ value: CGPoint) {
        self.newValue = value
    }
    func animate(_ target: UIView) {
        UIView.animate(withDuration: 0.4) {
           target.frame.origin.x = self.newValue.x - target.frame.width/2
           target.frame.origin.x = self.newValue.y + target.frame.height/2
            
        }
    }
}

//c

class ScaleAnimator: Animator {
    
    typealias Target = UIView
    typealias Value = CGPoint
    
    
    let newValue: CGPoint
    
    required init (_ value: CGPoint) {
        self.newValue = value
    }
    func animate(_ target: UIView) {
        UIView.animate(withDuration: 0.4) {
            target.transform = CGAffineTransform(scaleX: self.newValue.x, y: self.newValue.y)
        }
    }
}


