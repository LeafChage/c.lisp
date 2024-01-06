(in-package ppp/test)

(test test-skip
  (is (@eq (parse (skip (token "hello")
                        (token "world")) "helloworld")
           (result:ok '("hello" ""))))

  (is-false (result:ok? (parse (skip (token "hello")
                                     (token "world"))
                               "world")))

  (is-false (result:ok? (parse (skip (token "hello")
                                     (token "world"))
                               "hello"))))

;; (run! 'test-skip)



