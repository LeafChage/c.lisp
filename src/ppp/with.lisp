(in-package :ppp)

(defclass with-parser (parser)
  ((p1 :INITARG :p1)
   (p2 :INITARG :p2)))

(defmethod parse ((p with-parser) text)
  (with-slots ((p1 p1) (p2 p2)) p
    (result:match=>
      (parse p1 text)
      (lambda (val1)
        (let ((r2 (parse p2 (cadr val1))))
          (result:match=>
            r2
            (lambda (val2)
              (result:success (list
                                (car val2)
                                (cadr val2))))
            #'result:fail)))
      #'result:fail)))

(defmethod with ((p1 parser) (p2 parser))
  (make-instance 'with-parser :p1 p1 :p2 p2))

;; (print (parse (with (take 2) (any)) "hello"))


