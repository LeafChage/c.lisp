(defsystem "c"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ("pigeon"
               "ppp"
               "uiop"
               "alexandria")
  :components ((:module "src"
                :components
                ((:file "main" :depends-on ("code" "parser"))
                 (:file "parser" :DEPENDS-ON ("node"))
                 (:file "code" :DEPENDS-ON ("node"))
                 (:file "node"))))
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
