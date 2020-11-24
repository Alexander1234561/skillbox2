import UIKit


//1

//Да, можно, добавиви AnyObject к списку реализации протоколов

protocol OnlyForClass: AnyObject {
    
}

class a: OnlyForClass{}

//2

//Да, использовав ключевые слова: @objc optional, такие протоколы могут применяться только классами, а не структурами и перечислениями
//К сожалению не смог найти еще вариантов.

@objc protocol Beer{
   @objc optional var crackers: Bool { get }
}


class Home: Beer{}
class Bar: Beer{
    var crackers = true
}

//3

//Нет нельзя -> Обойти можно
/*
extension Home {
    struct Holder {
        static var table :String = ""
    }
    var table: String {
        get{return Holder.table}
        set(newValue) {Holder.table = newValue}
    }
}
var h: Home = Home()
h.table = "tab"
h.table*/

// Результат будет только 456 => работает неверно

//1
extension Home {
    private static var _myComputedProperty = [String:String]()
    
    var table: String {
        get{
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return Home._myComputedProperty[tmpAddress] ?? ""
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            Home._myComputedProperty[tmpAddress] = newValue
        }
    }
}
//4s
 
//Да. Расширения могут добавлять новые вложенные типы к существующим классам, структурам и перечислениям.
 
extension Home {
    class Mother {}
    struct Father {}
    enum Son {}
}

//5. Расширение можно подписать под протокол.

//Да

protocol Something{
    func some() -> Void
}

class Dog{}
struct Cat{}
enum Money{}

extension Dog: Something{
    func some() {
        print("I am Dog")
    }
}

extension Cat: Something {
    func some() {
        print("I am Cat")
    }
}

extension Money: Something{
    func some() {
        "This is money"
    }
}

//6

//Да. Расширения могут добавить новые инициализаторы существующему типу. Расширения могут добавлять вспомогательные инициализаторы классу, но они не могут добавить новый назначенный инициализатор.

struct Point {
    var x: Double
    var y: Double
}

extension Point {
    init(x: Double) {
        self.init(x: x, y: 5)
    }
}

//7

//Да, можно реализовать с помощью let

protocol NewProtocol{
    var el: Bool { get }
}
class NewClass: NewProtocol{
    let el = true
}

//8

//Да. Протокол может наследовать один или более других протоколов и может добавлять требования поверх тех требований протоколов, которые он наследует

protocol AnotherProtocol{
}

protocol LastProtocol: NewProtocol, AnotherProtocol{
    func hello() -> Void
}

//9

//понял.

//10

//Можно сделать при помощи композиции протоколов (&)

class JClass: NewProtocol, AnotherProtocol{
    var el: Bool
    
    init(el: Bool) {
        self.el = el
    }
}

func helloWith(p: NewProtocol & AnotherProtocol) {
    print(p.el)
}



