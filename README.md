# 2019_DEV_112

TenPin Bowling

Clone the repo:

• From Xcode -> Source Control -> Clone...

• Type or Copy/Paste: "kata-dev-tpbowl/2019_DEV_112.git" into address bar

• Save to disk


# Building:

A) From Xcode

• Buld target "TenPinBowling"

B) From Terminal

• cd into project directory

• Run: xcodebuild -project TenPinBowling.xcodeproj -configuration Debug -target TenPinBowlin as outputg 

• That would copy the product into the same directory under name "TenPinBowlingApp"

• Run ./TenPinBowlingApp

• Or with one param: ./TenPinBowlingApp 6/6/6/6/6/6/6/6/6/6/6  (this should produce 160 as result)

# Expected result as output:

Hello, Bowling!

Ten Pin Bowling Test: 300

Ten Pin Bowling Test: 150

Ten Pin Bowling Test: 90

Ten Pin Bowling Test: 92

# Tests

• From Xcode or command line: xcodebuild -project TenPinBowling.xcodeproj -configuration Debug -scheme TenPinTests test