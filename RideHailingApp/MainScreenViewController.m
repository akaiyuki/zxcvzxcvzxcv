//
//  MainScreenViewController.m
//  RideHailingApp
//
//  Created by AV Dev on 26/07/2017.
//  Copyright © 2017 AV Dev. All rights reserved.
//

#import "MainScreenViewController.h"

#import <GooglePlaces/GooglePlaces.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>



@interface MainScreenViewController () <GMSAutocompleteViewControllerDelegate, MKMapViewDelegate,GMSMapViewDelegate>

@property (nonatomic, strong) UILabel *txtFromLocation;
@property (nonatomic, strong) UILabel *txtDestination;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) UIButton *btnRequest;
@property (nonatomic, strong) UIImageView *imgTimer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UITextView *txtTimer;
@property (nonatomic, strong) UILabel *txtStatus;

@property (nonatomic, retain) NSString *isDestination;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, weak) NSString *city;
@property (nonatomic, strong) NSString *cityLat;
@property (nonatomic, strong) NSString *cityLon;
@property (nonatomic, strong) NSString *destinationLat;
@property (nonatomic, strong) NSString *destinationLon;
@property (nonatomic, strong) NSString *currentAddress;
@property (nonatomic, strong) NSString *destinationAddress;

@property (nonatomic, retain) MKPolyline *routeLine;
@property (nonatomic, retain) MKPolylineView *routeLineView;


@property (nonatomic) double *userLat;
@property (nonatomic) double *userLon;
@property (nonatomic) CLPlacemark *currentLat;
@property (nonatomic) CLPlacemark *currentLon;

@property (nonatomic) NSString *isTimerActive;
@property (nonatomic, strong) UITextView *txtRefreshTimer;

@property (nonatomic) MKPlacemark *currentMark;

@property (nonatomic, strong) UITextView *txtCountdown;
@property (nonatomic) NSString *urlstring;



@end

@implementation MainScreenViewController

-(void)viewDidLoad{
    
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.distanceFilter = kCLDistanceFilterNone;
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
//    [self.locationManager startUpdatingLocation];
//    
//    self.locationManager.location.coordinate.latitude;
//    self.locationManager.location.coordinate.longitude;
//
//    self.userLat = [NSNumber numberWithDouble: self.locationManager.location.coordinate.latitude];

    
//    NSLog(self.locationManager.location.coordinate.longitude);
    
}

-(void)loadView{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, 0, 450, 70)];
    [toolbar setBarStyle:UIBarStyleBlackOpaque];
    [self.view addSubview:toolbar];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100/2, 30, 400, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.text = @"Ride Hailing";
    label.font = [UIFont boldSystemFontOfSize:20.0];
//    UIBarButtonItem *toolBarTitle = [[UIBarButtonItem alloc] initWithCustomView:label];
    [self.view addSubview:label];
    [self.view bringSubviewToFront:label];
    
    //end
    
    
    
    //from location
    self.txtFromLocation = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 300/2, [UIScreen mainScreen].bounds.size.height - 260, [UIScreen mainScreen].bounds.size.width - 100, 50)];
    self.txtFromLocation.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    self.txtFromLocation.backgroundColor=[UIColor whiteColor];
    self.txtFromLocation.text = @"Enter Current Location";
    self.txtFromLocation.textColor = [UIColor grayColor];
    [self.view addSubview:self.txtFromLocation];
    [self.view bringSubviewToFront:self.txtFromLocation];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchFunction)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.txtFromLocation addGestureRecognizer:tapGestureRecognizer];
    self.txtFromLocation.userInteractionEnabled = YES;
    //end
    
    //divider
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 100, 30)];
    
    line.userInteractionEnabled = NO;
    line.backgroundColor = [UIColor blackColor];
    
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:line];
    //end divider
    
    //text destination
    self.txtDestination = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 300/2, self.txtFromLocation.frame.origin.y+50, 300, 50)];
    self.txtDestination.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    self.txtDestination.backgroundColor = [UIColor whiteColor];
    self.txtDestination.text = @"Enter Destination";
    self.txtDestination.textColor = [UIColor grayColor];
    [self.view addSubview:self.txtDestination];
    
    UITapGestureRecognizer *tapDestination = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchFunctionDestination)];
    tapDestination.numberOfTapsRequired = 1;
    [self.txtDestination addGestureRecognizer:tapDestination];
    self.txtDestination.userInteractionEnabled = YES;
    //end destination
    
    
    //button for request
    self.btnRequest = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-60, [UIScreen mainScreen].bounds.size.width, 60)];
    [self.btnRequest setTitle:@"Request" forState:UIControlStateNormal];
    [self.btnRequest setBackgroundColor: [UIColor greenColor]];
    [self.btnRequest addTarget:self action:@selector(requestApiAddRequest:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnRequest];
    //end button request

    //status label
    self.txtStatus = [[UILabel alloc] initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 320, 300, 50)];
    self.txtStatus.text = @"Where to?";
    self.txtStatus.textColor = [UIColor blackColor];
    self.txtStatus.font = [UIFont boldSystemFontOfSize:20.0];
    self.txtStatus.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.txtStatus];
    //end status label
    
    //initialize map view
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 350)];
    
    CLLocationCoordinate2D poiCoordinates;
