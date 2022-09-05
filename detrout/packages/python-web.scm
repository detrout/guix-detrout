(define-module (detrout packages python-web)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-web)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system python)
)

(define-public python-flask-compress
  (package
    (name "python-flask-compress")
    (version "1.12")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "Flask-Compress" version))
              (sha256
               (base32
                "1idgnwabpxcmy083av9ck9mramwbnpkq815sar6qlqcxyfcr85g2"))))
    (build-system python-build-system)
    (inputs (list python-setuptools-scm))
    (propagated-inputs (list python-brotli python-flask))
    (home-page "https://github.com/colour-science/flask-compress")
    (synopsis
     "Compress responses in your Flask app with gzip, deflate or brotli.")
    (description
     "Compress responses in your Flask app with gzip, deflate or brotli.")
    (license license:expat)))
