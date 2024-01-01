(in-package :ppp)

(defclass or-parser (parser)
  ((p1 :INITARG :p1)
   (p2 :INITARG :p2)))

(defmethod parse ((p or-parser) text)
  (with-slots ((p1 p1) (p2 p2)) p
    (let ((success (lambda (v) (result:success v)))
          (p1-r (parse p1 text)))
      (result:match=>
        p1-r
        success
        (lambda (e1)
          (let ((p2-r (parse p2 text)))
            (result:match=>
              p2-r
              success
              (lambda (e2)
                (result:fail (format t "~a / ~a" e1 e2))))))))))

(defmethod || ((p1 parser) (p2 parser))
  (make-instance 'or-parser :p1 p1 :p2 p2))


;; (print (parse (|| (token "12345") (take 5)) "helloworld"))
;; (print (parse (|| (token "12345") (token "32424")) "helloworld"))

