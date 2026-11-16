#lang info
(define collection 'multi)
(define version "0.0.1")
(define pkg-desc "Kiln embedded platform: architecture foundation and documentation only")
(define pkg-authors '(turlamai))
(define license 'MIT)
(define deps '(["base" #:version "9.3"]))
(define build-deps '("rackunit-lib" "scribble-lib" "racket-doc"))
(define test-omit-paths '("build"))
