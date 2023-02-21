; Auto-generated. Do not edit!


(cl:in-package openrtk_msg-msg)


;//! \htmlinclude openrtk_gnss.msg.html

(cl:defclass <openrtk_gnss> (roslisp-msg-protocol:ros-message)
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
   (position_type
    :reader position_type
    :initarg :position_type
    :type cl:fixnum
    :initform 0)
   (latitude
    :reader latitude
    :initarg :latitude
    :type cl:float
    :initform 0.0)
   (longitude
    :reader longitude
    :initarg :longitude
    :type cl:float
    :initform 0.0)
   (height
    :reader height
    :initarg :height
    :type cl:float
    :initform 0.0)
   (latitude_std_deviation
    :reader latitude_std_deviation
    :initarg :latitude_std_deviation
    :type cl:float
    :initform 0.0)
   (longitude_std_deviation
    :reader longitude_std_deviation
    :initarg :longitude_std_deviation
    :type cl:float
    :initform 0.0)
   (height_std_deviation
    :reader height_std_deviation
    :initarg :height_std_deviation
    :type cl:float
    :initform 0.0)
   (num_of_satellites
    :reader num_of_satellites
    :initarg :num_of_satellites
    :type cl:fixnum
    :initform 0)
   (num_satellite_in_solution
    :reader num_satellite_in_solution
    :initarg :num_satellite_in_solution
    :type cl:fixnum
    :initform 0)
   (hdop
    :reader hdop
    :initarg :hdop
    :type cl:float
    :initform 0.0)
   (diffage
    :reader diffage
    :initarg :diffage
    :type cl:float
    :initform 0.0)
   (north_vel
    :reader north_vel
    :initarg :north_vel
    :type cl:float
    :initform 0.0)
   (east_vel
    :reader east_vel
    :initarg :east_vel
    :type cl:float
    :initform 0.0)
   (up_vel
    :reader up_vel
    :initarg :up_vel
    :type cl:float
    :initform 0.0)
   (north_vel_std_deviation
    :reader north_vel_std_deviation
    :initarg :north_vel_std_deviation
    :type cl:float
    :initform 0.0)
   (east_vel_std_deviation
    :reader east_vel_std_deviation
    :initarg :east_vel_std_deviation
    :type cl:float
    :initform 0.0)
   (up_vel_std_deviation
    :reader up_vel_std_deviation
    :initarg :up_vel_std_deviation
    :type cl:float
    :initform 0.0))
)

