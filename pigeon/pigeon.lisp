(in-package :cl-user)
(defpackage pigeon
  (:use :cl
        :pigeon/core)
  (:import-from :pigeon/result)
  (:EXPORT #:@eq
           :result))
