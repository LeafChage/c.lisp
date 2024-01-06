(in-package ppp/test)

(test test-map
  (is (@eq (parse (-> (digit)
                      (lambda (v) (+ (parse-integer v) 1)))
                  "1hello")
           (result:ok '(2 "hello"))))


  (is-false (result:ok? (parse (-> (digit)
                      (lambda (v) (+ (parse-integer v) 1)))
                  "hello"))))

;; (run! 'test-map)

