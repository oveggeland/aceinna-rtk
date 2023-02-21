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

class openrtk_imu {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.gps_week = null;
      this.gps_millisecs = null;
      this.x_acceleration = null;
      this.y_acceleration = null;
      this.z_acceleration = null;
      this.x_gyro_rate = null;
      this.y_gyro_rate = null;
      this.z_gyro_rate = null;
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
      if (initObj.hasOwnProperty('x_acceleration')) {
        this.x_acceleration = initObj.x_acceleration
      }
      else {
        this.x_acceleration = 0.0;
      }
      if (initObj.hasOwnProperty('y_acceleration')) {
        this.y_acceleration = initObj.y_acceleration
      }
      else {
        this.y_acceleration = 0.0;
      }
      if (initObj.hasOwnProperty('z_acceleration')) {
        this.z_acceleration = initObj.z_acceleration
      }
      else {
        this.z_acceleration = 0.0;
      }
      if (initObj.hasOwnProperty('x_gyro_rate')) {
        this.x_gyro_rate = initObj.x_gyro_rate
      }
      else {
        this.x_gyro_rate = 0.0;
      }
      if (initObj.hasOwnProperty('y_gyro_rate')) {
        this.y_gyro_rate = initObj.y_gyro_rate
      }
      else {
        this.y_gyro_rate = 0.0;
      }
      if (initObj.hasOwnProperty('z_gyro_rate')) {
        this.z_gyro_rate = initObj.z_gyro_rate
      }
      else {
        this.z_gyro_rate = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type openrtk_imu
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [gps_week]
    bufferOffset = _serializer.uint16(obj.gps_week, buffer, bufferOffset);
    // Serialize message field [gps_millisecs]
    bufferOffset = _serializer.uint32(obj.gps_millisecs, buffer, bufferOffset);
    // Serialize message field [x_acceleration]
    bufferOffset = _serializer.float32(obj.x_acceleration, buffer, bufferOffset);
    // Serialize message field [y_acceleration]
    bufferOffset = _serializer.float32(obj.y_acceleration, buffer, bufferOffset);
    // Serialize message field [z_acceleration]
    bufferOffset = _serializer.float32(obj.z_acceleration, buffer, bufferOffset);
    // Serialize message field [x_gyro_rate]
    bufferOffset = _serializer.float32(obj.x_gyro_rate, buffer, bufferOffset);
    // Serialize message field [y_gyro_rate]
    bufferOffset = _serializer.float32(obj.y_gyro_rate, buffer, bufferOffset);
    // Serialize message field [z_gyro_rate]
    bufferOffset = _serializer.float32(obj.z_gyro_rate, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type openrtk_imu
    let len;
    let data = new openrtk_imu(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [gps_week]
    data.gps_week = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [gps_millisecs]
    data.gps_millisecs = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [x_acceleration]
    data.x_acceleration = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [y_acceleration]
    data.y_acceleration = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [z_acceleration]
    data.z_acceleration = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [x_gyro_rate]
    data.x_gyro_rate = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [y_gyro_rate]
    data.y_gyro_rate = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [z_gyro_rate]
    data.z_gyro_rate = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 30;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openrtk_msg/openrtk_imu';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd40ff5f1b47965532ea9f61ecd997abb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new openrtk_imu(null);
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

    if (msg.x_acceleration !== undefined) {
      resolved.x_acceleration = msg.x_acceleration;
    }
    else {
      resolved.x_acceleration = 0.0
    }

    if (msg.y_acceleration !== undefined) {
      resolved.y_acceleration = msg.y_acceleration;
    }
    else {
      resolved.y_acceleration = 0.0
    }

    if (msg.z_acceleration !== undefined) {
      resolved.z_acceleration = msg.z_acceleration;
    }
    else {
      resolved.z_acceleration = 0.0
    }

    if (msg.x_gyro_rate !== undefined) {
      resolved.x_gyro_rate = msg.x_gyro_rate;
    }
    else {
      resolved.x_gyro_rate = 0.0
    }

    if (msg.y_gyro_rate !== undefined) {
      resolved.y_gyro_rate = msg.y_gyro_rate;
    }
    else {
      resolved.y_gyro_rate = 0.0
    }

    if (msg.z_gyro_rate !== undefined) {
      resolved.z_gyro_rate = msg.z_gyro_rate;
    }
    else {
      resolved.z_gyro_rate = 0.0
    }

    return resolved;
    }
};

module.exports = openrtk_imu;