(cl:defclass openrtk_gnss (<openrtk_gnss>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <openrtk_gnss>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'openrtk_gnss)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openrtk_msg-msg:<openrtk_gnss> is deprecated: use openrtk_msg-msg:openrtk_gnss instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:header-val is deprecated.  Use openrtk_msg-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'gps_week-val :lambda-list '(m))
(cl:defmethod gps_week-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:gps_week-val is deprecated.  Use openrtk_msg-msg:gps_week instead.")
  (gps_week m))

(cl:ensure-generic-function 'gps_millisecs-val :lambda-list '(m))
(cl:defmethod gps_millisecs-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:gps_millisecs-val is deprecated.  Use openrtk_msg-msg:gps_millisecs instead.")
  (gps_millisecs m))

(cl:ensure-generic-function 'position_type-val :lambda-list '(m))
(cl:defmethod position_type-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:position_type-val is deprecated.  Use openrtk_msg-msg:position_type instead.")
  (position_type m))

(cl:ensure-generic-function 'latitude-val :lambda-list '(m))
(cl:defmethod latitude-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:latitude-val is deprecated.  Use openrtk_msg-msg:latitude instead.")
  (latitude m))

(cl:ensure-generic-function 'longitude-val :lambda-list '(m))
(cl:defmethod longitude-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:longitude-val is deprecated.  Use openrtk_msg-msg:longitude instead.")
  (longitude m))

(cl:ensure-generic-function 'height-val :lambda-list '(m))
(cl:defmethod height-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:height-val is deprecated.  Use openrtk_msg-msg:height instead.")
  (height m))

(cl:ensure-generic-function 'latitude_std_deviation-val :lambda-list '(m))
(cl:defmethod latitude_std_deviation-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:latitude_std_deviation-val is deprecated.  Use openrtk_msg-msg:latitude_std_deviation instead.")
  (latitude_std_deviation m))

(cl:ensure-generic-function 'longitude_std_deviation-val :lambda-list '(m))
(cl:defmethod longitude_std_deviation-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:longitude_std_deviation-val is deprecated.  Use openrtk_msg-msg:longitude_std_deviation instead.")
  (longitude_std_deviation m))

(cl:ensure-generic-function 'height_std_deviation-val :lambda-list '(m))
(cl:defmethod height_std_deviation-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:height_std_deviation-val is deprecated.  Use openrtk_msg-msg:height_std_deviation instead.")
  (height_std_deviation m))

(cl:ensure-generic-function 'num_of_satellites-val :lambda-list '(m))
(cl:defmethod num_of_satellites-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:num_of_satellites-val is deprecated.  Use openrtk_msg-msg:num_of_satellites instead.")
  (num_of_satellites m))

(cl:ensure-generic-function 'num_satellite_in_solution-val :lambda-list '(m))
(cl:defmethod num_satellite_in_solution-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:num_satellite_in_solution-val is deprecated.  Use openrtk_msg-msg:num_satellite_in_solution instead.")
  (num_satellite_in_solution m))

(cl:ensure-generic-function 'hdop-val :lambda-list '(m))
(cl:defmethod hdop-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:hdop-val is deprecated.  Use openrtk_msg-msg:hdop instead.")
  (hdop m))

(cl:ensure-generic-function 'diffage-val :lambda-list '(m))
(cl:defmethod diffage-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:diffage-val is deprecated.  Use openrtk_msg-msg:diffage instead.")
  (diffage m))

(cl:ensure-generic-function 'north_vel-val :lambda-list '(m))
(cl:defmethod north_vel-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:north_vel-val is deprecated.  Use openrtk_msg-msg:north_vel instead.")
  (north_vel m))

(cl:ensure-generic-function 'east_vel-val :lambda-list '(m))
(cl:defmethod east_vel-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:east_vel-val is deprecated.  Use openrtk_msg-msg:east_vel instead.")
  (east_vel m))

(cl:ensure-generic-function 'up_vel-val :lambda-list '(m))
(cl:defmethod up_vel-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:up_vel-val is deprecated.  Use openrtk_msg-msg:up_vel instead.")
  (up_vel m))

(cl:ensure-generic-function 'north_vel_std_deviation-val :lambda-list '(m))
(cl:defmethod north_vel_std_deviation-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:north_vel_std_deviation-val is deprecated.  Use openrtk_msg-msg:north_vel_std_deviation instead.")
  (north_vel_std_deviation m))

(cl:ensure-generic-function 'east_vel_std_deviation-val :lambda-list '(m))
(cl:defmethod east_vel_std_deviation-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:east_vel_std_deviation-val is deprecated.  Use openrtk_msg-msg:east_vel_std_deviation instead.")
  (east_vel_std_deviation m))

(cl:ensure-generic-function 'up_vel_std_deviation-val :lambda-list '(m))
(cl:defmethod up_vel_std_deviation-val ((m <openrtk_gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:up_vel_std_deviation-val is deprecated.  Use openrtk_msg-msg:up_vel_std_deviation instead.")
  (up_vel_std_deviation m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <openrtk_gnss>) ostream)
  "Serializes a message object of type '<openrtk_gnss>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_week)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gps_week)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_millisecs)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gps_millisecs)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'gps_millisecs)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'gps_millisecs)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'position_type)) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'latitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'longitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'height))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'latitude_std_deviation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'longitude_std_deviation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'height_std_deviation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'num_of_satellites)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'num_satellite_in_solution)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'hdop))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'diffage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'north_vel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'east_vel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'up_vel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'north_vel_std_deviation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'east_vel_std_deviation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'up_vel_std_deviation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <openrtk_gnss>) istream)
  "Deserializes a message object of type '<openrtk_gnss>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_week)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gps_week)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_millisecs)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gps_millisecs)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'gps_millisecs)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'gps_millisecs)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'position_type)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'latitude) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'longitude) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'height) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'latitude_std_deviation) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'longitude_std_deviation) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'height_std_deviation) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'num_of_satellites)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'num_satellite_in_solution)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'hdop) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'diffage) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'north_vel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'east_vel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'up_vel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'north_vel_std_deviation) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'east_vel_std_deviation) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'up_vel_std_deviation) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<openrtk_gnss>)))
  "Returns string type for a message object of type '<openrtk_gnss>"
  "openrtk_msg/openrtk_gnss")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'openrtk_gnss)))
  "Returns string type for a message object of type 'openrtk_gnss"
  "openrtk_msg/openrtk_gnss")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<openrtk_gnss>)))
  "Returns md5sum for a message object of type '<openrtk_gnss>"
  "96b04d76b1ddd2c5be37a77c869d504d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'openrtk_gnss)))
  "Returns md5sum for a message object of type 'openrtk_gnss"
  "96b04d76b1ddd2c5be37a77c869d504d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<openrtk_gnss>)))
  "Returns full string definition for message of type '<openrtk_gnss>"
  (cl:format cl:nil "std_msgs/Header header~%uint16 gps_week~%uint32 gps_millisecs~%uint8 position_type~%float64 latitude~%float64 longitude~%float64 height~%float32 latitude_std_deviation~%float32 longitude_std_deviation~%float32 height_std_deviation~%uint8 num_of_satellites~%uint8 num_satellite_in_solution~%float32 hdop~%float32 diffage~%float32 north_vel~%float32 east_vel~%float32 up_vel~%float32 north_vel_std_deviation~%float32 east_vel_std_deviation~%float32 up_vel_std_deviation~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'openrtk_gnss)))
  "Returns full string definition for message of type 'openrtk_gnss"
  (cl:format cl:nil "std_msgs/Header header~%uint16 gps_week~%uint32 gps_millisecs~%uint8 position_type~%float64 latitude~%float64 longitude~%float64 height~%float32 latitude_std_deviation~%float32 longitude_std_deviation~%float32 height_std_deviation~%uint8 num_of_satellites~%uint8 num_satellite_in_solution~%float32 hdop~%float32 diffage~%float32 north_vel~%float32 east_vel~%float32 up_vel~%float32 north_vel_std_deviation~%float32 east_vel_std_deviation~%float32 up_vel_std_deviation~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <openrtk_gnss>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     2
     4
     1
     8
     8
     8
     4
     4
     4
     1
     1
     4
     4
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <openrtk_gnss>))
  "Converts a ROS message object to a list"
  (cl:list 'openrtk_gnss
    (cl:cons ':header (header msg))
    (cl:cons ':gps_week (gps_week msg))
    (cl:cons ':gps_millisecs (gps_millisecs msg))
    (cl:cons ':position_type (position_type msg))
    (cl:cons ':latitude (latitude msg))
    (cl:cons ':longitude (longitude msg))
    (cl:cons ':height (height msg))
    (cl:cons ':latitude_std_deviation (latitude_std_deviation msg))
    (cl:cons ':longitude_std_deviation (longitude_std_deviation msg))
    (cl:cons ':height_std_deviation (height_std_deviation msg))
    (cl:cons ':num_of_satellites (num_of_satellites msg))
    (cl:cons ':num_satellite_in_solution (num_satellite_in_solution msg))
    (cl:cons ':hdop (hdop msg))
    (cl:cons ':diffage (diffage msg))
    (cl:cons ':north_vel (north_vel msg))
    (cl:cons ':east_vel (east_vel msg))
    (cl:cons ':up_vel (up_vel msg))
    (cl:cons ':north_vel_std_deviation (north_vel_std_deviation msg))
    (cl:cons ':east_vel_std_deviation (east_vel_std_deviation msg))
    (cl:cons ':up_vel_std_deviation (up_vel_std_deviation msg))
))
