// Auto-generated. Do not edit!

// (in-package openrtk_msg.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class openrtk_ins {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.gps_week = null;
      this.gps_millisecs = null;
      this.ins_status = null;
      this.ins_position_type = null;
      this.latitude = null;
      this.longitude = null;
      this.height = null;
      this.north_vel = null;
      this.east_vel = null;
      this.up_vel = null;
      this.roll = null;
      this.pitch = null;
      this.heading = null;
      this.latitude_std_deviation = null;
      this.longitude_std_deviation = null;
      this.height_std_deviation = null;
      this.north_vel_std_deviation = null;
      this.east_vel_std_deviation = null;
      this.up_vel_std_deviation = null;
      this.roll_std_deviation = null;
      this.pitch_std_deviation = null;
      this.heading_std_deviation = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('gps_week')) {
        this.gps_week = initObj.gps_week
      }
      else {
        this.gps_week = 0;
      }
      if (initObj.hasOwnProperty('gps_millisecs')) {
        this.gps_millisecs = initObj.gps_millisecs
      }
      else {
        this.gps_millisecs = 0;
      }
      if (initObj.hasOwnProperty('ins_status')) {
        this.ins_status = initObj.ins_status
      }
      else {
        this.ins_status = 0;
      }
      if (initObj.hasOwnProperty('ins_position_type')) {
        this.ins_position_type = initObj.ins_position_type
      }
      else {
        this.ins_position_type = 0;
      }
      if (initObj.hasOwnProperty('latitude')) {
        this.latitude = initObj.latitude
      }
      else {
        this.latitude = 0.0;
      }
      if (initObj.hasOwnProperty('longitude')) {
        this.longitude = initObj.longitude
      }
      else {
        this.longitude = 0.0;
      }
      if (initObj.hasOwnProperty('height')) {
        this.height = initObj.height
      }
      else {
        this.height = 0.0;
      }
      if (initObj.hasOwnProperty('north_vel')) {
        this.north_vel = initObj.north_vel
      }
      else {
        this.north_vel = 0.0;
      }
      if (initObj.hasOwnProperty('east_vel')) {
        this.east_vel = initObj.east_vel
      }
      else {
        this.east_vel = 0.0;
      }
      if (initObj.hasOwnProperty('up_vel')) {
        this.up_vel = initObj.up_vel
      }
      else {
        this.up_vel = 0.0;
      }
      if (initObj.hasOwnProperty('roll')) {
        this.roll = initObj.roll
      }
      else {
        this.roll = 0.0;
      }
      if (initObj.hasOwnProperty('pitch')) {
        this.pitch = initObj.pitch
      }
      else {
        this.pitch = 0.0;
      }
      if (initObj.hasOwnProperty('heading')) {
        this.heading = initObj.heading
      }
      else {
        this.heading = 0.0;
      }
      if (initObj.hasOwnProperty('latitude_std_deviation')) {
        this.latitude_std_deviation = initObj.latitude_std_deviation
      }
      else {
        this.latitude_std_deviation = 0.0;
      }
      if (initObj.hasOwnProperty('longitude_std_deviation')) {
        this.longitude_std_deviation = initObj.longitude_std_deviation
      }
      else {
        this.longitude_std_deviation = 0.0;
      }
      if (initObj.hasOwnProperty('height_std_deviation')) {
        this.height_std_deviation = initObj.height_std_deviation
      }
      else {
        this.height_std_deviation = 0.0;
      }
      if (initObj.hasOwnProperty('north_vel_std_deviation')) {
        this.north_vel_std_deviation = initObj.north_vel_std_deviation
      }
      else {
        this.north_vel_std_deviation = 0.0;
      }
      if (initObj.hasOwnProperty('east_vel_std_deviation')) {
        this.east_vel_std_deviation = initObj.east_vel_std_deviation
      }
      else {
        this.east_vel_std_deviation = 0.0;
      }
      if (initObj.hasOwnProperty('up_vel_std_deviation')) {
        this.up_vel_std_deviation = initObj.up_vel_std_deviation
      }
      else {
        this.up_vel_std_deviation = 0.0;
      }
      if (initObj.hasOwnProperty('roll_std_deviation')) {
        this.roll_std_deviation = initObj.roll_std_deviation
      }
      else {
        this.roll_std_deviation = 0.0;
      }
      if (initObj.hasOwnProperty('pitch_std_deviation')) {
        this.pitch_std_deviation = initObj.pitch_std_deviation
      }
      else {
        this.pitch_std_deviation = 0.0;
      }
      if (initObj.hasOwnProperty('heading_std_deviation')) {
        this.heading_std_deviation = initObj.heading_std_deviation
      }
      else {
        this.heading_std_deviation = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type openrtk_ins
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [gps_week]
    bufferOffset = _serializer.uint16(obj.gps_week, buffer, bufferOffset);
    // Serialize message field [gps_millisecs]
    bufferOffset = _serializer.uint32(obj.gps_millisecs, buffer, bufferOffset);
    // Serialize message field [ins_status]
    bufferOffset = _serializer.uint8(obj.ins_status, buffer, bufferOffset);
    // Serialize message field [ins_position_type]
    bufferOffset = _serializer.uint8(obj.ins_position_type, buffer, bufferOffset);
    // Serialize message field [latitude]
    bufferOffset = _serializer.float64(obj.latitude, buffer, bufferOffset);
    // Serialize message field [longitude]
    bufferOffset = _serializer.float64(obj.longitude, buffer, bufferOffset);
    // Serialize message field [height]
    bufferOffset = _serializer.float64(obj.height, buffer, bufferOffset);
    // Serialize message field [north_vel]
    bufferOffset = _serializer.float64(obj.north_vel, buffer, bufferOffset);
    // Serialize message field [east_vel]
    bufferOffset = _serializer.float64(obj.east_vel, buffer, bufferOffset);
    // Serialize message field [up_vel]
    bufferOffset = _serializer.float64(obj.up_vel, buffer, bufferOffset);
    // Serialize message field [roll]
    bufferOffset = _serializer.float64(obj.roll, buffer, bufferOffset);
    // Serialize message field [pitch]
    bufferOffset = _serializer.float64(obj.pitch, buffer, bufferOffset);
    // Serialize message field [heading]
    bufferOffset = _serializer.float64(obj.heading, buffer, bufferOffset);
    // Serialize message field [latitude_std_deviation]
    bufferOffset = _serializer.float32(obj.latitude_std_deviation, buffer, bufferOffset);
    // Serialize message field [longitude_std_deviation]
    bufferOffset = _serializer.float32(obj.longitude_std_deviation, buffer, bufferOffset);
    // Serialize message field [height_std_deviation]
    bufferOffset = _serializer.float32(obj.height_std_deviation, buffer, bufferOffset);
    // Serialize message field [north_vel_std_deviation]
    bufferOffset = _serializer.float32(obj.north_vel_std_deviation, buffer, bufferOffset);
    // Serialize message field [east_vel_std_deviation]
    bufferOffset = _serializer.float32(obj.east_vel_std_deviation, buffer, bufferOffset);
    // Serialize message field [up_vel_std_deviation]
    bufferOffset = _serializer.float32(obj.up_vel_std_deviation, buffer, bufferOffset);
    // Serialize message field [roll_std_deviation]
    bufferOffset = _serializer.float32(obj.roll_std_deviation, buffer, bufferOffset);
    // Serialize message field [pitch_std_deviation]
    bufferOffset = _serializer.float32(obj.pitch_std_deviation, buffer, bufferOffset);
    // Serialize message field [heading_std_deviation]
    bufferOffset = _serializer.float32(obj.heading_std_deviation, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type openrtk_ins
    let len;
    let data = new openrtk_ins(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [gps_week]
    data.gps_week = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [gps_millisecs]
    data.gps_millisecs = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [ins_status]
    data.ins_status = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [ins_position_type]
    data.ins_position_type = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [latitude]
    data.latitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [longitude]
    data.longitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [height]
    data.height = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [north_vel]
    data.north_vel = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [east_vel]
    data.east_vel = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [up_vel]
    data.up_vel = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [roll]
    data.roll = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [pitch]
    data.pitch = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [heading]
    data.heading = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [latitude_std_deviation]
    data.latitude_std_deviation = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [longitude_std_deviation]
    data.longitude_std_deviation = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [height_std_deviation]
    data.height_std_deviation = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [north_vel_std_deviation]
    data.north_vel_std_deviation = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [east_vel_std_deviation]
    data.east_vel_std_deviation = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [up_vel_std_deviation]
    data.up_vel_std_deviation = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [roll_std_deviation]
    data.roll_std_deviation = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pitch_std_deviation]
    data.pitch_std_deviation = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [heading_std_deviation]
    data.heading_std_deviation = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 116;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openrtk_msg/openrtk_ins';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6e86b3ea1a214ea8b04a5d2a2447027c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new openrtk_ins(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.gps_week !== undefined) {
      resolved.gps_week = msg.gps_week;
    }
    else {
      resolved.gps_week = 0
    }

    if (msg.gps_millisecs !== undefined) {
      resolved.gps_millisecs = msg.gps_millisecs;
    }
    else {
      resolved.gps_millisecs = 0
    }

    if (msg.ins_status !== undefined) {
      resolved.ins_status = msg.ins_status;
    }
    else {
      resolved.ins_status = 0
    }

    if (msg.ins_position_type !== undefined) {
      resolved.ins_position_type = msg.ins_position_type;
    }
    else {
      resolved.ins_position_type = 0
    }

    if (msg.latitude !== undefined) {
      resolved.latitude = msg.latitude;
    }
    else {
      resolved.latitude = 0.0
    }

    if (msg.longitude !== undefined) {
      resolved.longitude = msg.longitude;
    }
    else {
      resolved.longitude = 0.0
    }

    if (msg.height !== undefined) {
      resolved.height = msg.height;
    }
    else {
      resolved.height = 0.0
    }

    if (msg.north_vel !== undefined) {
      resolved.north_vel = msg.north_vel;
    }
    else {
      resolved.north_vel = 0.0
    }

    if (msg.east_vel !== undefined) {
      resolved.east_vel = msg.east_vel;
    }
    else {
      resolved.east_vel = 0.0
    }

    if (msg.up_vel !== undefined) {
      resolved.up_vel = msg.up_vel;
    }
    else {
      resolved.up_vel = 0.0
    }

    if (msg.roll !== undefined) {
      resolved.roll = msg.roll;
    }
    else {
      resolved.roll = 0.0
    }

    if (msg.pitch !== undefined) {
      resolved.pitch = msg.pitch;
    }
    else {
      resolved.pitch = 0.0
    }

    if (msg.heading !== undefined) {
      resolved.heading = msg.heading;
    }
    else {
      resolved.heading = 0.0
    }

    if (msg.latitude_std_deviation !== undefined) {
      resolved.latitude_std_deviation = msg.latitude_std_deviation;
    }
    else {
      resolved.latitude_std_deviation = 0.0
    }

    if (msg.longitude_std_deviation !== undefined) {
      resolved.longitude_std_deviation = msg.longitude_std_deviation;
    }
    else {
      resolved.longitude_std_deviation = 0.0
    }

    if (msg.height_std_deviation !== undefined) {
      resolved.height_std_deviation = msg.height_std_deviation;
    }
    else {
      resolved.height_std_deviation = 0.0
    }

    if (msg.north_vel_std_deviation !== undefined) {
      resolved.north_vel_std_deviation = msg.north_vel_std_deviation;
    }
    else {
      resolved.north_vel_std_deviation = 0.0
    }

    if (msg.east_vel_std_deviation !== undefined) {
      resolved.east_vel_std_deviation = msg.east_vel_std_deviation;
    }
    else {
      resolved.east_vel_std_deviation = 0.0
    }

    if (msg.up_vel_std_deviation !== undefined) {
      resolved.up_vel_std_deviation = msg.up_vel_std_deviation;
    }
    else {
      resolved.up_vel_std_deviation = 0.0
    }

    if (msg.roll_std_deviation !== undefined) {
      resolved.roll_std_deviation = msg.roll_std_deviation;
    }
    else {
      resolved.roll_std_deviation = 0.0
    }

    if (msg.pitch_std_deviation !== undefined) {
      resolved.pitch_std_deviation = msg.pitch_std_deviation;
    }
    else {
      resolved.pitch_std_deviation = 0.0
    }

    if (msg.heading_std_deviation !== undefined) {
      resolved.heading_std_deviation = msg.heading_std_deviation;
    }
    else {
      resolved.heading_std_deviation = 0.0
    }

    return resolved;
    }
};

module.exports = openrtk_ins;
