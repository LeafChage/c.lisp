(in-package :cl-user)
(defpackage :ppp/or
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from #:ppp/util)
  (:import-from #:ppp/parser)
  (:export #:||))
(in-package :ppp/or)

(defclass or-parser (ppp/parser:parser)
  ((p1 :INITARG :p1)
   (p2 :INITARG :p2)))

(defmethod ppp/parser:parse ((p or-parser)
                  (text sequence))
  (with-slots ((p1 p1) (p2 p2)) p
    (result:e->> (ppp/parser:parse p1 text)
                 (lambda (e1)
                   (result:e->> (ppp/parser:parse p2 text)
                                (lambda (e2)
                                  (merge-error e1 e2)))))))

(defmethod merge-error ((e1 ppp/error:parser-err)
                        (e2 ppp/error:parser-err))
  (ppp/error:parser-err :expect (list (ppp/error:expect e1)
                                      (ppp/error:expect e2))
                        :actual (ppp/util:longer (ppp/error:actual e1)
                                                 (ppp/error:actual e2))))


(defmethod || ((p1 ppp/parser:parser)
               (p2 ppp/parser:parser))
  (make-instance 'or-parser :p1 p1 :p2 p2))




