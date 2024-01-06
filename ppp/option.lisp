(in-package :cl-user)
(defpackage :ppp/option
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from #:ppp/parser)
  (:export #:option))
(in-package :ppp/option)

(defclass option-parser (ppp/parser:parser)
  ((child-parser :INITARG :parser)))

(defmethod ppp/parser:parse ((obj option-parser) text)
  (with-slots ((child child-parser)) obj
    (result:e->> (ppp/parser:parse child text)
                 (lambda (_)
                   (result:ok (list nil text))))))

(defmethod option ((p ppp/parser:parser))
  (make-instance 'option-parser :parser p))


