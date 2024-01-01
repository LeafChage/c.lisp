(in-package :cl-user)
(defpackage c
  (:use :cl
        :uiop)
  (:IMPORT-FROM
    :c.code
    :c.parser))
(in-package :c)

(defun read-file (file-name)
  (uiop:read-file-string file-name))

(defun write-file (file-name text)
  (with-open-file (stream file-name
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
    (format stream "~a" text)))

(defun main()
    (let ((texts (read-file #P"./test.c")))
      (write-file #P"./test.s" (code:code-gen (parser:c texts)))))


(main)

(handler-case
    (run-program "make exec")
  (error (c) (format t "~a" c)))
