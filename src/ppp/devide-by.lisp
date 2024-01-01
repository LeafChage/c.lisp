(in-package :ppp)

(defclass devide-by-parser (parser)
  ((child-parser :INITARG :parser)
   (devide-parser :INITARG :devide)))

(defmethod parse ((obj devide-by-parser) text)
  (with-slots ((child child-parser)
               (devide devide-parser)) obj
    (result:match=> (parse (many (&& child devide)) text)
                    (lambda (v)
                      (result:match=> (parse child (cadr v))
                                      (lambda (v2)
                                        (result:success (list
                                                          (util:flatten (list (car v) (car v2)))
                                                          (cadr v2))))
                                      #'result:fail))
                    #'result:fail)))

(defun devide-by (child devide)
  (make-instance 'devide-by-parser :parser child :devide devide))

;; (print (parse (devide-by (digit) (token "+")) "1+1+1"))
