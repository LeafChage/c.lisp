(in-package :ppp)

(defclass option-parser (parser)
  ((child-parser :INITARG :parser)))

(defmethod parse ((obj option-parser) text)
  (with-slots ((child child-parser)) obj
    (result:match=> (parse child text)
                    #'result:success
                    (lambda (_) (result:success (list nil text))))))

(defun option (p)
  (make-instance 'option-parser :parser p))

;; (print (parse (option (digit)) "hhhh"))
;; (print (parse (option (digit)) "1hhh"))

