//
//  MapAnnatation.h
//  MapTests
//
//  Created by Gevorg Hovhannisyan on 8/19/21.
//  Copyright © 2021 Gevorg Hovhannisyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface MapAnnatation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;



@end

