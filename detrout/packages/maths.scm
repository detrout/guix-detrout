(define-module (detrout packages maths)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages check)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-xyz)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system python)
  )

(define-public python-affine
  (package
    (name "python-affine")
    (version "2.3.1")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "affine" version))
              (sha256
               (base32
                "1l5x66jdrlhaxp9fllkjzfq3bz4xx1a0yknrzycszmks2mkdwxnn"))))
    (build-system python-build-system)
    (native-inputs (list python-coveralls python-flake8 python-pydocstyle
                         python-pytest python-pytest-cov))
    (home-page "https://github.com/sgillies/affine")
    (synopsis "Matrices describing affine transformation of the plane.")
    (description "Matrices describing affine transformation of the plane.")
    (license license:bsd-3)))

;; fails looking for /bin/bash
(define-public python-cypari
  (package
    (name "python-cypari")
    (version "2.4.1")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "cypari" version))
              (sha256
               (base32
                "13rv8s9ha5i3x61anlyyk0xw90m2fyx33sj9hwg0gs6d0dlnyvwz"))))
    (build-system python-build-system)
    (propagated-inputs (list bash python-six))
    (home-page "https://bitbucket.org/t3m/cypari")
    (synopsis "Sage's PARI extension, modified to stand alone.")
    (description "Sage's PARI extension, modified to stand alone.")
    (license #f)))

(define-public python-snuggs
  (package
    (name "python-snuggs")
    (version "1.4.7")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "snuggs" version))
              (sha256
               (base32
                "0yv1wayrw9g6k0c2f721kha7wsv0s1fdlxpf5x7f34iqzq9z272h"))))
    (build-system python-build-system)
    (propagated-inputs (list python-numpy python-pyparsing))
    (native-inputs (list python-hypothesis python-pytest))
    (home-page "https://github.com/mapbox/snuggs")
    (synopsis "Snuggs are s-expressions for Numpy")
    (description "Snuggs are s-expressions for Numpy")
    (license license:expat)))
