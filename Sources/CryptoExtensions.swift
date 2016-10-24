
import Foundation

#if os(Linux) || os(FreeBSD)
    import Glibc
#else
    import Darwin
#endif

func random(_ range: ClosedRange<Int>) -> Int {
    let (min, max) = (Int(range.lowerBound), Int(range.upperBound))
    #if os(Linux) || os(FreeBSD)
        return min + Int(random() % ((max - min) + 1))
    #else
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    #endif
}

func random(_ count: Int) -> Int {
    return random(0...count-1)
}

public class Crypto {
    
    private static func read(numBytes: Int) -> [Int8] {
        var bytes = [Int8](repeating: 0, count: numBytes + 1)
        let randomFile = fopen("/dev/urandom", "r")
        fgets(&bytes, numBytes+1, randomFile)
        fclose(randomFile)
        bytes.removeLast()
        return bytes
    }
    
    private static func random(numBytes: Int) -> [UInt8] {
        let readBytes = read(numBytes: numBytes)
        return unsafeBitCast(readBytes, to: [UInt8].self)
    }
    
    // Get a 16bit random secure token string
    public static var secureToken: String {
        return Data(bytes: random(numBytes: 16)).base64EncodedString()
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
    }
    
}
