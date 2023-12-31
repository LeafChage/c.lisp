;; (defsystem "c"
;;   :version "0.0.1"
;;   :author ""
;;   :license ""
;;   :depends-on ("str")
;;   :components ((:module "src"
;;                 :components
;;                 ((:file "main"))))
;;   :description ""
;;   :in-order-to ((test-op (test-op "c/tests"))))

(defsystem "ppp"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ("str")
  :components ((:module "src/ppp"
                :components ((:file "util")
                             (:file "result")
                             (:file "package" :depends-on ("result" "util"))
                             (:file "parser" :depends-on ("package"))
                             ;; (:file "and" :depends-on ("package"))
                             (:file "any" :depends-on ("package"))
                             (:file "digit" :depends-on ("package"))
                             (:file "letter" :depends-on ("package"))
                             (:file "many" :depends-on ("package"))
                             (:file "take" :depends-on ("package"))
                             (:file "token" :depends-on ("package")))))
  :description ""
  ;; :in-order-to ((test-op (test-op "c/tests")))
  )

;; (defsystem "c/tests"
;;   :author ""
;;   :license ""
;;   :depends-on ("c"
;;                "rove")
;;   :components ((:module "tests"
;;                 :components
;;                 ((:file "main"))))
;;   :description "Test system for c"
;;   :perform (test-op (op c) (symbol-call :rove :run c)))
