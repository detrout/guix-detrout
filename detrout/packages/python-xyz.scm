(define-module (detrout packages python-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages check)
  #:use-module (gnu packages python-xyz)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system python)
  #:use-module (detrout packages crates-io)
  )

(define-public python-param
  (package
    (name "python-param")
    (version "1.12.2")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "param" version))
              (sha256
               (base32
                "03wcf6z2n4dwvvna5kfr12m9k4c5jm2pnlfa7py5149jgxfc9k7r"))))
    (build-system python-build-system)
    (native-inputs (list python-flake8 python-pytest python-pytest-cov))
    (home-page "http://param.holoviz.org/")
    (synopsis
     "Make your Python code clearer and more reliable by declaring Parameters.")
    (description
     "Make your Python code clearer and more reliable by declaring Parameters.")
    (license license:bsd-3)))
