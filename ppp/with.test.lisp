(in-package ppp/test)

(test test-with
  (is (@eq (parse (with (token "hello")
                        (token "world")) "helloworld")
           (result:ok '("world" ""))))

  (is-false (result:ok? (parse (with (token "hello")
                                     (token "world"))
                               "world")))

  (is-false (result:ok? (parse (with (token "hello")
                                     (token "world"))
                               "hello"))))

;; (run! 'test-with)
