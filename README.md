# 2019_DEV_112

TenPin Bowling (needed at least OSX Mojave 10.14 + Xcode 10.1)

Clone the repo:

• From Xcode -> Source Control -> Clone...

• Type or Copy/Paste: "kata-dev-tpbowl/2019_DEV_112.git" into address bar

• Save to disk

• Or from Terminal: git clone https://github.com/kata-dev-tpbowl/2019_DEV_112.git


# Building from Xcode

• Buld target "TenPinBowling"

• Product -> Run

# Expected result as output:

Hello, Bowling!

Game  X X X X X X X X X X X X: 300

Game  5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5: 150

Game. 9- 9- 9- 9- 9- 9- 9- 9- 9- 9-: 90

Game. 9- 9- 9- 9- 9- 9- 9- 9- 9- 9/1: 92

# Building in terminal

• cd into project directory

• Run: xcodebuild -project TenPinBowling.xcodeproj -configuration Debug -target TenPinBowling as output 

• That should produce our product in Build->Debug folder: TenPinBowling

• Run ./TenPinBowling

• Or with one param: ./TenPinBowling 6/6/6/6/6/6/6/6/6/6/6  (this should produce 160 as result)

# Tests

• From Xcode by switching scheme and then Product - > Test

• Command line in terminal: xcodebuild -project TenPinBowling.xcodeproj -configuration Debug -scheme TenPinTests test
