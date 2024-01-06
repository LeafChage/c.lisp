(in-package ppp/test)

(test test-lazy
  (is (@eq (parse (lazy #'digit) "1hi")
           (result:ok '("1" "hi"))))
  (is-false (result:ok?
              (parse (lazy #'digit) "hi"))))

(run! 'test-lazy)
