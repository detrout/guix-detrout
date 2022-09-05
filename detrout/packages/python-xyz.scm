(define-module (detrout packages python-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages check)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages rust)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system python)
  #:use-module (guix build-system cargo)  ;; needed for maturin
  #:use-module (detrout packages crates-io)
  )

(define-public python-setuptools-65
  (package (inherit python-setuptools)
    (name "python-setuptools")
    (version "65.3.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "setuptools" version))
       (sha256
        (base32
         "0mrvjn0wrjxxcshblpchhmn09gdjc40xpsnapnv8z9bz9wgqfckp"))))))

(define-public python-setuptools-rust-1.5
  (package
   (inherit python-setuptools-rust)
    (name "python-setuptools-rust")
    (version "1.5.1")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "setuptools-rust" version))
              (sha256
               (base32
                "1mxr1r9yvg5mxymgvfv0jc77dh3kvsp704q2n6f44naxcibf818f"))))
    (native-inputs
     (list python-setuptools-scm))
    (propagated-inputs
     (list python-semantic-version
           python-setuptools-65
           python-typing-extensions
           python-wheel))))

; what should this packages name be?
; it's a bunch of rust code to build rust projects that are used with python?
(define-public rust-maturin-0.13
  (package
    (name "rust-maturin")
    (version "0.13.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "maturin" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0vhgi412ayfb8z2g8chh29sf0ribr827b5mjmrkv240m60r53rfb"))))
    (build-system cargo-build-system)
    (propagated-inputs
     `(("rust" ,rust "cargo")))
    (arguments
     `(#:tests? #f                      ;missing files
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1.0.63)
                       ("rust-base64" ,rust-base64-0.13)
                       ("rust-bytesize" ,rust-bytesize-1)
                       ("rust-cargo-options" ,rust-cargo-options-0.3)
                       ("rust-cargo-xwin" ,rust-cargo-xwin-0.10)
                       ("rust-cargo-zigbuild" ,rust-cargo-zigbuild-0.12)
                       ("rust-cargo-metadata" ,rust-cargo-metadata-0.15)
                       ("rust-cbindgen" ,rust-cbindgen-0.24)
                       ("rust-cc" ,rust-cc-1.0.73)
                       ("rust-clap" ,rust-clap-3.2.19)
                       ("rust-clap-complete" ,rust-clap-complete-3)
                       ("rust-clap-complete-fig" ,rust-clap-complete-fig-3)
                       ("rust-configparser" ,rust-configparser-3)
                       ("rust-console" ,rust-console-0.15)
                       ("rust-dialoguer" ,rust-dialoguer-0.10)
                       ("rust-dirs" ,rust-dirs-4)
                       ("rust-dunce" ,rust-dunce-1.0.2)
                       ("rust-fat-macho" ,rust-fat-macho-0.4)
                       ("rust-flate2" ,rust-flate2-1)
                       ("rust-fs-err" ,rust-fs-err-2.7)
                       ("rust-glob" ,rust-glob-0.3)
                       ("rust-goblin" ,rust-goblin-0.5)
                       ("rust-human-panic" ,rust-human-panic-1)
                       ("rust-ignore" ,rust-ignore-0.4)
                       ("rust-keyring" ,rust-keyring-1)
                       ("rust-lddtree" ,rust-lddtree-0.2)
                       ("rust-minijinja" ,rust-minijinja-0.17)
                       ("rust-multipart" ,rust-multipart-0.18)
                       ("rust-native-tls" ,rust-native-tls-0.2.10)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-pep440" ,rust-pep440-0.2)
                       ("rust-platform-info" ,rust-platform-info-0.2)
                       ("rust-pretty-env-logger" ,rust-pretty-env-logger-0.4)
                       ("rust-pyproject-toml" ,rust-pyproject-toml-0.3)
                       ("rust-python-pkginfo" ,rust-python-pkginfo-0.5)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-rpassword" ,rust-rpassword-7)
                       ("rust-rustc-version" ,rust-rustc-version-0.4)
                       ("rust-semver" ,rust-semver-1.0.13)
                       ("rust-serde" ,rust-serde-1.0.144)
                       ("rust-serde-json" ,rust-serde-json-1.0.85)
                       ("rust-sha2" ,rust-sha2-0.10)
                       ("rust-tar" ,rust-tar-0.4.38)
                       ("rust-target-lexicon" ,rust-target-lexicon-0.12.4)
                       ("rust-tempfile" ,rust-tempfile-3)
                       ("rust-textwrap" ,rust-textwrap-0.15)
                       ("rust-thiserror" ,rust-thiserror-1.0.33)
                       ("rust-toml-edit" ,rust-toml-edit-0.14)
                       ("rust-tracing" ,rust-tracing-0.1.36)
                       ("rust-ureq" ,rust-ureq-2)
                       ("rust-which" ,rust-which-4.2)
                       ("rust-zip" ,rust-zip-0.6))
       #:cargo-development-inputs (("rust-indoc" ,rust-indoc-1))))
    (home-page "https://github.com/pyo3/maturin")
    (synopsis
     "Build and publish crates with pyo3, rust-cpython and cffi bindings as well as rust binaries as python packages")
    (description
     "Build and publish crates with pyo3, rust-cpython and cffi bindings as well as
rust binaries as python packages")
    (license (list license:expat license:asl2.0))))

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
