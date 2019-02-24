//
//  main.m
//  TenPinBowling
//
//  Created by Karate Bowling on 24/02/2019.
//  Copyright © 2019 KarateBowling. All rights reserved.
//
//  Class TPFrame + main()
//

#import <Foundation/Foundation.h>

// Definitions & Declarations

#define  kMaxFrames  10

int calc_bowling (const char *argStr);

#pragma -

// --------------------------------------- TPFrame
@interface TPFrame : NSObject

@property (nonatomic, assign)  NSInteger  throwOne;
@property (nonatomic, assign)  NSInteger  throwTwo;

@property (nonatomic, assign)  NSInteger  bonusOne;
@property (nonatomic, assign)  NSInteger  bonusTwo;

@end

@implementation TPFrame

// input can be X or 5- or 1/ --> 10,0; 5,0; 1,9;

- (id)initWithString:(NSString *)strFrame
{
   if (self = [super init])  {
      if (strFrame.length && strFrame.length <= 3)  {
         NSString  *strOne = [strFrame substringToIndex:1];
         NSString  *strTwo = (strFrame.length > 1) ? [strFrame substringWithRange:NSMakeRange(1, 1)] : @"-";
         NSString  *strExtra = (strFrame.length == 3) ? [strFrame substringFromIndex:2] : @"-";
         
         if ([strOne isEqualToString:@"X"])  {
            self.throwOne = 10;
            self.bonusOne = [strTwo integerValue];
            if ([strExtra isEqualToString:@"/"])
               self.bonusTwo = 10 - self.throwOne;
            else  if (![strExtra isEqualToString:@"-"])
               self.bonusTwo = [strTwo integerValue];
            else
               self.bonusTwo = [strTwo integerValue];
         }
         else  {
            self.throwOne = [strOne integerValue];
            
            if ([strTwo isEqualToString:@"/"])
               self.throwTwo = 10 - self.throwOne;
            else  if (![strTwo isEqualToString:@"-"])
               self.throwTwo = [strTwo integerValue];
            self.bonusOne = [strExtra integerValue];
         }
      }
   }
   
   return (self);
}

// When used with both bonus params we check if we deserve a bonus
// Otherwise, we assume recursion

+ (BOOL)getBonusesFromArray:(NSArray *)framesArray
                    atIndex:(NSUInteger)idx
                   bonusOne:(NSUInteger *)b1
                   bonusTwo:(nullable NSUInteger *)b2orNull;
{
   TPFrame     *curFrame = [framesArray objectAtIndex:idx];  // or  framesArray[idx];
   TPFrame     *nxtFrame = nil;
   NSUInteger   needBonusLevel = 0;
   
   *b1 = 0;
   if (b2orNull)
      *b2orNull = 0;
   else  {
      // We're in recursive level, don't check if we deserve a bonus
      needBonusLevel = 1;
   }
   
   if (idx > (kMaxFrames-1))  // Overflow
      return (NO);
   
   if (!needBonusLevel)  {
      if (curFrame.throwOne == 10)  // Strike
         needBonusLevel = 2;
      else  if ((curFrame.throwOne + curFrame.throwTwo) == 10)  // Spare
         needBonusLevel = 1;
      else
         return (NO);  // No bonus for you!
   }
   
   if (idx == (kMaxFrames-1))  {  // Last item (frame), already have proper bonuses
      *b1 = curFrame.bonusOne;
      if (b2orNull)
         *b2orNull = curFrame.bonusTwo;
      return (YES);
   }
   
   // For other frames we need the next frame
   
   nxtFrame = [framesArray objectAtIndex:idx+1];
   
   *b1 = nxtFrame.throwOne;
   
   if (b2orNull && (needBonusLevel == 2))  {
      if (nxtFrame.throwOne < 10)
         *b2orNull = nxtFrame.throwTwo;
      else
         if (![self getBonusesFromArray:framesArray
                                atIndex:idx+1
                               bonusOne:b2orNull
                               bonusTwo:NULL])
            NSLog (@"Ups, something went wrong!");
   }
   
   return (YES);
}

