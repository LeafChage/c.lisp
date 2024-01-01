(defsystem "ppp"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ("str" "alexandria")
  :components ((:module "src/ppp"
                :components ((:file "util")
                             (:file "result" :depends-on ("util"))
                             (:file "package" :depends-on ("result" "util"))
                             (:file "parser" :depends-on ("package"))
                             (:file "and" :depends-on ("package"))
                             (:file "or" :depends-on ("package"))
                             (:file "map" :depends-on ("package"))
                             (:file "any" :depends-on ("package"))
                             (:file "digit" :depends-on ("package"))
                             (:file "letter" :depends-on ("package"))
                             (:file "many" :depends-on ("package"))
                             (:file "many1" :depends-on ("package"))
                             (:file "take" :depends-on ("package"))
                             (:file "token" :depends-on ("package"))
                             (:file "devide-by" :depends-on ("package"))
                             (:file "choice" :depends-on ("package"))
                             (:file "skip" :depends-on ("package"))
                             (:file "option" :depends-on ("package"))
                             (:file "with" :depends-on ("package"))
                             (:file "lazy" :depends-on ("package"))
                             (:file "defined" :depends-on ("package"))
                             )))
  :description ""
  ;; :in-order-to ((test-op (test-op "c/tests")))
  )

(defsystem "c"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ("ppp" "uiop"  "alexandria")
  :components ((:module "src"
                :components
                ((:file "main" :depends-on ("code" "parser"))
                 (:file "parser" :DEPENDS-ON ("node"))
                 (:file "node")
                 (:file "code" :depends-on ("parser")))))
  :description ""
  :in-order-to ((test-op (test-op "c/tests"))))


(defsystem "c/tests"
  :author ""
  :license ""
  :depends-on ("c"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for c"
  :perform (test-op (op c) (symbol-call :rove :run c)))
