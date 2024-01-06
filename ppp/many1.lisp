(in-package :cl-user)
(defpackage :ppp/many1
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from :ppp/error)
  (:import-from :ppp/parser)
  (:import-from :ppp/many  #:many)
  (:export #:many1))
(in-package :ppp/many1)

(defclass many1-parser (ppp/parser:parser)
  ((child-parser :INITARG :parser)))

(defmethod -inner-parser ((obj many1-parser) text)
  (with-slots ((child child-parser)) obj
    (result:match (ppp/parser:parse child text)
      (lambda (v)
        (let* ((r2 (-inner-parser obj (cadr v)))
               (v2 (result:unwrap r2)))
          (result:ok
            (list
              (cons (car v) (car v2))
              (cadr v2)))))
      (lambda (v) (result:ok (list nil text))))))

(defmethod ppp/parser:parse ((obj many1-parser) text)
  (with-slots ((child child-parser)) obj
    (result:->> (ppp/parser:parse child text)
                (lambda (v)
                  (let* ((r2 (-inner-parser obj (cadr v)))
                         (v2 (result:unwrap r2)))
                    (result:ok
                      (list
                        (cons (car v) (car v2))
                        (cadr v2))))))))

(defmethod many1 ((p ppp/parser:parser))
  (make-instance 'many1-parser :parser p))





