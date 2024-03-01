(define-module (detrout packages python-google)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages check)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages rpc)
  #:use-module (gnu packages time)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix build-system python)
  #:use-module (srfi srfi-1))


(define-public python-pyu2f
  (package
   (name "python-pyu2f")
   (version "0.1.5")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "pyu2f" version))
     (sha256
      (base32
       "0srhzdbgdsqwpcw7awqm19yg3xbabqckfvrp8rbpvz2232hs7jm3"))))
   (build-system python-build-system)
   (arguments
    `(#:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'delete-inconvenient-file
           (lambda _
             ;; this file imports wintypes which fails with <=python3.8 on linux
             (delete-file "pyu2f/hid/windows.py")
             #t)))))
   (propagated-inputs
    `(("python-six" ,python-six)))
   (inputs
    `(("python-unittest2" ,python-unittest2)
      ("python-pyfakefs" ,python-pyfakefs)
      ("python-mock" ,python-mock)))
   (home-page "https://github.com/google/pyu2f/")
   (synopsis "U2F host library for interacting with a U2F device over USB.")
   (description
    "pyu2f is a python based U2F host library for Linux, Windows, and MacOS.
It provides functionality for interacting with a U2F device over USB.")
   (license license:asl2.0)))

(define-public python-proto-plus
  (package
   (name "python-proto-plus")
   (version "1.18.1")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "proto-plus" version))
     (sha256
      (base32
       "0j5xyphbq24d3v3bwhijakshyajg2912bjly9cygx87dqxs59i6g"))))
   (build-system python-build-system)
   (inputs
    `(("protobuf" ,protobuf)
      ("python-google-api-core" ,python-google-api-core)))
   (home-page "https://github.com/googleapis/proto-plus-python.git")
   (synopsis "This is a wrapper around protocol buffers so they behave like python types")
   (description
    "This is a wrapper around protocol buffers. Protocol buffers is a
specification format for APIs, such as those inside Google. This library
provides protocol buffer message classes and objects that largely behave
like native Python types.")
   (license license:asl2.0)))


(define-public python-grpc-google-iam-v1
  (package
   (name "python-grpc-google-iam-v1")
   (version "0.12.3")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "grpc-google-iam-v1" version))
     (sha256
      (base32
       "0wmab3lkyf1k4ggg5l0b6066wjwknh6xzh4i3815gx28yrb5pyqb"))))
   (build-system python-build-system)
   (propagated-inputs
    `(("grpc" ,grpc)
      ("python-googleapis-common-protos" ,python-googleapis-common-protos)
      ("python-protobuf" ,python-protobuf)
      ("protobuf" ,protobuf)))
   (arguments
     `(#:tests? #f))                    ; tests failing having trouble importing google.protocols
   (home-page "https://github.com/googleapis/googleapis")
   (synopsis "gRPC library for google-iam-v1")
   (description
    "grpc-google-iam-v1 is the IDL-derived library for the google-iam (v1)
 service in the googleapis repository.")
   (license license:asl2.0)))


(define-public python-google-cloud-spanner
  (package
   (name "python-google-cloud-spanner")
   (version "3.4.0")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "google-cloud-spanner" version))
     (sha256
      (base32
       "0qyv0jsp1vxym50nidwpqpf876d6w3pmy35m6z4cgf5cv6pyk3pj"))))
   (build-system python-build-system)
   (inputs
    `(("python-google-api-core" ,python-google-api-core)
      ("python-google-cloud-core" ,python-google-cloud-core)
      ("python-grpc-google-iam-v1" ,python-grpc-google-iam-v1)
      ("python-proto-plus" ,python-proto-plus)
      ("python-sqlparse" ,python-sqlparse)))
   (home-page "https://github.com/googleapis/python-spanner")
   (synopsis "Scalable database service that offers consistency and scalability")
   (description
    "Cloud Spanner is the world’s first fully managed relational database
service to offer both strong consistency and horizontal scalability
for mission-critical online transaction processing (OLTP)
applications. With Cloud Spanner you enjoy all the traditional
benefits of a relational database; but unlike any other relational
database service, Cloud Spanner scales horizontally to hundreds or
thousands of servers to handle the biggest transactional workloads.")
   (license license:asl2.0)))

;; (define-public python-
;;   (package
;;    (name "python-")
;;    (version "")
;;    (source
;;     (origin
;;      (method url-fetch)
;;      (uri (pypi-uri "" version))
;;      (sha256
;;       (base32
;;        ""))))
;;    (build-system python-build-system)
;;    (inputs
;;     `(()))
;;    (home-page "")
;;    (synopsis "")
;;    (description
;;     "")
;;    (license license:)))

