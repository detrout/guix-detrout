(define-module (detrout packages networking)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages check)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (guix build-system python)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  )

(define-public python-avro
  (package
    (name "python-avro")
    (version "1.11.1")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "avro" version))
              (sha256
               (base32
                "02600vxgna953dfqc25iqhyc2h112s2yvy0lrqh0x3b4rhz648zi"))))
    (build-system python-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (replace 'check
           (lambda* (#:key tests? #:allow-other-keys)
             (when tests?
               (invoke "pytest" "-k" "not" "(mock_tether_parent)")))))))
    (home-page "https://avro.apache.org/")
    (synopsis "Avro is a serialization and RPC framework.")
    (description "Avro is a serialization and RPC framework.")
    (license #f)))

(define-public python-confluent-kafka
  (package
    (name "python-confluent-kafka")
    (version "1.9.2")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "confluent-kafka" version))
              (sha256
               (base32
                "0qljhijkc1808yfkbip9mk7j6brsgakmm23rw2gxass3bp97pf9g"))))
    (build-system python-build-system)
    (native-inputs (list librdkafka-1.9
                         python-avro
                         python-fastavro
                         python-flake8
                         python-pytest
                         python-pytest-timeout
                         python-requests))
    (home-page "https://github.com/confluentinc/confluent-kafka-python")
    (synopsis "Confluent's Python client for Apache Kafka")
    (description "Confluent's Python client for Apache Kafka")
    (license #f)))

(define-public python-fastavro
  (package
    (name "python-fastavro")
    (version "1.6.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "fastavro" version))
              (sha256
               (base32
                "0zsqpgqxnd3kjdcfk44jw0v0hlfq0pp5rgalppf5zjxs3cb9nxb4"))))
    (build-system python-build-system)
    (native-inputs (list python-numpy python-pytest))
    (home-page "https://github.com/fastavro/fastavro")
    (synopsis "Fast read/write of AVRO files")
    (description "Fast read/write of AVRO files")
    (license license:expat)))

(define-public python-pure-sasl
  (package
    (name "python-pure-sasl")
    (version "0.6.2")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "pure-sasl" version))
              (sha256
               (base32
                "1x1qa61xqpx6xshgm4qir0hdr3ji6ps6m6ncna2jnpm9bmgkbhak"))))
    (build-system python-build-system)
    (home-page "http://github.com/thobbs/pure-sasl")
    (synopsis "Pure Python client SASL implementation")
    (description "Pure Python client SASL implementation")
    (license license:expat)))

(define-public librdkafka-1.9
  (package (inherit librdkafka)
    (name "librdkafka")
    (version "1.9.2")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/edenhill/librdkafka")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1ixa8fbv3brjhjhvby1ivgip8j7l068vmylzgx1yvn4rpnyx7ahv"))))
    (arguments
     '(#:phases
       (modify-phases %standard-phases
         (replace 'configure
           ;; its custom configure script doesn't understand 'CONFIG_SHELL'.
           (lambda* (#:key outputs #:allow-other-keys)
             (let ((out (assoc-ref outputs "out")))
               ;; librdkafka++.so lacks RUNPATH for librdkafka.so
               (setenv "LDFLAGS"
                       (string-append "-Wl,-rpath=" out "/lib"))
               (invoke "./configure"
                       (string-append "--prefix=" out)))))
         (replace 'install
            (lambda* (#:key outputs #:allow-other-keys)
              (let ((out (assoc-ref outputs "out")))
                (setenv "INSTALL" "install")
                (invoke "make" "INSTALL=install" "install")))))))
))
