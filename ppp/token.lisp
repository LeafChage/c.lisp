(in-package :cl-user)
(defpackage :ppp/token
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from #:ppp/parser)
  (:import-from #:ppp/error)
  (:import-from #:ppp/util)
  (:export #:token))
(in-package :ppp/token)

(defclass token-parser (ppp/parser:parser)
  ((target :INITARG :target)))

(defmethod ppp/parser:parse ((p token-parser) (text sequence))
  (with-slots ((target target)) p
    (let* ((len (length target))
           (v (ppp/util:split text len)))
      (if (string= (car v) target)
          (result:ok v)
          (ppp/error:parser-err :expect target
                                :actual (car v))))))

(defun token (target)
  (make-instance 'token-parser :target target))



