//
//  ViewController.m
//  MapTests
//
//  Created by Gevorg Hovhannisyan on 8/19/21.
//  Copyright © 2021 Gevorg Hovhannisyan. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MapAnnatation.h"

@interface ViewController () <MKMapViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionAdd:)];
    /*
    UIBarButtonItem* zoomButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(actionAdd:)];
    
    UIBarButtonItem* fixed = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:@selector(actionAdd:)];
     
    
    fixed.width = 50;
    */
    
    self.navigationItem.rightBarButtonItem = addButton;
//    self.navigationItem.rightBarButtonItem = zoomButton;
//    self.navigationItem.rightBarButtonItem = fixed;

    
}

#pragma mark - Action

- (void) actionAdd: (UIBarButtonItem*) sender {
    
    MapAnnatation* annotation = [[MapAnnatation alloc] init];
    
    annotation.title = @"Test Title";
    annotation.title = @"Test Subtitle";
    annotation.coordinate = self.mapView.region.center;
    
    [self.mapView addAnnotation:annotation];

}

- (void) actionShowAll:(UIBarButtonItem*) sender {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annatation in self.mapView.annotations) {
        
        CLLocationCoordinate2D location = annatation.coordinate;
        MKMapPoint center = MKMapPointForCoordinate(location);
        static double delta = 20000;
        
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
        
        zoomRect = MKMapRectUnion(zoomRect, rect);
        
    }
    
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(50, 50, 50, 50) animated:YES];
    
}


#pragma mark -  MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString* identifire = @"Annatation";
        MKPinAnnotationView* pin = (MKPinAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:identifire];
    
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifire];
//      pin.pinColor = MKPinAnnotationColorPurple;
        pin.animatesDrop = YES;
        pin.canShowCallout = YES;
        pin.draggable = YES;
        
        UIButton* descriptionButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [descriptionButton addTarget:self action:@selector(actionDescription:) forControlEvents:UIControlEventTouchUpInside];
        
        pin.rightCalloutAccessoryView = descriptionButton;


    } else {
      
        pin.annotation = annotation;
    }
    return pin;
}


#pragma mark - Action

- (void) actionDescription:(UIButton*) sender {
    
    NSLog(@"actionDescription");
    
}

/*
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
    NSLog(@"regionWillChangeAnimated");
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    NSLog(@"regionDidChangeAnimated");

}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView {
    
    NSLog(@"mapViewWillStartLoadingMap");

}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    
    NSLog(@"mapViewDidFinishLoadingMap");

}
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error {
    
    NSLog(@"mapViewDidFailLoadingMap");

}

- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView {
    
    NSLog(@"mapViewWillStartRenderingMap");

}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
    
    NSLog(@"mapViewDidFinishRenderingMap fullyRendered = %d", fullyRendered);

}
*/

@end
