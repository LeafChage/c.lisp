(in-package :ppp)

(defclass lazy-parser (parser)
  ((generator :INITARG :gene)))

(defmethod parse ((obj lazy-parser) text)
  (with-slots ((g generator)) obj
    (parse (funcall g) text)))

(defun lazy (fn)
  (make-instance 'lazy-parser :gene fn))

;; (print (parse (lazy #'digit) "1111h"))

