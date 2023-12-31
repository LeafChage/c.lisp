(in-package :ppp)

(defclass many-parser (parser)
  ((child-parser :INITARG :parser)))

(defmethod parse ((obj many-parser) text)
  (with-slots ((child child-parser)) obj
    (let ((r (parse child text)))
      (result:match=> r
                      (lambda (v)
                        (let* ((r2 (parse obj (cadr v)))
                               (v2 (result:unwrap r2)))
                          (result:success
                            (list
                              (cons (car v) (car v2))
                              (cdr v2)))))
                      (lambda (v) (result:success (list nil text)))))))

(defun many (p)
  (make-instance 'many-parser :parser p))

(print (parse (many (digit)) "123h"))
