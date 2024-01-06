(in-package :cl-user)
(defpackage :ppp/defined
  (:use :cl)
  (:import-from :ppp/parser)
  (:import-from :ppp/many #:many)
  (:import-from :ppp/token #:token)
  (:import-from :ppp/choice #:choice)
  (:export #:whitespace
           #:whitespaces))
(in-package :ppp/defined)

(defun whitespace ()
  (choice (token (string #\space))
          (token (string #\newline))
          (token (string #\tab))))

(defun whitespaces ()
  (many (whitespace)))


