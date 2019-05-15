## Host: PC with Linux(Ubuntu 18.04)
### 1. Description
#### Purpose:
Object tracking application running on host computer.

#### Requirements:
* Ubuntu 18.04
* TensorFlow 1.13.1
* Protobuf 3.7
* Google's object_detection API
* OpenCV-contrib for tracking API

### 2. Setup
#### 2.1 Run the setup script

Setup script will do what project needs    
```
$ chmod +x ./scripts/env_setup.sh
$ ./scripts/env_setup.sh
```

### 3. Run
Activate the virtual environment, and run application:    
```
$ source ~/covisart/bin/activate
(covisart)$ python tracking-app.py
```
