//
//  HWLocationManager.m
//  TemplateTest
//
//  Created by hw500028 on 4/15/15.
//  Copyright (c) 2015 caijingpeng.haowu. All rights reserved.
//

#import "HWLocationManager.h"
#import <MapKit/MapKit.h>

@interface HWLocationManager()<CLLocationManagerDelegate>

@end

@implementation HWLocationManager

+ (HWLocationManager *)shareManager
{
    
    static HWLocationManager *sharedLoactionManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedLoactionManagerInstance = [[self alloc] init];
    });
    return sharedLoactionManagerInstance;
    
}

- (BOOL)startLocating
{
    if ([CLLocationManager locationServicesEnabled])
    {
        self.manager = [[CLLocationManager alloc]init];
        self.manager.delegate = self;
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
        self.manager.distanceFilter = kCLLocationAccuracyKilometer;
        if (IOS8)
        {
            [self.manager requestWhenInUseAuthorization];
        }
        [self.manager startUpdatingLocation];
        return true;

    }
    return false;
}

#pragma mark - 定位成功以后的回调

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.manager stopUpdatingLocation];
    
    CLLocation *location = [locations lastObject];
    self.coordinate = location.coordinate;
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    __block  CLPlacemark * p;
    self.isLocationSuccess = YES;
    self.isOpenLocator = YES;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
       
        if (error != nil) {
            if (_locationFailed)
            {
                _locationFailed(self.isOpenLocator);
            }

            return;
        }
        NSArray * pm = placemarks;
        if (pm.count > 0)
        {
            p = (CLPlacemark *)pm[0];
            self.cityName = p.locality;
            if ([self.cityName rangeOfString:@"市辖区"].location != NSNotFound)
            {
                NSRange range = [self.cityName rangeOfString:@"市辖区"];
                self.cityName = [self.cityName substringToIndex:range.location];
            }
            
            if ([self.cityName rangeOfString:@"市"].location != NSNotFound)
            {
                NSRange range = [self.cityName rangeOfString:@"市"];
                self.cityName = [self.cityName substringToIndex:range.location];
            }
            
            NSString *sting =[p.name substringWithRange:NSMakeRange(0, 2)];
            if ([sting isEqualToString:@"中国"])
            {
                self.streetName = [p.name substringWithRange:NSMakeRange(2, p.name.length - 2)];
            }
            else
            {
                self.streetName = p.name;
            }
            
            NSArray * address = [p.addressDictionary arrayObjectForKey:@"FormattedAddressLines"];
            self.locationAddress = [address pObjectAtIndex:0];
            
            if (self.locationSuccess)
            {
                _locationSuccess(location,self.cityName,self.streetName);
            }

        }
        else
        {
            NSLog(@"No Placemarks!");
            if (_locationFailed)
            {
                _locationFailed(self.isOpenLocator);
            }


        }
        
        
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationFailNotification object:nil];
    self.isLocationSuccess = NO;
    self.isOpenLocator = NO;
    if (_locationFailed)
    {
        _locationFailed(self.isOpenLocator);
    }

}

+ (BOOL)openAppleMapGuideWithTarget:(CLLocationCoordinate2D)coordinate name:(NSString *)name
{
    //当前的位置
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    //起点
    //MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords1 addressDictionary:nil]];
    //目的地的位置
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
    
    if (name.length == 0) {
        name = @"目的地";
    }
    toLocation.name = name;
    
    NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
    NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey :  [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey : @YES};
    //打开苹果自身地图应用，并呈现特定的item
    return [MKMapItem openMapsWithItems:items launchOptions:options];
}

+ (BOOL)openGaoDeMapGuideWithTarget:(CLLocationCoordinate2D)coordinate name:(NSString *)name
{
    NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2", @"好屋中国", @"urlScheme", coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

+ (BOOL)openBaiduMapGuideWithTarget:(CLLocationCoordinate2D)coordinate name:(NSString *)name
{
    NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

+ (BOOL)openGoogleMapGuideWithTarget:(CLLocationCoordinate2D)coordinate name:(NSString *)name
{
    NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"好屋中国",@"urlScheme",coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

@end
