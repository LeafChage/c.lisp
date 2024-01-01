(in-package :ppp)

(defclass many-parser (parser)
  ((child-parser :INITARG :parser)))

(defmethod parse ((obj many-parser) text)
  (with-slots ((child child-parser)) obj
    (result:match=> (parse child text)
                    (lambda (v)
                      (let* ((r2 (parse obj (cadr v)))
                             (v2 (result:unwrap r2)))
                        (result:success
                          (list
                            (cons (car v) (car v2))
                            (cadr v2)))))
                    (lambda (v) (result:success (list nil text))))))

(defun many (p)
  (make-instance 'many-parser :parser p))

;; (print (parse (many (digit)) "1111h"))
;; (print (parse (many (&& (digit) (token "+"))) "1+1+"))

