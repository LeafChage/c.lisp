(defsystem "ppp"
  :depends-on ("pigeon"
               "str"
               "alexandria")
  :components ((:module "main"
                :pathname "./"
                :components ((:file "package" :depends-on ("parsers" "defined"))
                             (:file "defined" :depends-on ("parsers"))
                             (:module "parsers"
                              :pathname "./"
                              :depends-on ("core")
                              :components ((:file "eof" )
                                           (:file "any" )
                                           (:file "digit" )
                                           (:file "letter" )
                                           (:file "take" )
                                           (:file "token" )
                                           (:file "skip")
                                           (:file "with")
                                           (:file "option")
                                           (:file "lazy")
                                           (:file "debug")
                                           (:file "check")
                                           (:file "or")
                                           (:file "and")
                                           (:file "map")
                                           (:file "many")
                                           (:file "many1" :depends-on ("many"))
                                           (:file "devide-by" :depends-on ("many" "and"))
                                           (:file "choice")))
                             (:module "core"
                              :pathname "./"
                              :components ((:file "error")
                                           (:file "parser")
                                           (:file "util")))))

               ))


(defsystem "ppp/test"
  :depends-on ("fiveam" "pigeon" "ppp")
  :components ((:file "test" :depends-on ("tests"))
               (:module "tests"
                :pathname "./"
                :depends-on ("package-test")
                :components ((:file "eof.test")
                             (:file "any.test")
                             (:file "digit.test")
                             (:file "letter.test")
                             (:file "take.test")
                             (:file "token.test")
                             (:file "skip.test")
                             (:file "with.test")
                             (:file "option.test")
                             (:file "lazy.test")
                             (:file "check.test")
                             (:file "or.test" )
                             (:file "and.test" )
                             (:file "map.test" )
                             (:file "many.test" )
                             (:file "many1.test" )
                             (:file "devide-by.test" )
                             (:file "choice.test" )
                             (:file "defined.test" )))
                (:module "package-test"
                 :pathname "./"
                 :components ((:file "package.test")))))