//    poiCoordinates.latitude = 14.425940;
//    poiCoordinates.longitude = 121.027473;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.locationManager startUpdatingLocation];
    
    
    
//    if (self.locationManager.location.coordinate.latitude != @"") {
        poiCoordinates.latitude =  self.locationManager.location.coordinate.latitude;
        poiCoordinates.longitude = self.locationManager.location.coordinate.longitude;
//    }
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(poiCoordinates, 500, 500);
    self.mapView.delegate = self;
    [self.mapView setRegion:viewRegion animated:YES];
    [self.view addSubview:self.mapView];
    
    [self.view bringSubviewToFront:self.txtFromLocation];
    [self.view bringSubviewToFront:self.btnRequest];
    [self.view bringSubviewToFront:self.txtDestination];
    [self.view bringSubviewToFront:self.txtStatus];
    
    
    //progress bar
    self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    self.indicator.center = self.view.center;
    self.indicator.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.indicator];
    [self.indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    //end progress bar
    
    
    
}

-(void)requestApiAddRequest:(id)sender{
    
    [self.indicator startAnimating];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults valueForKey:@"user_name"];
    NSString *userMobile = [defaults valueForKey:@"user_mobile"];
    NSString *userId = [defaults valueForKey:@"user_id"];
    
    if (![self.txtFromLocation.text  isEqualToString: @"Enter Current Location"] && ![self.txtDestination.text  isEqualToString: @"Enter Destination"]) {
        
        
        NSString *baseURL = @"https://av-ridehail.herokuapp.com/user/addRequest";
        NSDictionary *parameters =  @{@"from_location": self.txtFromLocation.text,
                                      @"destination": self.txtDestination.text,
                                      @"username": userName,
                                      @"mobile": userMobile,
                                      @"user_id": userId,
                                      @"status": @"Requesting",
                                      @"current_lat": self.cityLat,
                                      @"current_lon": self.cityLon,
                                      @"destination_lat": self.destinationLat,
                                      @"destination_lon": self.destinationLon,
                                      @"current_address": self.currentAddress,
                                      @"destination_address": self.destinationAddress};
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        [manager POST:baseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@", responseObject);
            
            [self.indicator stopAnimating];
            
            NSDictionary *dictionary = [responseObject objectForKey:@"data"];
            NSString *requestId = dictionary[@"_id"];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:requestId forKey:@"request_id"];
            [defaults synchronize];

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                            message:@"Request Sent Successfully!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
            self.txtStatus.text = @"Requesting";
            
            self.isTimerActive = @"true";
        
            
            self.txtTimer = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-150, CGRectGetMaxY(self.view.frame)-310, 100, 50)];
            self.txtTimer.backgroundColor = [UIColor blueColor];
            self.txtTimer.textColor = [UIColor whiteColor];
            self.txtTimer.font = [UIFont boldSystemFontOfSize:30.0];
            self.txtTimer.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
            [self.view addSubview:self.txtTimer];
            [self.view bringSubviewToFront:self.txtTimer];
            
            
            self.txtTimer.text = @"00:00";
           
            
            
            //start
            self.txtCountdown = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-200, CGRectGetMaxY(self.view.frame)-310, 150, 50)];
            self.txtCountdown.backgroundColor = [UIColor clearColor];
            self.txtCountdown.textColor = [UIColor clearColor];
            self.txtCountdown.font = [UIFont boldSystemFontOfSize:27.0];
            self.txtCountdown.contentInset = UIEdgeInsetsMake(20, 30, 20, 20);
            [self.view addSubview:self.txtCountdown];
            [self.view bringSubviewToFront:self.txtCountdown];
            
            
            self.txtCountdown.text = @"300";
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
            //end
            
            
            
            //call for refresh timer
            self.txtRefreshTimer = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-80, CGRectGetMaxY(self.view.frame)-150, 50, 50)];
            self.txtRefreshTimer.backgroundColor = [UIColor whiteColor];
            self.txtRefreshTimer.textColor = [UIColor whiteColor];
            self.txtRefreshTimer.font = [UIFont boldSystemFontOfSize:30.0];
            self.txtRefreshTimer.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
            [self.view addSubview:self.txtRefreshTimer];
            [self.view bringSubviewToFront:self.txtRefreshTimer];
            
            
            self.txtRefreshTimer.text = @"10";
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshCountDown:) userInfo:nil repeats:YES];
            //end
            
            
            
            //disable button
            self.btnRequest.userInteractionEnabled = NO;
            [self.btnRequest setTitle:@"Cancel Request" forState:UIControlStateNormal];
            [self.btnRequest setBackgroundColor: [UIColor grayColor]];

            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error: %@", error);
            [self.indicator stopAnimating];
        }];
    
        
    } else {
        
        [self.indicator stopAnimating];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                        message:@"Please input location and destination"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
  
        
    }
    
    
}

