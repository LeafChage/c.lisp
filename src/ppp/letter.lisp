(in-package :ppp)

(defclass letter-parser (parser) ())

(defparameter +letter+ "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
(defmethod parse ((p letter-parser) text)
  (let ((v (util:split text 1)))
    (if (str:contains? (car v) +letter+)
        (result:success v)
        (result:fail "parser error"))))

(defun letter ()
  (make-instance 'letter-parser))

(print (parse (letter) "123"))
(print (parse (letter) "hello"))
(print (parse (letter) "Hello"))
