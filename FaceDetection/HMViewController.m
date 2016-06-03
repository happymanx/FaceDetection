//
//  HMViewController.m
//  FaceDetection
//  Learn from: http://maniacdev.com/
//  Created by HappyMan on 13/12/14.
//  Copyright (c) 2013年 HappyMan. All rights reserved.
//

#import "HMViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface HMViewController ()

@end

@implementation HMViewController

- (id)init
{
    self = [super initWithNibName:@"HMViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}
/**
 Theme: Face Detection
 IDE: Xcode 5
 Language: Objective C
 Date: 102/12/12
 Author: HappyMan
 Blog: http://cg2010studio.wordpress.com/
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self faceDetector];
}

-(void)markFaces:(UIImageView *)facePicture
{
    // draw a CI image with the previously loaded face detection picture
    CIImage* image = [CIImage imageWithCGImage:facePicture.image.CGImage];
    
    // create a face detector - since speed is not an issue we'll use a high accuracy
    // detector
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];
    
    // create an array containing all the detected faces from the detector
    NSArray* features = [detector featuresInImage:image];
    
    // we'll iterate through every detected face.  CIFaceFeature provides us
    // with the width for the entire face, and the coordinates of each eye
    // and the mouth if detected.  Also provided are BOOL's for the eye's and
    // mouth so we can check if they already exist.
    for(CIFaceFeature* faceFeature in features)
    {
        // get the width of the face
        CGFloat faceWidth = faceFeature.bounds.size.width;
        
        // create a UIView using the bounds of the face
        UIView* faceView = [[UIView alloc] initWithFrame:faceFeature.bounds];
        
        // add a border around the newly created UIView
        faceView.layer.borderWidth = 3;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];
        
        // add the new view to create a box around the face
        [self.imageView addSubview:faceView];
        
        if(faceFeature.hasLeftEyePosition)
        {
//            // create a UIView with a size based on the width of the face
//            UIView* leftEyeView = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.leftEyePosition.x-faceWidth*0.15, faceFeature.leftEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
//            // change the background color of the eye view
//            [leftEyeView setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
//            // set the position of the leftEyeView based on the face
//            [leftEyeView setCenter:faceFeature.leftEyePosition];
//            // round the corners
//            leftEyeView.layer.cornerRadius = faceWidth*0.15;
//            // add the view to the window
//            [self.imageView addSubview:leftEyeView];
            
            UIImageView *starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(faceFeature.leftEyePosition.x, faceFeature.leftEyePosition.y, faceWidth*0.12, faceWidth*0.12)];
            starImageView.center = CGPointMake(faceFeature.leftEyePosition.x, faceFeature.leftEyePosition.y);
            [starImageView setImage:[UIImage imageNamed:@"Contact lenses.png"]];
            [self.imageView addSubview:starImageView];
        }
        
        if(faceFeature.hasRightEyePosition)
        {
//            // create a UIView with a size based on the width of the face
//            UIView* leftEye = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.rightEyePosition.x-faceWidth*0.15, faceFeature.rightEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
//            // change the background color of the eye view
//            [leftEye setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
//            // set the position of the rightEyeView based on the face
//            [leftEye setCenter:faceFeature.rightEyePosition];
//            // round the corners
//            leftEye.layer.cornerRadius = faceWidth*0.15;
//            // add the new view to the window
//            [self.imageView addSubview:leftEye];
            
            UIImageView *starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(faceFeature.leftEyePosition.x, faceFeature.leftEyePosition.y, faceWidth*0.12, faceWidth*0.12)];
            starImageView.center = CGPointMake(faceFeature.rightEyePosition.x, faceFeature.rightEyePosition.y);
            [starImageView setImage:[UIImage imageNamed:@"Contact lenses.png"]];
            [self.imageView addSubview:starImageView];

        }
        
        if(faceFeature.hasMouthPosition)
        {
//            // create a UIView with a size based on the width of the face
//            UIView* mouth = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.mouthPosition.x-faceWidth*0.2, faceFeature.mouthPosition.y-faceWidth*0.2, faceWidth*0.4, faceWidth*0.4)];
//            // change the background color for the mouth to green
//            [mouth setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.3]];
//            // set the position of the mouthView based on the face
//            [mouth setCenter:faceFeature.mouthPosition];
//            // round the corners
//            mouth.layer.cornerRadius = faceWidth*0.2;
//            // add the new view to the window
//            [self.imageView addSubview:mouth];
        }
    }
}

-(void)faceDetector
{
    // Load the picture for face detection
    UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"may.jpg"]];
    
    // Draw the face detection image
    [self.imageView addSubview:image];
    
    // Execute the method used to markFaces in background
    [self performSelector:@selector(markFaces:) withObject:image];
    
    // flip image on y-axis to match coordinate system used by core image
    [image setTransform:CGAffineTransformMakeScale(1, -1)];
    
    // flip the entire window to make everything right side up
    [self.imageView setTransform:CGAffineTransformMakeScale(1, -1)];
//    self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2 * 2);
}

@end
