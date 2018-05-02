import cv2 # opencv-contrib-python required!
import threading
import sys
import time

if cv2.__version__ < '3.4.0':
    raise ImportError('Please upgrade your OpenCV installation to v3.4.* or later!')

class Tracker:
    def __init__(self, tracker_type='MEDIANFLOW'):
        self.tracker_type = tracker_type
        self.bbox = (0,0,0,0)
        self.read_lock = threading.Lock()

    def init(self, frame, bbox):
        self.tracker = setTrackerType(self.tracker_type)
        ok = self.tracker.init(frame, bbox)
        with self.read_lock:
            self.bbox = bbox
        return ok

    def clear(self):
        self.tracker = setTrackerType(self.tracker_type)
    
    def update(self, frame):
        ok, bbox = self.tracker.update(frame)
        bbox = [int(x) for x in bbox]
        with self.read_lock:
            self.bbox = bbox
    
    def get_bbox(self):
        with self.read_lock:
            bbox = self.bbox
        return bbox

def setTrackerType(tracker_type):
    if tracker_type == 'BOOSTING':
        tracker = cv2.TrackerBoosting_create()
    elif tracker_type == 'MIL':
        tracker = cv2.TrackerMIL_create()
    elif tracker_type == 'KCF':
        tracker = cv2.TrackerKCF_create()
    elif tracker_type == 'TLD':
        tracker = cv2.TrackerTLD_create()
    elif tracker_type == 'MEDIANFLOW':
        tracker = cv2.TrackerMedianFlow_create()
    elif tracker_type == 'GOTURN':
        tracker = cv2.TrackerGOTURN_create()
    else:
        tracker = None
    return tracker