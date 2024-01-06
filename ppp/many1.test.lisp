(in-package ppp/test)

(test test-many1
  (is (@eq (parse (many1 (digit)) "1111h")
           (result:ok '(("1" "1" "1" "1") "h"))))
  (is-false (result:ok? (parse (many1 (digit)) "hello")))
  )

;; (run! 'test-many1)
