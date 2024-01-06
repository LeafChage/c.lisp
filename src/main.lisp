(in-package :cl-user)
(defpackage c
  (:use :cl
        :uiop)
  (:IMPORT-FROM :c.code)
  (:IMPORT-FROM :c.parser))
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
    (let* ((texts (read-file #P"./test.c"))
           (parsed (parser:c texts))
           (c (code:code-gen parsed)))
      (write-file #P"./test.s" c)
      c))


;; (main)
