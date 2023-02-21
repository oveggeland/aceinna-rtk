;; Auto-generated. Do not edit!


(when (boundp 'openrtk_msg::openrtk_ins)
  (if (not (find-package "OPENRTK_MSG"))
    (make-package "OPENRTK_MSG"))
  (shadow 'openrtk_ins (find-package "OPENRTK_MSG")))
(unless (find-package "OPENRTK_MSG::OPENRTK_INS")
  (make-package "OPENRTK_MSG::OPENRTK_INS"))

(in-package "ROS")
;;//! \htmlinclude openrtk_ins.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openrtk_msg::openrtk_ins
  :super ros::object
  :slots (_header _gps_week _gps_millisecs _ins_status _ins_position_type _latitude _longitude _height _north_vel _east_vel _up_vel _roll _pitch _heading _latitude_std_deviation _longitude_std_deviation _height_std_deviation _north_vel_std_deviation _east_vel_std_deviation _up_vel_std_deviation _roll_std_deviation _pitch_std_deviation _heading_std_deviation ))

(defmethod openrtk_msg::openrtk_ins
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:gps_week __gps_week) 0)
    ((:gps_millisecs __gps_millisecs) 0)
    ((:ins_status __ins_status) 0)
    ((:ins_position_type __ins_position_type) 0)
    ((:latitude __latitude) 0.0)
    ((:longitude __longitude) 0.0)
    ((:height __height) 0.0)
    ((:north_vel __north_vel) 0.0)
    ((:east_vel __east_vel) 0.0)
    ((:up_vel __up_vel) 0.0)
    ((:roll __roll) 0.0)
    ((:pitch __pitch) 0.0)
    ((:heading __heading) 0.0)
    ((:latitude_std_deviation __latitude_std_deviation) 0.0)
    ((:longitude_std_deviation __longitude_std_deviation) 0.0)
    ((:height_std_deviation __height_std_deviation) 0.0)
    ((:north_vel_std_deviation __north_vel_std_deviation) 0.0)
    ((:east_vel_std_deviation __east_vel_std_deviation) 0.0)
    ((:up_vel_std_deviation __up_vel_std_deviation) 0.0)
    ((:roll_std_deviation __roll_std_deviation) 0.0)
    ((:pitch_std_deviation __pitch_std_deviation) 0.0)
    ((:heading_std_deviation __heading_std_deviation) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _gps_week (round __gps_week))
   (setq _gps_millisecs (round __gps_millisecs))
   (setq _ins_status (round __ins_status))
   (setq _ins_position_type (round __ins_position_type))
   (setq _latitude (float __latitude))
   (setq _longitude (float __longitude))
   (setq _height (float __height))
   (setq _north_vel (float __north_vel))
   (setq _east_vel (float __east_vel))
   (setq _up_vel (float __up_vel))
   (setq _roll (float __roll))
   (setq _pitch (float __pitch))
   (setq _heading (float __heading))
   (setq _latitude_std_deviation (float __latitude_std_deviation))
   (setq _longitude_std_deviation (float __longitude_std_deviation))
   (setq _height_std_deviation (float __height_std_deviation))
   (setq _north_vel_std_deviation (float __north_vel_std_deviation))
   (setq _east_vel_std_deviation (float __east_vel_std_deviation))
   (setq _up_vel_std_deviation (float __up_vel_std_deviation))
   (setq _roll_std_deviation (float __roll_std_deviation))
   (setq _pitch_std_deviation (float __pitch_std_deviation))
   (setq _heading_std_deviation (float __heading_std_deviation))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:gps_week
   (&optional __gps_week)
   (if __gps_week (setq _gps_week __gps_week)) _gps_week)
  (:gps_millisecs
   (&optional __gps_millisecs)
   (if __gps_millisecs (setq _gps_millisecs __gps_millisecs)) _gps_millisecs)
  (:ins_status
   (&optional __ins_status)
   (if __ins_status (setq _ins_status __ins_status)) _ins_status)
  (:ins_position_type
   (&optional __ins_position_type)
   (if __ins_position_type (setq _ins_position_type __ins_position_type)) _ins_position_type)
  (:latitude
   (&optional __latitude)
   (if __latitude (setq _latitude __latitude)) _latitude)
  (:longitude
   (&optional __longitude)
   (if __longitude (setq _longitude __longitude)) _longitude)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:north_vel
   (&optional __north_vel)
   (if __north_vel (setq _north_vel __north_vel)) _north_vel)
  (:east_vel
   (&optional __east_vel)
   (if __east_vel (setq _east_vel __east_vel)) _east_vel)
  (:up_vel
   (&optional __up_vel)
   (if __up_vel (setq _up_vel __up_vel)) _up_vel)
  (:roll
   (&optional __roll)
   (if __roll (setq _roll __roll)) _roll)
  (:pitch
   (&optional __pitch)
   (if __pitch (setq _pitch __pitch)) _pitch)
  (:heading
   (&optional __heading)
   (if __heading (setq _heading __heading)) _heading)
  (:latitude_std_deviation
   (&optional __latitude_std_deviation)
   (if __latitude_std_deviation (setq _latitude_std_deviation __latitude_std_deviation)) _latitude_std_deviation)
  (:longitude_std_deviation
   (&optional __longitude_std_deviation)
   (if __longitude_std_deviation (setq _longitude_std_deviation __longitude_std_deviation)) _longitude_std_deviation)
  (:height_std_deviation
   (&optional __height_std_deviation)
   (if __height_std_deviation (setq _height_std_deviation __height_std_deviation)) _height_std_deviation)
  (:north_vel_std_deviation
   (&optional __north_vel_std_deviation)
   (if __north_vel_std_deviation (setq _north_vel_std_deviation __north_vel_std_deviation)) _north_vel_std_deviation)
  (:east_vel_std_deviation
   (&optional __east_vel_std_deviation)
   (if __east_vel_std_deviation (setq _east_vel_std_deviation __east_vel_std_deviation)) _east_vel_std_deviation)
  (:up_vel_std_deviation
   (&optional __up_vel_std_deviation)
   (if __up_vel_std_deviation (setq _up_vel_std_deviation __up_vel_std_deviation)) _up_vel_std_deviation)
  (:roll_std_deviation
   (&optional __roll_std_deviation)
   (if __roll_std_deviation (setq _roll_std_deviation __roll_std_deviation)) _roll_std_deviation)
  (:pitch_std_deviation
   (&optional __pitch_std_deviation)
   (if __pitch_std_deviation (setq _pitch_std_deviation __pitch_std_deviation)) _pitch_std_deviation)
  (:heading_std_deviation
   (&optional __heading_std_deviation)
   (if __heading_std_deviation (setq _heading_std_deviation __heading_std_deviation)) _heading_std_deviation)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint16 _gps_week
    2
    ;; uint32 _gps_millisecs
    4
    ;; uint8 _ins_status
    1
    ;; uint8 _ins_position_type
    1
    ;; float64 _latitude
    8
    ;; float64 _longitude
    8
    ;; float64 _height
    8
    ;; float64 _north_vel
    8
    ;; float64 _east_vel
    8
    ;; float64 _up_vel
    8
    ;; float64 _roll
    8
    ;; float64 _pitch
    8
    ;; float64 _heading
    8
    ;; float32 _latitude_std_deviation
    4
    ;; float32 _longitude_std_deviation
    4
    ;; float32 _height_std_deviation
    4
    ;; float32 _north_vel_std_deviation
    4
    ;; float32 _east_vel_std_deviation
    4
    ;; float32 _up_vel_std_deviation
    4
    ;; float32 _roll_std_deviation
    4
    ;; float32 _pitch_std_deviation
    4
    ;; float32 _heading_std_deviation
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint16 _gps_week
       (write-word _gps_week s)
     ;; uint32 _gps_millisecs
       (write-long _gps_millisecs s)
     ;; uint8 _ins_status
       (write-byte _ins_status s)
     ;; uint8 _ins_position_type
       (write-byte _ins_position_type s)
     ;; float64 _latitude
       (sys::poke _latitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _longitude
       (sys::poke _longitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _height
       (sys::poke _height (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _north_vel
       (sys::poke _north_vel (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _east_vel
       (sys::poke _east_vel (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _up_vel
       (sys::poke _up_vel (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _roll
       (sys::poke _roll (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _pitch
       (sys::poke _pitch (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _heading
       (sys::poke _heading (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float32 _latitude_std_deviation
       (sys::poke _latitude_std_deviation (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _longitude_std_deviation
       (sys::poke _longitude_std_deviation (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _height_std_deviation
       (sys::poke _height_std_deviation (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _north_vel_std_deviation
       (sys::poke _north_vel_std_deviation (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _east_vel_std_deviation
       (sys::poke _east_vel_std_deviation (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _up_vel_std_deviation
       (sys::poke _up_vel_std_deviation (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _roll_std_deviation
       (sys::poke _roll_std_deviation (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pitch_std_deviation
       (sys::poke _pitch_std_deviation (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _heading_std_deviation
       (sys::poke _heading_std_deviation (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint16 _gps_week
     (setq _gps_week (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint32 _gps_millisecs
     (setq _gps_millisecs (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint8 _ins_status
     (setq _ins_status (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _ins_position_type
     (setq _ins_position_type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float64 _latitude
     (setq _latitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _longitude
     (setq _longitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _height
     (setq _height (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _north_vel
     (setq _north_vel (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _east_vel
     (setq _east_vel (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _up_vel
     (setq _up_vel (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _roll
     (setq _roll (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _pitch
     (setq _pitch (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _heading
     (setq _heading (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float32 _latitude_std_deviation
     (setq _latitude_std_deviation (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _longitude_std_deviation
     (setq _longitude_std_deviation (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _height_std_deviation
     (setq _height_std_deviation (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _north_vel_std_deviation
     (setq _north_vel_std_deviation (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _east_vel_std_deviation
     (setq _east_vel_std_deviation (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _up_vel_std_deviation
     (setq _up_vel_std_deviation (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _roll_std_deviation
     (setq _roll_std_deviation (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pitch_std_deviation
     (setq _pitch_std_deviation (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _heading_std_deviation
     (setq _heading_std_deviation (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openrtk_msg::openrtk_ins :md5sum-) "6e86b3ea1a214ea8b04a5d2a2447027c")
(setf (get openrtk_msg::openrtk_ins :datatype-) "openrtk_msg/openrtk_ins")
(setf (get openrtk_msg::openrtk_ins :definition-)
      "std_msgs/Header header
uint16 gps_week
uint32 gps_millisecs
uint8 ins_status
uint8 ins_position_type
float64 latitude
float64 longitude
float64 height
float64 north_vel
float64 east_vel
float64 up_vel
float64 roll
float64 pitch
float64 heading
float32 latitude_std_deviation
float32 longitude_std_deviation
float32 height_std_deviation
float32 north_vel_std_deviation
float32 east_vel_std_deviation
float32 up_vel_std_deviation
float32 roll_std_deviation
float32 pitch_std_deviation
float32 heading_std_deviation

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :openrtk_msg/openrtk_ins "6e86b3ea1a214ea8b04a5d2a2447027c")


