#lang racket/base
(require racket/file racket/path racket/runtime-path
         "../kiln-tools/check-foundation.rkt")
(define-runtime-path root "..")

(module+ test
  (require rackunit)
  (check-equal? (check-foundation root) '())
  (define temporary (make-temporary-file "kiln-foundation-~a" 'directory))
  (dynamic-wind
    void
    (lambda ()
      (define source (build-path temporary "source.md"))
      (define target (build-path temporary "target.md"))
      (define (write-source text)
        (display-to-file text source #:exists 'truncate/replace))
      (display-to-file "# Valid heading\n\n# Valid heading\n" target)
      (write-source "[valid](target.md#valid-heading)\n[duplicate](target.md#valid-heading-1)\n[remote](https://example.com/path)\n")
      (check-equal? (check-markdown-file source) '())
      (write-source "[broken](absent.md)\n")
      (check-equal? (length (check-markdown-file source)) 1)
      (write-source "[broken](target.md#absent)\n")
      (check-equal? (length (check-markdown-file source)) 1)
      (write-source "```sh\n[example](absent.md)\n```\n[valid](target.md)\n")
      (check-equal? (check-markdown-file source) '())
      (check-not-equal? (check-foundation temporary) '()))
    (lambda () (delete-directory/files temporary))))
