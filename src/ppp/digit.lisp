(in-package :ppp)
(defclass digit-parser (parser) ())

(defparameter +digit+ "0123456789")
(defmethod parse ((p digit-parser) text)
  (if (not (> (length text) 0))
      (result:fail "parser error")
      (let ((v (util:split text 1)))
        (if (str:contains? (car v) +digit+)
            (result:success v)
            (result:fail "parser error")))))

(defun digit ()
  (make-instance 'digit-parser))

;; (print (parse (digit) "123"))
;; (print (parse (digit) ""))
