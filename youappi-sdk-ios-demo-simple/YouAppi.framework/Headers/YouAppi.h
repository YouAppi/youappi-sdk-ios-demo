//
//  YouAppi.h
//  YouAppi
//
//  Created by Itamar Menahem on 10/29/17.
//  Copyright © 2017 YouAppi. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for YouAppi.
FOUNDATION_EXPORT double YouAppiVersionNumber;

//! Project version string for YouAppi.
FOUNDATION_EXPORT const unsigned char YouAppiVersionString[];

#if MOAT

#import "YouAppiMoat/YouAppi.h"

#else

#import "YouAppi/YouAppi.h"
#endif

