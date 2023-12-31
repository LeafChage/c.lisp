(in-package :ppp)
(defclass any-parser (parser) ())

(defmethod parse ((p any-parser) text)
  (result:success (util:split text 1)))

(defun any ()
  (make-instance 'any-parser))

(print (parse (any) "123"))
