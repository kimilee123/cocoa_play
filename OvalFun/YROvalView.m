//
//  YROvalView.m
//  OvalFun
//

#import "YROvalView.h"

@implementation YROvalView

#pragma mark Hi, I'm YROvalView! Who're you?

- (id)initWithFrame:(NSRect)frame {
  NSLog(@"- initWithFrame:]");
  if (![super initWithFrame:frame])
    return nil;
  
  return self;
}

#pragma mark Things go clicky-click

- (void)mouseDown:(NSEvent *)event {
  NSPoint p = [event locationInWindow];
  NSLog(@"- mouseDragged:%@]", NSStringFromPoint(p));
  downPoint = [self convertPoint:p fromView:nil];
  currentPoint = downPoint;
  [self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)event {
  NSPoint dragToPoint = [event locationInWindow];
  NSLog(@"- mouseDragged:%@]", NSStringFromPoint(dragToPoint));
  currentPoint = [self convertPoint:dragToPoint fromView:nil];
  [self autoscroll:event];
  [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)event {
  NSPoint upPoint = [event locationInWindow];
  NSLog(@"- mouseUp:%@]", NSStringFromPoint(upPoint));
  
  // Set the two points the same, to ensure an extra 'rectangle' isn't drawn
  currentPoint = downPoint;
  [self setNeedsDisplay:YES];
}

#pragma mark Drawing shit

- (void)drawRect:(NSRect)rect {
  NSLog(@"- drawRect:]");
  NSSize currentRectSize;
  currentRectSize.width = currentPoint.x - downPoint.x;
  currentRectSize.height = currentPoint.y - downPoint.y;
  NSRect currentRect;
  currentRect.origin = downPoint;
  currentRect.size = currentRectSize;
  
  [[NSColor whiteColor] set];
  [[NSBezierPath bezierPathWithOvalInRect:currentRect] stroke];
}

@end
