(in-package :ppp/test)

(test test-eof
  (is (@eq (parse (eof) "")
           (result:ok (list (string #\0) ""))))

  (is-false (result:ok? (parse (eof) "hello"))))

;; (run! 'test-eof)
