import Foundation

@objc protocol Speaker {
  func Speak()
  optional func TellJoke()
}

protocol DateSimulatorDelegate {
  func dateSimulatorDidStart(sim:DateSimulator, a:Speaker, b:Speaker)
  func dateSimulatorDidEnd(sim:DateSimulator, a:Speaker, b:Speaker)
}

class Vicki: Speaker {
  @objc func Speak(){
    print("Hello! My name is Vicki")
  }
}

class Ray: Speaker {
  @objc func Speak(){
    print("Yo! My name is Ray!")
  }
}

class DateSimulator {

  let a:Speaker
  let b:Speaker
  var delegate:DateSimulatorDelegate?

  init(a:Speaker, b:Speaker) {
    self.a = a
    self.b = b
  }

  func simulate() {
    delegate?.dateSimulatorDidStart(self, a: a, b: b)
    print("Off to dinner ....")
    a.Speak()
    b.Speak()
    print("Walking back home .....")
    a.TellJoke?()
    a.TellJoke?()
    delegate?.dateSimulatorDidEnd(self, a: a, b: b)
  }
}

class LoggingDateSimulator: DateSimulatorDelegate {
  func dateSimulatorDidStart(sim: DateSimulator, a:Speaker, b:Speaker) {
    print("Date Started")
  }
  func dateSimulatorDidEnd(sim:DateSimulator, a:Speaker, b:Speaker) {
    print("Date Ended")
  }
}

let sim = DateSimulator(a:Vicki(), b:Ray())
sim.delegate = LoggingDateSimulator()
sim.simulate()

