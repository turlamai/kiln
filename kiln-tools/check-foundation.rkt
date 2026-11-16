#lang racket/base
(require racket/file racket/list racket/path racket/port racket/string)
(provide check-foundation check-markdown-file)

(define required
  '("README.md" "README.zh-CN.md" "LICENSE" "AGENTS.md" "CONTRIBUTING.md"
    "GOVERNANCE.md" "SECURITY.md" "CODE_OF_CONDUCT.md" "THIRD_PARTY_NOTICES.md"
    "CHANGELOG.md" "info.rkt" "kiln-doc/kiln.scrbl" "kiln-doc/info.rkt"
    ".github/workflows/ci.yml" ".github/CODEOWNERS"
    "docs/README.md" "docs/architecture.md" "docs/requirements.md"
    "docs/language-contract.md" "docs/ir.md" "docs/runtime-and-hardware.md"
    "docs/validation.md" "docs/risks.md" "docs/roadmap.md"
    "docs/release-policy.md" "docs/repository-survey.md" "docs/handoff.md"
    "docs/getting-started.md" "docs/getting-started.zh-CN.md"
    "docs/adr/README.md" "docs/adr/0001-racket-ecosystem.md"
    "docs/adr/0002-native-c-pipeline.md" "docs/adr/0003-runtime-and-target.md"
    "docs/adr/0004-open-infrastructure.md"))

;; This checker supports the inline links and ATX headings used in this repo.
;; It intentionally does not pretend to be a general Markdown parser.
(define (without-fences body)
  (define fenced? #f)
  (string-join
   (for/list ([line (in-list (string-split body "\n"))])
     (cond [(regexp-match? #px"^\\s*```" line)
            (set! fenced? (not fenced?)) ""]
           [fenced? ""] [else line])) "\n"))

(define (heading-anchors body)
  (define counts (make-hash))
  (for/list ([title (in-list (regexp-match* #px"(?m:^#{1,6} +([^\n]+))"
                                          (without-fences body)
                                          #:match-select cadr))])
    (define slug
      (regexp-replace* #px" +"
                       (list->string
                        (filter (lambda (c) (or (char-alphabetic? c) (char-numeric? c)
                                                (memq c '(#\_ #\space #\-))))
                                (string->list (string-downcase (string-trim title))))) "-"))
    (define count (hash-ref counts slug 0))
    (hash-set! counts slug (add1 count))
    (if (zero? count) slug (format "~a-~a" slug count))))

(define (check-markdown-file file)
  (define body (file->string file))
  (append-map
   (lambda (destination)
     (cond
       [(regexp-match? #px"^[a-zA-Z][a-zA-Z0-9+.-]*:" destination) '()]
       [else
        (define pieces (string-split destination "#" #:trim? #f))
        (define target (if (string=? (car pieces) "") file
                           (build-path (path-only (path->complete-path file)) (car pieces))))
        (cond
          [(not (or (file-exists? target) (directory-exists? target)))
           (list (format "~a: missing link ~a" file destination))]
          [(and (> (length pieces) 1) (not (string=? (cadr pieces) ""))
                (regexp-match? #rx"\\.md$" (path->string target))
                (not (member (cadr pieces) (heading-anchors (file->string target)))))
           (list (format "~a: missing anchor ~a" file destination))]
          [else '()])]))
   (regexp-match* #px"\\[[^]\n]*\\]\\(([^()\\s]+)\\)"
                  (without-fences body) #:match-select cadr)))

(define (check-foundation root)
  (define missing
    (for/list ([entry (in-list required)]
               #:unless (file-exists? (build-path root entry)))
      (format "missing required file: ~a" entry)))
  (define md-files
    (for/list ([file (in-directory root
                                   (lambda (p)
                                     (not (member (path->string (file-name-from-path p))
                                                  '(".git" "build" "compiled"))))) ]
               #:when (and (file-exists? file) (regexp-match? #rx"\\.md$" (path->string file))))
      file))
  (append missing
          (append-map check-markdown-file md-files)
          (for*/list ([pair (in-list '(("README.md" "README.zh-CN.md")
                                      ("README.zh-CN.md" "README.md")
                                      ("docs/getting-started.md" "getting-started.zh-CN.md")
                                      ("docs/getting-started.zh-CN.md" "getting-started.md")))]
                      #:when (file-exists? (build-path root (car pair)))
                      #:unless (string-contains? (file->string (build-path root (car pair)))
                                                 (format "](~a)" (cadr pair))))
            (format "missing reciprocal language link: ~a" (car pair)))
          (append-map
           (lambda (file)
             (define body (file->string file))
             (for/list ([marker (in-list '("Status:" "Date:" "## Context" "## Decision"
                                                   "## Alternatives" "## Consequences"))]
                        #:unless (string-contains? body marker))
               (format "~a: missing ADR field ~a" file marker)))
           (filter (lambda (p) (regexp-match? #rx"[/\\\\]adr[/\\\\][0-9]+-" (path->string p))) md-files))))

(module+ main
  (define errors (check-foundation (current-directory)))
  (for ([message (in-list errors)]) (displayln message (current-error-port)))
  (if (null? errors)
      (displayln "Foundation checks passed (documentation only; no MCU validation).")
      (exit 1)))
