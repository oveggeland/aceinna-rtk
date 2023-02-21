;; Auto-generated. Do not edit!


(when (boundp 'openrtk_msg::openrtk_imu)
  (if (not (find-package "OPENRTK_MSG"))
    (make-package "OPENRTK_MSG"))
  (shadow 'openrtk_imu (find-package "OPENRTK_MSG")))
(unless (find-package "OPENRTK_MSG::OPENRTK_IMU")
  (make-package "OPENRTK_MSG::OPENRTK_IMU"))

(in-package "ROS")
;;//! \htmlinclude openrtk_imu.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openrtk_msg::openrtk_imu
  :super ros::object
  :slots (_header _gps_week _gps_millisecs _x_acceleration _y_acceleration _z_acceleration _x_gyro_rate _y_gyro_rate _z_gyro_rate ))

(defmethod openrtk_msg::openrtk_imu
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:gps_week __gps_week) 0)
    ((:gps_millisecs __gps_millisecs) 0)
    ((:x_acceleration __x_acceleration) 0.0)
    ((:y_acceleration __y_acceleration) 0.0)
    ((:z_acceleration __z_acceleration) 0.0)
    ((:x_gyro_rate __x_gyro_rate) 0.0)
    ((:y_gyro_rate __y_gyro_rate) 0.0)
    ((:z_gyro_rate __z_gyro_rate) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _gps_week (round __gps_week))
   (setq _gps_millisecs (round __gps_millisecs))
   (setq _x_acceleration (float __x_acceleration))
   (setq _y_acceleration (float __y_acceleration))
   (setq _z_acceleration (float __z_acceleration))
   (setq _x_gyro_rate (float __x_gyro_rate))
   (setq _y_gyro_rate (float __y_gyro_rate))
   (setq _z_gyro_rate (float __z_gyro_rate))
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
  (:x_acceleration
   (&optional __x_acceleration)
   (if __x_acceleration (setq _x_acceleration __x_acceleration)) _x_acceleration)
  (:y_acceleration
   (&optional __y_acceleration)
   (if __y_acceleration (setq _y_acceleration __y_acceleration)) _y_acceleration)
  (:z_acceleration
   (&optional __z_acceleration)
   (if __z_acceleration (setq _z_acceleration __z_acceleration)) _z_acceleration)
  (:x_gyro_rate
   (&optional __x_gyro_rate)
   (if __x_gyro_rate (setq _x_gyro_rate __x_gyro_rate)) _x_gyro_rate)
  (:y_gyro_rate
   (&optional __y_gyro_rate)
   (if __y_gyro_rate (setq _y_gyro_rate __y_gyro_rate)) _y_gyro_rate)
  (:z_gyro_rate
   (&optional __z_gyro_rate)
   (if __z_gyro_rate (setq _z_gyro_rate __z_gyro_rate)) _z_gyro_rate)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint16 _gps_week
    2
    ;; uint32 _gps_millisecs
    4
    ;; float32 _x_acceleration
    4
    ;; float32 _y_acceleration
    4
    ;; float32 _z_acceleration
    4
    ;; float32 _x_gyro_rate
    4
    ;; float32 _y_gyro_rate
    4
    ;; float32 _z_gyro_rate
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
     ;; float32 _x_acceleration
       (sys::poke _x_acceleration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y_acceleration
       (sys::poke _y_acceleration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _z_acceleration
       (sys::poke _z_acceleration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _x_gyro_rate
       (sys::poke _x_gyro_rate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y_gyro_rate
       (sys::poke _y_gyro_rate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _z_gyro_rate
       (sys::poke _z_gyro_rate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
   ;; float32 _x_acceleration
     (setq _x_acceleration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y_acceleration
     (setq _y_acceleration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _z_acceleration
     (setq _z_acceleration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _x_gyro_rate
     (setq _x_gyro_rate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y_gyro_rate
     (setq _y_gyro_rate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _z_gyro_rate
     (setq _z_gyro_rate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openrtk_msg::openrtk_imu :md5sum-) "d40ff5f1b47965532ea9f61ecd997abb")
(setf (get openrtk_msg::openrtk_imu :datatype-) "openrtk_msg/openrtk_imu")
(setf (get openrtk_msg::openrtk_imu :definition-)
      "std_msgs/Header header
uint16 gps_week
uint32 gps_millisecs
float32 x_acceleration
float32 y_acceleration
float32 z_acceleration
float32 x_gyro_rate
float32 y_gyro_rate
float32 z_gyro_rate

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



(provide :openrtk_msg/openrtk_imu "d40ff5f1b47965532ea9f61ecd997abb")


