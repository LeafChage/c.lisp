(in-package ppp/test)

(test test-token
  (is (@eq (parse (token "hello") "helloworld")
           (result:ok '("hello" "world"))))

  (is-false (result:ok? (parse (token "hello") "world"))))

;; (run! 'test-token)
