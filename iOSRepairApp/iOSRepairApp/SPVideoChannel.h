//
//  MSChannel.h
//  
//
//  Created by Tyler Lu on 9/9/15.
//
//

#import <core/core.h>


@interface SPVideoChannel : MSOrcBaseEntity<MSOrcInteroperableWithDictionary>

@property (copy, nonatomic, readwrite, getter=Id, setter=setId:) NSString *Id;
@property (copy, nonatomic, readwrite, getter=Title, setter=setTitle:) NSString *Title;

@end