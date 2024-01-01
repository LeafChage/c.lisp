(in-package :ppp)

(defclass token-parser (parser)
  ((target :INITARG :target)))

(defmethod parse ((p token-parser) text)
  (with-slots ((target target)) p
    (let* ((len (length target))
           (v (util:split text len)))
      (if (string= (car v) target)
          (result:success v)
          (result:fail "parser error")))
    ))

(defun token (target)
  (make-instance 'token-parser :target target))

;; (print (parse (token "token") "token token"))


