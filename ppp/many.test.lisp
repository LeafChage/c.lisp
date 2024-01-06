(in-package ppp/test)

(test test-many
  (is (@eq (parse (many (digit)) "1111h")
           (result:ok '(("1" "1" "1" "1") "h"))))
  (is (@eq (parse (many (digit)) "hello")
           (result:ok '(() "hello"))))
  )

;; (run! 'test-many)
