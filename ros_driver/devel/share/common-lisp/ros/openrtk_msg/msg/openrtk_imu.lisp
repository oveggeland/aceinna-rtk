; Auto-generated. Do not edit!


(cl:in-package openrtk_msg-msg)


;//! \htmlinclude openrtk_imu.msg.html

(cl:defclass <openrtk_imu> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (gps_week
    :reader gps_week
    :initarg :gps_week
    :type cl:fixnum
    :initform 0)
   (gps_millisecs
    :reader gps_millisecs
    :initarg :gps_millisecs
    :type cl:integer
    :initform 0)
   (x_acceleration
    :reader x_acceleration
    :initarg :x_acceleration
    :type cl:float
    :initform 0.0)
   (y_acceleration
    :reader y_acceleration
    :initarg :y_acceleration
    :type cl:float
    :initform 0.0)
   (z_acceleration
    :reader z_acceleration
    :initarg :z_acceleration
    :type cl:float
    :initform 0.0)
   (x_gyro_rate
    :reader x_gyro_rate
    :initarg :x_gyro_rate
    :type cl:float
    :initform 0.0)
   (y_gyro_rate
    :reader y_gyro_rate
    :initarg :y_gyro_rate
    :type cl:float
    :initform 0.0)
   (z_gyro_rate
    :reader z_gyro_rate
    :initarg :z_gyro_rate
    :type cl:float
    :initform 0.0))
)

(cl:defclass openrtk_imu (<openrtk_imu>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <openrtk_imu>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'openrtk_imu)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openrtk_msg-msg:<openrtk_imu> is deprecated: use openrtk_msg-msg:openrtk_imu instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <openrtk_imu>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:header-val is deprecated.  Use openrtk_msg-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'gps_week-val :lambda-list '(m))
(cl:defmethod gps_week-val ((m <openrtk_imu>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:gps_week-val is deprecated.  Use openrtk_msg-msg:gps_week instead.")
  (gps_week m))

(cl:ensure-generic-function 'gps_millisecs-val :lambda-list '(m))
(cl:defmethod gps_millisecs-val ((m <openrtk_imu>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:gps_millisecs-val is deprecated.  Use openrtk_msg-msg:gps_millisecs instead.")
  (gps_millisecs m))

(cl:ensure-generic-function 'x_acceleration-val :lambda-list '(m))
(cl:defmethod x_acceleration-val ((m <openrtk_imu>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:x_acceleration-val is deprecated.  Use openrtk_msg-msg:x_acceleration instead.")
  (x_acceleration m))

(cl:ensure-generic-function 'y_acceleration-val :lambda-list '(m))
(cl:defmethod y_acceleration-val ((m <openrtk_imu>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:y_acceleration-val is deprecated.  Use openrtk_msg-msg:y_acceleration instead.")
  (y_acceleration m))

(cl:ensure-generic-function 'z_acceleration-val :lambda-list '(m))
(cl:defmethod z_acceleration-val ((m <openrtk_imu>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:z_acceleration-val is deprecated.  Use openrtk_msg-msg:z_acceleration instead.")
  (z_acceleration m))

(cl:ensure-generic-function 'x_gyro_rate-val :lambda-list '(m))
(cl:defmethod x_gyro_rate-val ((m <openrtk_imu>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:x_gyro_rate-val is deprecated.  Use openrtk_msg-msg:x_gyro_rate instead.")
  (x_gyro_rate m))

(cl:ensure-generic-function 'y_gyro_rate-val :lambda-list '(m))
(cl:defmethod y_gyro_rate-val ((m <openrtk_imu>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:y_gyro_rate-val is deprecated.  Use openrtk_msg-msg:y_gyro_rate instead.")
  (y_gyro_rate m))

(cl:ensure-generic-function 'z_gyro_rate-val :lambda-list '(m))
(cl:defmethod z_gyro_rate-val ((m <openrtk_imu>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:z_gyro_rate-val is deprecated.  Use openrtk_msg-msg:z_gyro_rate instead.")
  (z_gyro_rate m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <openrtk_imu>) ostream)
  "Serializes a message object of type '<openrtk_imu>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_week)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gps_week)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_millisecs)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gps_millisecs)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'gps_millisecs)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'gps_millisecs)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x_acceleration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y_acceleration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'z_acceleration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x_gyro_rate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y_gyro_rate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'z_gyro_rate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <openrtk_imu>) istream)
  "Deserializes a message object of type '<openrtk_imu>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_week)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gps_week)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_millisecs)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gps_millisecs)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'gps_millisecs)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'gps_millisecs)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x_acceleration) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y_acceleration) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'z_acceleration) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x_gyro_rate) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y_gyro_rate) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'z_gyro_rate) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<openrtk_imu>)))
  "Returns string type for a message object of type '<openrtk_imu>"
  "openrtk_msg/openrtk_imu")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'openrtk_imu)))
  "Returns string type for a message object of type 'openrtk_imu"
  "openrtk_msg/openrtk_imu")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<openrtk_imu>)))
  "Returns md5sum for a message object of type '<openrtk_imu>"
  "d40ff5f1b47965532ea9f61ecd997abb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'openrtk_imu)))
  "Returns md5sum for a message object of type 'openrtk_imu"
  "d40ff5f1b47965532ea9f61ecd997abb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<openrtk_imu>)))
  "Returns full string definition for message of type '<openrtk_imu>"
  (cl:format cl:nil "std_msgs/Header header~%uint16 gps_week~%uint32 gps_millisecs~%float32 x_acceleration~%float32 y_acceleration~%float32 z_acceleration~%float32 x_gyro_rate~%float32 y_gyro_rate~%float32 z_gyro_rate~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'openrtk_imu)))
  "Returns full string definition for message of type 'openrtk_imu"
  (cl:format cl:nil "std_msgs/Header header~%uint16 gps_week~%uint32 gps_millisecs~%float32 x_acceleration~%float32 y_acceleration~%float32 z_acceleration~%float32 x_gyro_rate~%float32 y_gyro_rate~%float32 z_gyro_rate~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <openrtk_imu>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     2
     4
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <openrtk_imu>))
  "Converts a ROS message object to a list"
  (cl:list 'openrtk_imu
    (cl:cons ':header (header msg))
    (cl:cons ':gps_week (gps_week msg))
    (cl:cons ':gps_millisecs (gps_millisecs msg))
    (cl:cons ':x_acceleration (x_acceleration msg))
    (cl:cons ':y_acceleration (y_acceleration msg))
    (cl:cons ':z_acceleration (z_acceleration msg))
    (cl:cons ':x_gyro_rate (x_gyro_rate msg))
    (cl:cons ':y_gyro_rate (y_gyro_rate msg))
    (cl:cons ':z_gyro_rate (z_gyro_rate msg))
))
