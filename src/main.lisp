(defpackage c
  (:use :cl
        :uiop
        ))
(in-package :c)

(defun read-file (file-name)
  (uiop:read-file-string file-name)


(defun main()
    (let ((texts (read-file #P"./test.c")))
      (print texts)))


