; Auto-generated. Do not edit!


(cl:in-package openrtk_msg-msg)


;//! \htmlinclude openrtk_ins.msg.html

(cl:defclass <openrtk_ins> (roslisp-msg-protocol:ros-message)
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
   (ins_status
    :reader ins_status
    :initarg :ins_status
    :type cl:fixnum
    :initform 0)
   (ins_position_type
    :reader ins_position_type
    :initarg :ins_position_type
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
   (roll
    :reader roll
    :initarg :roll
    :type cl:float
    :initform 0.0)
   (pitch
    :reader pitch
    :initarg :pitch
    :type cl:float
    :initform 0.0)
   (heading
    :reader heading
    :initarg :heading
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
    :initform 0.0)
   (roll_std_deviation
    :reader roll_std_deviation
    :initarg :roll_std_deviation
    :type cl:float
    :initform 0.0)
   (pitch_std_deviation
    :reader pitch_std_deviation
    :initarg :pitch_std_deviation
    :type cl:float
    :initform 0.0)
   (heading_std_deviation
    :reader heading_std_deviation
    :initarg :heading_std_deviation
    :type cl:float
    :initform 0.0))
)

(cl:defclass openrtk_ins (<openrtk_ins>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <openrtk_ins>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'openrtk_ins)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openrtk_msg-msg:<openrtk_ins> is deprecated: use openrtk_msg-msg:openrtk_ins instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:header-val is deprecated.  Use openrtk_msg-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'gps_week-val :lambda-list '(m))
(cl:defmethod gps_week-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:gps_week-val is deprecated.  Use openrtk_msg-msg:gps_week instead.")
  (gps_week m))

(cl:ensure-generic-function 'gps_millisecs-val :lambda-list '(m))
(cl:defmethod gps_millisecs-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:gps_millisecs-val is deprecated.  Use openrtk_msg-msg:gps_millisecs instead.")
  (gps_millisecs m))

(cl:ensure-generic-function 'ins_status-val :lambda-list '(m))
(cl:defmethod ins_status-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:ins_status-val is deprecated.  Use openrtk_msg-msg:ins_status instead.")
  (ins_status m))

(cl:ensure-generic-function 'ins_position_type-val :lambda-list '(m))
(cl:defmethod ins_position_type-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:ins_position_type-val is deprecated.  Use openrtk_msg-msg:ins_position_type instead.")
  (ins_position_type m))

(cl:ensure-generic-function 'latitude-val :lambda-list '(m))
(cl:defmethod latitude-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:latitude-val is deprecated.  Use openrtk_msg-msg:latitude instead.")
  (latitude m))

(cl:ensure-generic-function 'longitude-val :lambda-list '(m))
(cl:defmethod longitude-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:longitude-val is deprecated.  Use openrtk_msg-msg:longitude instead.")
  (longitude m))

(cl:ensure-generic-function 'height-val :lambda-list '(m))
(cl:defmethod height-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:height-val is deprecated.  Use openrtk_msg-msg:height instead.")
  (height m))

(cl:ensure-generic-function 'north_vel-val :lambda-list '(m))
(cl:defmethod north_vel-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:north_vel-val is deprecated.  Use openrtk_msg-msg:north_vel instead.")
  (north_vel m))

(cl:ensure-generic-function 'east_vel-val :lambda-list '(m))
(cl:defmethod east_vel-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:east_vel-val is deprecated.  Use openrtk_msg-msg:east_vel instead.")
  (east_vel m))

(cl:ensure-generic-function 'up_vel-val :lambda-list '(m))
(cl:defmethod up_vel-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:up_vel-val is deprecated.  Use openrtk_msg-msg:up_vel instead.")
  (up_vel m))

(cl:ensure-generic-function 'roll-val :lambda-list '(m))
(cl:defmethod roll-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:roll-val is deprecated.  Use openrtk_msg-msg:roll instead.")
  (roll m))

(cl:ensure-generic-function 'pitch-val :lambda-list '(m))
(cl:defmethod pitch-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:pitch-val is deprecated.  Use openrtk_msg-msg:pitch instead.")
  (pitch m))

(cl:ensure-generic-function 'heading-val :lambda-list '(m))
(cl:defmethod heading-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:heading-val is deprecated.  Use openrtk_msg-msg:heading instead.")
  (heading m))

(cl:ensure-generic-function 'latitude_std_deviation-val :lambda-list '(m))
(cl:defmethod latitude_std_deviation-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:latitude_std_deviation-val is deprecated.  Use openrtk_msg-msg:latitude_std_deviation instead.")
  (latitude_std_deviation m))

(cl:ensure-generic-function 'longitude_std_deviation-val :lambda-list '(m))
(cl:defmethod longitude_std_deviation-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:longitude_std_deviation-val is deprecated.  Use openrtk_msg-msg:longitude_std_deviation instead.")
  (longitude_std_deviation m))

(cl:ensure-generic-function 'height_std_deviation-val :lambda-list '(m))
(cl:defmethod height_std_deviation-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:height_std_deviation-val is deprecated.  Use openrtk_msg-msg:height_std_deviation instead.")
  (height_std_deviation m))

(cl:ensure-generic-function 'north_vel_std_deviation-val :lambda-list '(m))
(cl:defmethod north_vel_std_deviation-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:north_vel_std_deviation-val is deprecated.  Use openrtk_msg-msg:north_vel_std_deviation instead.")
  (north_vel_std_deviation m))

(cl:ensure-generic-function 'east_vel_std_deviation-val :lambda-list '(m))
(cl:defmethod east_vel_std_deviation-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:east_vel_std_deviation-val is deprecated.  Use openrtk_msg-msg:east_vel_std_deviation instead.")
  (east_vel_std_deviation m))

(cl:ensure-generic-function 'up_vel_std_deviation-val :lambda-list '(m))
(cl:defmethod up_vel_std_deviation-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:up_vel_std_deviation-val is deprecated.  Use openrtk_msg-msg:up_vel_std_deviation instead.")
  (up_vel_std_deviation m))

(cl:ensure-generic-function 'roll_std_deviation-val :lambda-list '(m))
(cl:defmethod roll_std_deviation-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:roll_std_deviation-val is deprecated.  Use openrtk_msg-msg:roll_std_deviation instead.")
  (roll_std_deviation m))

(cl:ensure-generic-function 'pitch_std_deviation-val :lambda-list '(m))
(cl:defmethod pitch_std_deviation-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:pitch_std_deviation-val is deprecated.  Use openrtk_msg-msg:pitch_std_deviation instead.")
  (pitch_std_deviation m))

(cl:ensure-generic-function 'heading_std_deviation-val :lambda-list '(m))
(cl:defmethod heading_std_deviation-val ((m <openrtk_ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openrtk_msg-msg:heading_std_deviation-val is deprecated.  Use openrtk_msg-msg:heading_std_deviation instead.")
  (heading_std_deviation m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <openrtk_ins>) ostream)
  "Serializes a message object of type '<openrtk_ins>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_week)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gps_week)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_millisecs)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gps_millisecs)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'gps_millisecs)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'gps_millisecs)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ins_status)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ins_position_type)) ostream)
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
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'north_vel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'east_vel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'up_vel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'roll))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'pitch))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'heading))))
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
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'roll_std_deviation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pitch_std_deviation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'heading_std_deviation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <openrtk_ins>) istream)
  "Deserializes a message object of type '<openrtk_ins>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_week)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gps_week)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_millisecs)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gps_millisecs)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'gps_millisecs)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'gps_millisecs)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ins_status)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ins_position_type)) (cl:read-byte istream))
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
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'north_vel) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'east_vel) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'up_vel) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'roll) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pitch) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'heading) (roslisp-utils:decode-double-float-bits bits)))
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
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'roll_std_deviation) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pitch_std_deviation) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'heading_std_deviation) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<openrtk_ins>)))
  "Returns string type for a message object of type '<openrtk_ins>"
  "openrtk_msg/openrtk_ins")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'openrtk_ins)))
  "Returns string type for a message object of type 'openrtk_ins"
  "openrtk_msg/openrtk_ins")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<openrtk_ins>)))
  "Returns md5sum for a message object of type '<openrtk_ins>"
  "6e86b3ea1a214ea8b04a5d2a2447027c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'openrtk_ins)))
  "Returns md5sum for a message object of type 'openrtk_ins"
  "6e86b3ea1a214ea8b04a5d2a2447027c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<openrtk_ins>)))
  "Returns full string definition for message of type '<openrtk_ins>"
  (cl:format cl:nil "std_msgs/Header header~%uint16 gps_week~%uint32 gps_millisecs~%uint8 ins_status~%uint8 ins_position_type~%float64 latitude~%float64 longitude~%float64 height~%float64 north_vel~%float64 east_vel~%float64 up_vel~%float64 roll~%float64 pitch~%float64 heading~%float32 latitude_std_deviation~%float32 longitude_std_deviation~%float32 height_std_deviation~%float32 north_vel_std_deviation~%float32 east_vel_std_deviation~%float32 up_vel_std_deviation~%float32 roll_std_deviation~%float32 pitch_std_deviation~%float32 heading_std_deviation~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'openrtk_ins)))
  "Returns full string definition for message of type 'openrtk_ins"
  (cl:format cl:nil "std_msgs/Header header~%uint16 gps_week~%uint32 gps_millisecs~%uint8 ins_status~%uint8 ins_position_type~%float64 latitude~%float64 longitude~%float64 height~%float64 north_vel~%float64 east_vel~%float64 up_vel~%float64 roll~%float64 pitch~%float64 heading~%float32 latitude_std_deviation~%float32 longitude_std_deviation~%float32 height_std_deviation~%float32 north_vel_std_deviation~%float32 east_vel_std_deviation~%float32 up_vel_std_deviation~%float32 roll_std_deviation~%float32 pitch_std_deviation~%float32 heading_std_deviation~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <openrtk_ins>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     2
     4
     1
     1
     8
     8
     8
     8
     8
     8
     8
     8
     8
     4
     4
     4
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <openrtk_ins>))
  "Converts a ROS message object to a list"
  (cl:list 'openrtk_ins
    (cl:cons ':header (header msg))
    (cl:cons ':gps_week (gps_week msg))
    (cl:cons ':gps_millisecs (gps_millisecs msg))
    (cl:cons ':ins_status (ins_status msg))
    (cl:cons ':ins_position_type (ins_position_type msg))
    (cl:cons ':latitude (latitude msg))
    (cl:cons ':longitude (longitude msg))
    (cl:cons ':height (height msg))
    (cl:cons ':north_vel (north_vel msg))
    (cl:cons ':east_vel (east_vel msg))
    (cl:cons ':up_vel (up_vel msg))
    (cl:cons ':roll (roll msg))
    (cl:cons ':pitch (pitch msg))
    (cl:cons ':heading (heading msg))
    (cl:cons ':latitude_std_deviation (latitude_std_deviation msg))
    (cl:cons ':longitude_std_deviation (longitude_std_deviation msg))
    (cl:cons ':height_std_deviation (height_std_deviation msg))
    (cl:cons ':north_vel_std_deviation (north_vel_std_deviation msg))
    (cl:cons ':east_vel_std_deviation (east_vel_std_deviation msg))
    (cl:cons ':up_vel_std_deviation (up_vel_std_deviation msg))
    (cl:cons ':roll_std_deviation (roll_std_deviation msg))
    (cl:cons ':pitch_std_deviation (pitch_std_deviation msg))
    (cl:cons ':heading_std_deviation (heading_std_deviation msg))
))