-(void)countDown:(NSTimer *) aTimer {
    NSInteger CountNumber = [self.txtCountdown.text  intValue] - 1;
    NSInteger seconds = CountNumber % 60;
    NSInteger minutes = (CountNumber / 60) % 60;
    
//    self.txtTimer.text = [NSString stringWithFormat:@"%d",[self.txtTimer.text  intValue] - 1];
    
    self.txtTimer.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes,(long)seconds];
    
    self.txtCountdown.text = [NSString stringWithFormat:@"%d",[self.txtCountdown.text  intValue] - 1];
    
    if ([self.txtCountdown.text isEqualToString:@"0"]) {
        //enable button when timer reached 0
        self.txtTimer.hidden = YES;
        self.btnRequest.userInteractionEnabled = YES;
        [self.btnRequest setTitle:@"Request" forState:UIControlStateNormal];
        [self.btnRequest setBackgroundColor: [UIColor greenColor]];
        
        self.isTimerActive = @"false";
//        self.txtStatus.text = @"No Ride Available";

        [aTimer invalidate];
    }
}

//refresh fetch api call every 10 seconds
-(void)refreshCountDown:(NSTimer *) mTimer{
    self.txtRefreshTimer.text = [NSString stringWithFormat:@"%d",[self.txtRefreshTimer.text  intValue] - 1];
    if([self.txtRefreshTimer.text isEqualToString:@"0"] && [self.isTimerActive isEqualToString:@"true"]){
        [mTimer invalidate];
        [self requestApiFetchStatus];
    } else if ([self.isTimerActive isEqualToString:@"false"]){
        [mTimer invalidate];
    }
}

//fetch status
-(void)requestApiFetchStatus{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *requestId = [defaults valueForKey:@"request_id"];
    
    NSString *baseURL = @"https://av-ridehail.herokuapp.com/user/getRequest";
    NSDictionary *parameters =  @{@"request_id": requestId};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:baseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        NSDictionary *dictionary = [responseObject objectForKey:@"data"];
        NSString *status = dictionary[@"status"];
        
        NSLog(@"%@", status);
        
        
        self.txtRefreshTimer.text = @"10";
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshCountDown:) userInfo:nil repeats:YES];
        
        
        
        self.txtStatus.text = status;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
    }];

    
    
    
}


//google place search
// Present the autocomplete view controller when the textfield is pressed.
- (void)searchFunction{
    self.isDestination = @"false";
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
}

- (void)searchFunctionDestination{
    self.isDestination = @"true";
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
}

// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    NSLog(@"Place lattitude %f", place.coordinate.latitude);
    NSLog(@"Place longitude %f", place.coordinate.longitude);
    
    
    if ([self.isDestination isEqualToString:@"false"]) {
        self.txtFromLocation.text = place.name;
        self.city = place.name;
        
        self.currentAddress = place.formattedAddress;
        
        
        //trial
        self.cityLat = [NSString stringWithFormat:@"%.7f", place.coordinate.latitude];
        
        self.cityLon = [NSString stringWithFormat:@"%.7f", place.coordinate.longitude];
        
        
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:place.coordinate.latitude
                                                                longitude:place.coordinate.longitude
                                                                     zoom:15];
        
        GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 350) camera:camera];
        
        [self.view addSubview:mapView];
        [self.view bringSubviewToFront:mapView];
        [self.view bringSubviewToFront:self.txtStatus];
        
        
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude);
        GMSMarker *marker = [GMSMarker markerWithPosition:position];
        marker.map = mapView;
        
        //end
        
        //end

        
        
    } else {
        self.txtDestination.text = place.name;
        self.city = place.name;
        
        self.destinationAddress = place.formattedAddress;
        
       
        
        //trial
        self.destinationLat = [NSString stringWithFormat:@"%.7f", place.coordinate.latitude];
        
        self.destinationLon = [NSString stringWithFormat:@"%.7f", place.coordinate.longitude];
        
        NSLog(@"destination lat: %@", self.destinationLat);
        
        
//        CLLocationCoordinate2D poiCoordinates;
//        
//        self.locationManager = [[CLLocationManager alloc] init];
//        self.locationManager.distanceFilter = kCLDistanceFilterNone;
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
//        [self.locationManager startUpdatingLocation];
////
//        MKPlacemark *newMark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude)];
//        MKPlacemark *mkMark = [[MKPlacemark alloc] initWithPlacemark:newMark];
////
////        
////        
////        //    if (self.locationManager.location.coordinate.latitude != @"") {
//        poiCoordinates.latitude =  place.coordinate.latitude;
//        poiCoordinates.longitude = place.coordinate.longitude;
////        //    }
////        
//        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(poiCoordinates, 500, 500);
        
        
//        CLLocationCoordinate2D pinlocation=self.mapView.userLocation.coordinate;
//        
//        pinlocation.latitude = [self.cityLat doubleValue];;
//        
//        pinlocation.longitude = [self.cityLon doubleValue];
//        
//        CLLocationCoordinate2D coordinateArray[2];
//        coordinateArray[0] = CLLocationCoordinate2DMake(pinlocation.latitude, pinlocation.longitude);
//        coordinateArray[1] = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude);
////
//        self.routeLine = [MKPolyline polylineWithCoordinates:coordinateArray count:2];
        
        
        // removing old overlays and adding new
//        [self.mapView removeOverlays:self.mapView.overlays]; // removes all overlays
//        [self.mapView removeAnnotations:self.mapView.annotations]; // removes all pins
        
//        [self.mapView setRegion:viewRegion animated:YES];
//        [self.mapView addAnnotation:mkMark];
//        [self.mapView addAnnotation:self.currentMark];
//        [self.mapView setVisibleMapRect:[self.routeLine boundingMapRect]];
//        [self.mapView addOverlay:self.routeLine];
        
        
        //start
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:place.coordinate.latitude
                                                                longitude:place.coordinate.longitude
                                                                     zoom:15];
        
        GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 350) camera:camera];

        
        
        //end
        
        
        //start
        NSString *urlString = [NSString stringWithFormat:@"%@?origin=%@,%@&destination=%@,%@&mode=driving", @"https://maps.googleapis.com/maps/api/directions/json", self.cityLat, self.cityLon, self.destinationLat, self.destinationLon];
        

        NSURL* url = [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLResponse* res;
        NSError* err;
        NSData* data = [NSURLConnection sendSynchronousRequest:[[NSURLRequest alloc] initWithURL:url] returningResponse:&res error:&err];
        if (data == nil) {
            NSLog(@"null data");
            return;
        }
        
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary* routes = [dic objectForKey:@"routes"][0];
        NSDictionary* route = [routes objectForKey:@"overview_polyline"];
        NSString* overview_route = [route objectForKey:@"points"];

        GMSPath* path = [GMSPath pathFromEncodedPath:overview_route];
        
        
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeColor = [UIColor redColor];
        polyline.strokeWidth = 5.f;
        polyline.map = mapView;
        
        [self.view addSubview:mapView];
        [self.view bringSubviewToFront:mapView];
        [self.view bringSubviewToFront:self.txtStatus];

        
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude);
        GMSMarker *marker = [GMSMarker markerWithPosition:position];
        marker.map = mapView;
        
        
        CLLocationCoordinate2D position2 = CLLocationCoordinate2DMake([self.cityLat doubleValue],  [self.cityLon doubleValue]);
        GMSMarker *marker2 = [GMSMarker markerWithPosition:position2];
        marker2.map = mapView;
       
        
        //end
        
        
    }
    

    
}




- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//end






@end
