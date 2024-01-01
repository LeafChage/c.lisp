(in-package :ppp)

(defclass map-parser (parser)
  ((p :INITARG :p)
   (fn :INITARG :fn)))

(defmethod parse ((p map-parser) text)
  (with-slots ((p p) (fn fn)) p
    (let ((r (parse p text)))
      (result:match=> r
                      (lambda (v)
                        (let ((target (car v)))
                          (result:success
                            (list (funcall fn target)
                                  (cadr v)))))
                      (lambda (v) (result:fail v))))))

(defmethod >> ((p parser) (fn function))
  (make-instance 'map-parser :p p :fn fn))

;; (print (parse (>> (digit) (lambda (v) (+ (parse-integer v) 1))) "12345"))

