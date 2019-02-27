//
//  main.m
//  TenPinBowling
//
//  Created by Karate Bowling (2019_DEV_112) on 24/02/2019.
//  Copyright © 2019 KarateBowling. All rights reserved.
//
//  Class TPFrame + main()
//

#import <Foundation/Foundation.h>

// Definitions & Declarations

#define  kMaxFrames  10

int  calc_bowling (const char *argStr);

#pragma -

int  calc_bowling (const char *argStr)
{
   int  throws[kMaxFrames+2][2] = { {0}, {0} };  // two more for extra throws
   int  bonuses[kMaxFrames][2]  = { {0}, {0} };  // exact num
   
   int  idxThrow=0, idxFrame=0;
   
   if (argStr)  {
      const char  *chPtr = argStr;
      
      while (*chPtr && (idxFrame < kMaxFrames+2))  {  // Two extra, if all Xs
         
         if (toupper(*chPtr) == 'X')  {  // Strike
            if (idxThrow)
               NSLog (@"Something's wrong with 'X'!");
            
            throws[idxFrame][idxThrow] = 10;
            idxThrow = 1;  // So we advance to the next frame
         }
         else  if (isdigit(*chPtr))  {  // Digits
            int  tVal = (int)(*chPtr - '0');
            
            throws[idxFrame][idxThrow] = tVal;
         }
         else  if (*chPtr == '-')  {
            throws[idxFrame][idxThrow] = 0;
         }
         else  if (*chPtr == '/')  {
            int  tVal = 10 - throws[idxFrame][0];
            
            if (!idxThrow)
               NSLog (@"Something's wrong with '/'!");
            throws[idxFrame][idxThrow] = tVal;
         }
         else  {  // Space char or something
            chPtr++;
            continue;
         }
         
         chPtr++;
         idxThrow++;
         if (idxThrow > 1)  {
            idxThrow = 0;
            idxFrame++;
         }
      }
   }
   
   int  sum = 0;
   
   for (idxFrame=0; idxFrame<kMaxFrames; idxFrame++)  {
      if ((throws[idxFrame][0] + throws[idxFrame][1]) == 10)  // Covers both cases
         bonuses[idxFrame][0] = throws[idxFrame+1][0];
      
      if (throws[idxFrame][0] == 10)  // If we're X
         bonuses[idxFrame][1] = (throws[idxFrame+1][0] == 10) ? throws[idxFrame+2][0] : throws[idxFrame+1][1];
      
      sum += throws[idxFrame][0] + throws[idxFrame][1];
      sum += bonuses[idxFrame][0] + bonuses[idxFrame][1];
   }
   
   if (argStr)
      NSLog (@"Game  %s: %d", argStr, sum);
   else
      NSLog (@"No game specified.");

   return (sum);
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
