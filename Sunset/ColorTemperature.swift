import Foundation

private func fn(_ a: Double, b: Double, c: Double, d: Double, e: Double) -> (Double) -> (Double) {
  return { (temperature: Double) -> Double in
    let logTemp = log(temperature)
    // The full expression is "too complex" for Swift's compiler
    let p4 = a * pow(logTemp, 4)
    let p3 = b * pow(logTemp, 3)
    let p2 = c * pow(logTemp, 2)
    let p1 = d * logTemp
    return p4 + p3 + p2 + p1 + e
  }
}

private func bound(_ x: Double) -> Double {
    return min(1, max(0, x))
}

// http://sidnicious.github.io/Sunset/Color%20temperature%20to%20RGB.html
private let convert_red = fn(5.67621943e-02, b: -2.26166080e+00, c: 3.38779169e+01, d: -2.26209401e+02, e: 5.68980542e+02)
private let convert_green_a = fn(-2.52133449e-02, b: 8.20307726e-01, c: -1.00400819e+01, d: 5.51703452e+01, e: -1.14806924e+02)
private let convert_green_b = fn(2.72625592e-02, b: -1.09579341e+00, c: 1.65708481e+01, d: -1.11800433e+02, e: 2.84848687e+02)
private let convert_blue = fn(-2.00405927e-01, b: 6.60787192e+00, c: -8.17029806e+01, d: 4.49730683e+02, e: -9.30797032e+02)

func temperatureToRGB(_ temperature: Double) -> (Double, Double, Double) {
    if temperature == 6500 { return (1, 1, 1) }
    return (
        bound(convert_red(temperature)),
        bound((temperature > 6500 ? convert_green_b : convert_green_a)(temperature)),
        bound(convert_blue(temperature))
    )
}
