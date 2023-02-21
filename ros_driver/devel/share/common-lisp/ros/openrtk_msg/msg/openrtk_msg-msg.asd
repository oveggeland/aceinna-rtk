
(cl:in-package :asdf)

(defsystem "openrtk_msg-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "openrtk_gnss" :depends-on ("_package_openrtk_gnss"))
    (:file "_package_openrtk_gnss" :depends-on ("_package"))
    (:file "openrtk_imu" :depends-on ("_package_openrtk_imu"))
    (:file "_package_openrtk_imu" :depends-on ("_package"))
    (:file "openrtk_ins" :depends-on ("_package_openrtk_ins"))
    (:file "_package_openrtk_ins" :depends-on ("_package"))
  ))