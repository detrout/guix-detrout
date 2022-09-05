(define-module (detrout packages compression)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages rust)
  #:use-module (guix build-system cargo)
  #:use-module (guix build-system python)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module (detrout packages python-xyz)
  )

(define-public rust-mimalloc-0.1.24
  (package (inherit rust-mimalloc-0.1)
    (name "rust-mimalloc")
    (version "0.1.24")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "mimalloc" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         ;"1yrx0g16nhkkhygdkvnpwf7kjqy73y5x3dlnmj4ydrfimw8nnz0y"  ; 1.25
         "0gd9d0bcxwylgmfnqsrpsr71d1zyl8gf04nr964hilmki30zwzkm"))))
    (arguments
     `(#:cargo-inputs
       (("rust-libmimalloc-sys" ,rust-libmimalloc-sys-0.1.24))))))


(define-public rust-libmimalloc-sys-0.1.24
  (package (inherit rust-libmimalloc-sys-0.1)
    (name "rust-mimalloc-sys")
    (version "0.1.24")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "libmimalloc-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         ;"0b1fi84giac7lsg0v2p39xbnn735prnqr2gpbpslh12ma9h17jhi"; 1.25
         "0s8ab4nc33qgk9jybpv0zxcb75jgwwjb7fsab1rkyjgdyr0gq1bp" ; 1.24
         ))))))

(define-public rust-pyo3-build-config-0.17
  (package (inherit rust-pyo3-build-config-0.15)
    (name "rust-pyo3-build-config")
    (version "0.17.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "pyo3-build-config" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0yd4dd9499mgzbyn5ib7dd6mxg89kg7nnkjmyfarkw7l426g2k7w"))))))

(define-public rust-pyo3-0.17
  (package (inherit rust-pyo3-0.15)
    (name "rust-pyo3")
    (version "0.17.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "pyo3" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1q9ir2n75l3fa1xh12gdzp1sp25xir8sd1h9i8wr21r3l0w2bxqj"))))
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-pyo3-build-config" ,rust-pyo3-build-config-0.17))) )))

(define-public rust-numpy-0.17
  (package
    (name "rust-numpy")
    (version "0.17.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "numpy" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "04w4j8d0c4ya16sqz1fxyhfgzaffpynxpxf7lwr28lqgg0paq8k5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-ahash" ,rust-ahash-0.7)
                       ("rust-half" ,rust-half-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-ndarray" ,rust-ndarray-0.15)
                       ("rust-num-complex" ,rust-num-complex-0.4)
                       ("rust-num-integer" ,rust-num-integer-0.1)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-pyo3" ,rust-pyo3-0.17))
       #:cargo-development-inputs (("rust-pyo3" ,rust-pyo3-0.17))))
    (home-page "https://github.com/PyO3/rust-numpy")
    (synopsis "PyO3-based Rust bindings of the NumPy C-API")
    (description "PyO3-based Rust bindings of the NumPy C-API")
    (license license:bsd-2)))

(define-public rust-numpy-0.15
  (package (inherit rust-numpy-0.17)
    (name "rust-numpy")
    (version "0.15.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "numpy" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1qd6qb8cq4gqd4dm7xlzk83zlp5qsmqfjn8yx46yx25as46ijfkz"))))))

(define-public python-cramjam
  (package
    (name "python-cramjam")
    (version "2.5.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "cramjam" version))
              (sha256
               (base32
                "11xln8v7qg8jm01cjc9si5x9x14zliy3q9gsmx7818y6nhnhqb59"))))
    (build-system cargo-build-system)
    ;;(build-system python-build-system)
    (native-inputs
     (list python-black
           python-numpy
           python-pytest
           python-hypothesis
           python-wrapper
           rust-maturin-0.13))
    (arguments
     `(#:cargo-inputs
       (("rust-brotli2" ,rust-brotli2-0.3)
        ("rust-bzip2" ,rust-bzip2-0.4)
        ("rust-flate2" ,rust-flate2-1)
        ("rust-lz4" ,rust-lz4-1)
        ("rust-mimalloc" ,rust-mimalloc-0.1.24)
        ("rust-numpy" ,rust-numpy-0.15)
        ("rust-snap" ,rust-snap-1)
        ("rust-zstd" ,rust-zstd-0.9))
       #:cargo-development-inputs
       (("rust-pyo3" ,rust-pyo3-0.15))
       #:phases
       (modify-phases %standard-phases
         (delete 'check)
         (replace 'build
           (lambda* (#:key inputs #:allow-other-keys)
             (let ((python3 (search-input-file inputs "/bin/python3")))
               (invoke "maturin" "build" "-i" python3))))
         (replace 'install
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (let ((out (assoc-ref outputs "out")))
               (for-each (lambda (wheel)
                           (format #true wheel)
                           (invoke "python" "-m" "pip" "install"
                                   wheel (string-append "--prefix=" out)))
                         (find-files "target" "\\.whl$")))))
         )))
    (home-page "")
    (synopsis "Thin Python bindings to de/compression algorithms in Rust")
    (description "Thin Python bindings to de/compression algorithms in Rust")
    (license license:expat)))
