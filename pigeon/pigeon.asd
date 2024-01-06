(defsystem "pigeon/core"
  :components ((:module "core"
                :components ((:file "package")
                             (:file "eq" :DEPENDS-ON ("package"))))))
(defsystem "pigeon/core/test"
  :depends-on ("fiveam" "pigeon/core")
  :components ((:module "core"
                :components ((:file "eq.test")))))

(defsystem "pigeon/result"
  :depends-on ("pigeon/core")
  :components ((:module "result"
               :components ((:file "result")))))

(defsystem "pigeon/result/test"
  :depends-on ("fiveam" "pigeon/core" "pigeon/result")
  :components ((:module "result"
               :components ((:file "result.test")))))

(defsystem "pigeon"
  :depends-on ("pigeon/core" "pigeon/result")
  :components ((:file "pigeon")))

;; (let ((my-project-path (merge-pathnames "project/c/pigeon/" (user-homedir-pathname))))
;;   (pushnew my-project-path asdf:*central-registry* :test #'equal))
;; (asdf:load-system "pigeon")
