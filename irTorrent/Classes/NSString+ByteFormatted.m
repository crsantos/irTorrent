//
//  NSString+ByteFormatted.m
//  irTorrent
//
//  Created by Carlos Ricardo on 3/8/12.
//  Based on Diederik Hoogenboom FileSizeTransformer - http://stackoverflow.com/users/118908/diederik-hoogenboom
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import "NSString+ByteFormatted.h"

@implementation NSString (ByteFormatted)

/**
    @method get the ammount of bytes formatted in the best-matching unit
    @return A NSString representation of bytes with the unit included
 */
- (NSString*) formattedBytes{
    
    double convertedValue = [self doubleValue];
    int multiplyFactor = 0;
    
    NSArray *tokens = [NSArray arrayWithObjects:@"B",@"KB",@"MB",@"GB",@"TB",nil];
    
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    
    return [NSString stringWithFormat:@"%f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
}

@end