- (NSUInteger)frameSum
{
   return (self.throwOne + self.throwTwo + self.bonusOne + self.bonusTwo); // Spare
}

@end

#pragma -

int  calc_bowling (const char *argStr)
{
   NSString        *inputStr = @"X X X X X X X X X X X X";  // 12 x X
   NSMutableArray  *frameStrings = [NSMutableArray arrayWithCapacity:kMaxFrames];
   
   if (argStr)  {
      const char  *chPtr = argStr;
      
      while (*chPtr)  {  // Two extra, maybe
         
         if (toupper(*chPtr) == 'X')  {  // Strike
            [frameStrings addObject:@"X"];
            chPtr++;
         }
         else  if (isdigit(*chPtr))  {  // Handles both "6-" &&  "6/"
            int  len = 1;
            
            if (frameStrings.count == kMaxFrames-1)
               len = (int)strlen (chPtr);
            else  if (isdigit(*chPtr+1) || *(chPtr+1) == '/' || *(chPtr+1) == '-')
               len = 2;
            [frameStrings addObject:[NSString stringWithFormat:@"%.*s", len, chPtr]];
            chPtr += len;
         }
         else  if (*chPtr == '-')  {  // Handles both "-" && "--", not sure how double miss is marked
            int  len = 1;
            
            if (*(chPtr+1) == '/' || *(chPtr+1) == '-')
               len = 2;
            [frameStrings addObject:[NSString stringWithFormat:@"%.*s", len, chPtr]];
            chPtr += len;
         }
         else
            chPtr++;
      }
      
      NSLog (@"Ten Pin Bowling Test: %@", frameStrings);
   }
   
   NSArray   *strFrames = argStr ? frameStrings : [inputStr componentsSeparatedByString:@" "];
   NSString  *oneStrFrame = nil;
   TPFrame   *aFrame = nil;
   
   NSMutableArray  *framesArray = [NSMutableArray array];
   
   for (int i=0; i<kMaxFrames+2 && i<strFrames.count; i++)  {  // Two extra, maybe
      oneStrFrame = [strFrames objectAtIndex:i];
      if (i < 10)  {
         aFrame = [[TPFrame alloc] initWithString:oneStrFrame];
         if (aFrame)
            [framesArray addObject:aFrame];
      }
      else  {
         NSUInteger  bonus = [oneStrFrame isEqualToString:@"X"] ? 10 : [oneStrFrame integerValue];
         
         if (i==10)
            aFrame.bonusOne = bonus;
         else
            aFrame.bonusTwo = bonus;
      }
   }
   
   if (framesArray.count < 10)
      NSLog (@"Wrong number of parameters!");
   
   NSUInteger  sum = 0;
   
   for (int i=0; i<kMaxFrames && i<framesArray.count; i++)  {
      NSUInteger  b1, b2;
      
      aFrame = [framesArray objectAtIndex:i];
      
      [TPFrame getBonusesFromArray:framesArray
                           atIndex:i
                          bonusOne:&b1
                          bonusTwo:&b2];
      
      aFrame.bonusOne = b1;
      aFrame.bonusTwo = b2;
      
      sum += [aFrame frameSum];
   }
   
   NSLog (@"Game sum is: %lu", (unsigned long)sum);
   
   return (0);
}
#pragma - main

int  main (int argc, const char * argv[])
{
   @autoreleasepool  {
      
      NSLog (@"Hello, Bowling!");

      if (argc == 2)
         calc_bowling (argv[1]);
      else  {
         calc_bowling ("X X X X X X X X X X X X");         // 300
         calc_bowling ("5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5");  // 150
         calc_bowling ("9- 9- 9- 9- 9- 9- 9- 9- 9- 9-");   // 90
         calc_bowling ("9- 9- 9- 9- 9- 9- 9- 9- 9- 9/1");  // 92
      }

   }
   
   return (0);
}
