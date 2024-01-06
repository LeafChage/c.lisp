(in-package :cl-user)
(defpackage :ppp/many
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from #:ppp/parser)
  (:export #:many))
(in-package :ppp/many)

(defclass many-parser (ppp/parser:parser)
  ((child-parser :INITARG :parser)))

(defmethod ppp/parser:parse ((obj many-parser) text)
  (with-slots ((child child-parser)) obj
    (result:match (ppp/parser:parse child text)
                    (lambda (v)
                      (let* ((r2 (ppp/parser:parse obj (cadr v)))
                             (v2 (result:unwrap r2)))
                        (result:ok
                          (list
                            (cons (car v) (car v2))
                            (cadr v2)))))
                    (lambda (v) (result:ok (list nil text))))))

(defmethod many ((p ppp/parser:parser))
  (make-instance 'many-parser :parser p))


