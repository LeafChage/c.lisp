(in-package :ppp)

(defclass and-parser (parser)
  ((p1 :INITARG :p1)
   (p2 :INITARG :p2)))

(defmethod parse ((p and-parser) text)
  (with-slots ((p1 p1)
               (p2 p2))
      p
    (let ((r (parse p1 text)))
      (result:match=>
        r
        (lambda (val1)
          (let ((r2 (parse p2  (cadr val1))))
            (result:match=>
              r2
              (lambda (val2)
                (result:success (list
                                  (list (car val1) (car val2))
                                  (cadr val2))))
              (lambda (e2) (result:fail e2)))))
        (lambda (e1) (result:fail e1))))))

(defmethod & ((p1 parser) (p2 parser))
  (make-instance 'and-parser :p1 p1 :p2 p2))

(defun && (&rest ps)
  (cond ((> (list-length ps) 2) (& (car ps) (apply #'&& (cdr ps))))
        ((> (list-length ps) 1) (& (car ps) (cadr ps)))
        (t (error "argument error"))))

;; (print (parse (&& (take 2) (any) (any)) "hello"))
;; (print (parse (&& (digit) (token "e")) "1ello"))


