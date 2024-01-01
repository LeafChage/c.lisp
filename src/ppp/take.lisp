(in-package :ppp)

(defclass take-parser (parser)
  ((n :INITARG :length)))

(defmethod parse ((p take-parser) text)
  (with-slots ((n n)) p
        (if (> (length text) n)
            (result:success (util:split text n))
            (result:fail "parser error"))))

(defun take (n)
  (make-instance 'take-parser :length n))

;; (print (let ((p (take 3)))
;;          (parse p "token token")))
