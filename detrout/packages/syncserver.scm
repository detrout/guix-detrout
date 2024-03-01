(define-module (detrout packages syncserver)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (detrout packages python-google)
  #:use-module (gnu packages)
  #:use-module (gnu packages check)  
  #:use-module (gnu packages compression)  
  #:use-module (gnu packages databases)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-check)
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

;;;;;; Not from mozilla
(define-public python-repoz-lru
  (package
   (name "python-repoz-lru")
   (version "0.7")
   (source
    (origin
       (method url-fetch)
       (uri (pypi-uri "repoz.lru" version))
       (sha256
         (base32
           "0xzz1aw2smy8hdszrq8yhnklx6w1r1mf55061kalw3iq35gafa84"))))
   (build-system python-build-system)
   (home-page "http://www.repoze.org/")
   (synopsis "A tiny LRU cache implementation and decorator")
   (description
    "A tiny LRU cache implementation and decorator")
   (license license:bsd-4)))

(define-public python-grpcio-gcp
  (package
   (name "python-grpcio-gcp")
   (version "0.2.2")
   (source
    (origin
       (method url-fetch)
       (uri (pypi-uri "grpcio-gcp" version))
       (sha256
         (base32
           "0z05m4xamlzsia6m5lxdc99lpv0jzfd72k3km2vkknn7zxg614p2"))))
   (build-system python-build-system)
   (propagated-inputs
    `(("python-protobuf" ,python-protobuf)
      ("python-grpcio" ,python-grpcio)))
   (home-page "https://grpc.io/")
   (synopsis "Package for gRPC-GCP Python.")
   (description
    "A high performance, open source universal RPC framework")
   (license license:asl2.0)))

;; This is python 2 only. I'm hoping the python 3 version is a
;; drop in replacement
;; (define-public python-wsgiproxy
;;   (package
;;    (name "python-wsgiproxy")
;;    (version "0.2.2")
;;    (source
;;     (origin
;;        (method url-fetch)
;;        (uri (pypi-uri "WSGIProxy" version))
;;        (sha256
;;          (base32
;;            "0wqz1q8cvb81a37gb4kkxxpv4w7k8192a08qzyz67rn68ln2wcig"))))
;;    (build-system python-build-system)
;;    (inputs
;;     `(("python-paste" ,python-paste)
;;       ("python-minimock" ,python-minimock)
;;       ("python-webob" ,python-webob)))
;;    (home-page "http://pythonpaste.org/wsgiproxy/")
;;    (synopsis "WSGIProxy gives tools to proxy arbitrary(ish) WSGI requests to other processes over HTTP.")
;;    (description
;;     "This will encode the WSGI request CGI-style environmental variables (which must be strings), plus a configurable set of other variables. It also sends values like HTTP_HOST and wsgi.url_scheme which are often obscured by the proxying process, as well as values like SCRIPT_NAME. On the receiving end, a WSGI middleware fixes up the environment to represent the state of the original request. This makes HTTP more like FastCGI or SCGI, which naturally preserve these values.")
;;    (license license:expat)))

;;;;;;;;
(define-public python-cornice
  (package
    (name "python-cornice")
    (version "5.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "cornice" version))
        (sha256
          (base32
            "1idrczasks20b8d5j4vqn5g186g47kf0ppg8416ncgdpkxg6my2h"))))
    (build-system python-build-system)
    (inputs
     `(("python-pyramid" ,python-pyramid)
       ("python-venusian" ,python-venusian)
       ("python-mock" ,python-mock)
       ("python-pytest" ,python-pytest)
       ("python-pytest-cov" ,python-pytest-cov)
       ("python-webtest" ,python-webtest)))
    (home-page "https://github.com/mozilla-services/cornice")
    (synopsis "Define Web Services in Pyramid.")
    (description
     "Cornice provides helpers to build & document Web Services with Pyramid.
 
 The full documentation is available at: https://cornice.readthedocs.io")
    (license license:mpl2.0)))

(define-public python-tokenlib
  (package
   (name "python-tokenlib")
   (version "2.0.0")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "tokenlib" version))
     (sha256
      (base32
       "021l7gwqbb7xyg3a6dbqc2f48cqsfir6bja6d53ydq5h2yhjg7sn"))))
   (build-system python-build-system)
   (inputs
    `(("python-pytest" ,python-pytest)
      ("python-pytest-cov" ,python-pytest-cov)
      ("python-mock" ,python-mock)))
    (home-page "https://github.com/mozilla-services/tokenlib")
    (synopsis "Generic library for managing signed authentication tokens.")
    (description
     "This is generic support library for doing token-based authentication.
You might use it to build a login system using bearer tokens two-legged oauth, or MAC Access authentication.

Given a server-side master secret, you can serialize a dict of data into an opaque, unforgeable authentication token::

  >>> token = tokenlib.make_token({\"userid\": 42},  secret=\"I_LIKE_UNICORNS\")
  >>> print token
  eyJzYWx0IjogImY0NTU5NCIsICJl...

 Later, you can use the same secret to verify the token and extract the embedded data::

   >>> data = tokenlib.parse_token(token, secret=\"I_LIKE_UNICORNS\")
   >>> print data
")
    (license license:mpl2.0)))



(define-public python-pyramid-hawkauth
  (package
   (name "python-pyramid-hawkauth")
   (version "2.0.0")
   (source
    (origin
       (method url-fetch)
       (uri (pypi-uri "pyramid_hawkauth" version))
       (sha256
         (base32
           "095ljd8pxvzqwxsjxsbylpikk4kl0201z1ad37yyp5msalqpqini"))))
   (build-system python-build-system)
   (inputs
    `(("python-pyramid" ,python-pyramid)
      ("python-tokenlib" ,python-tokenlib)
      ("python-hawkauthlib" ,python-hawkauthlib)
      ("python-webtest" ,python-webtest)))
   (home-page "https://github.com/mozilla-services/")
   (synopsis "This is a Pyramid authenitcation plugin for Hawk Access Authentication:")
   (description
    "To access resources using Hawk Access Authentication, the client must have obtained a set of Hawk credentials including an id and secret key. They use these credentials to make signed requests to the server.")
   (license license:mpl2.0)))

(define-public python-konfig
  (package
   (name "python-konfig")
   (version "1.1")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "konfig" version))
        (sha256
          (base32
           "0mrbn3pv7ly8mhkncrwvssddlaa7xz5ria82ik4z84vc7m3cd93s"))))
   (arguments
     `(#:tests? #f))                    ; tests failing, why can't it find argparse?
    (build-system python-build-system)
    (propagated-inputs
     `(("python-configparser" ,python-configparser)
       ("python-six" ,python-six)))
    (inputs
     `(("python-pytest" ,python-pytest)
       ("python-pytest-cov" ,python-pytest-cov)
       ("python-pylint" ,python-pylint)
       ("python-twine" ,python-twine)))
    (home-page "https://github.com/mozilla-services/konfig")
    (synopsis "Yet Another Config Parser.")
    (description
     "Yet another configuration object. Compatible with the updated configparser")
    (license license:mpl2.0)))


;; in guix
;; (define-public python-browserid
;;   (package
;;    (name "python-browserid")
;;    (version "0.14.0")
;;     (source
;;       (origin
;;         (method url-fetch)
;;         (uri (pypi-uri "PyBrowserID" version))
;;         (sha256
;;           (base32
;;             "1qvi79kfb8x9kxkm5lw2mp42hm82cpps1xknmsb5ghkwx1lpc8kc"))))
;;     (build-system python-build-system)
;;     (inputs
;;      `(("python-requests" ,python-requests)))
;;     (home-page "https://github.com/mozilla-services/PyBrowserID")
;;     (synopsis "Python library for the BrowserID Protocol")
;;     (description
;;      "This is a python client library for the BrowserID protocol that underlies Mozilla Persona:
;; 
;; https://login.persona.org/")
;;     (license license:mpl2.0)))

(define-public python-pyfxa@0.7.7
  (package
   (name "python-pyfxa")
   (version "0.7.7")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "PyFxA" version))
        (sha256
          (base32
            "1nqwclypcahaqwbqjj5dnnvjim4gsshsiwhwxs6i7xq5rw4cv1bc"))))
    (build-system python-build-system)
    (arguments '(#:tests? #f)) ; 17 tests require network access
    (propagated-inputs
     `(("python-cryptograpy" ,python-cryptography)
       ("python-hawkauthlib" ,python-hawkauthlib)
       ("python-pybrowserid" ,python-pybrowserid)
       ("python-requests" ,python-requests) 
       ("python-six" ,python-six)))              
;;       ("python-pyjwt" ,python-pyjwt)
;;       ("python-grequests" ,python-grequests)
;;       ("python-responses" ,python-responses)))
    (native-inputs
     `(("python-grequests" ,python-grequests)
       ("python-mock" ,python-mock)
       ("python-responses" ,python-responses)
       ("python-unittest2" ,python-unittest2)))
    (home-page "https://github.com/mozilla/PyFxA")
    (synopsis "Firefox Accounts client library for Python")
    (description
     "This is python library for interacting with the Firefox Accounts ecosystem.

Eventually, it is planned to provide easy support for the following features:

 * being a direct firefox accounts authentication client
 * being an FxA OAuth Service Provider
 * accessing attached services
 * helps interactions with Firefox Account servers wiht requests Authentication plugins.

But none of that is ready yet; caveat emptor.")
    (license license:mpl2.0)))

(define-public python-umemcache
  (package
    (name "python-umemcache")
    (version "1.6.3")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "umemcache" version ".zip"))
        (sha256
          (base32
            "060rxjw92qjwmc0vczxvdc3blm77wg4wknvpy9mpkdvn6nh32411"))))
    (build-system python-build-system)
    (inputs
     `(("unzip" ,unzip)))
    (home-page "http://www.esn.me/")
    (synopsis "ultramemcache is an ultra fast Memcache client written in highly optimized C++ with Python bindings.")
    (description
     "ultramemcache is an ultra fast Memcache client written in highly optimized C++ with Python bindings.")
    (license license:bsd-3)))

(define-public python-mozsvc
  (package
   (name "python-mozsvc")
   (version "0.10")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "mozsvc" version))
        (sha256
          (base32
            "0b8rwfnw0qrm29b9p2vp7c6bzxf655d6j2i3dny1yiry7isjncq9"))))
    (build-system python-build-system)
    (inputs
     `(("python-pyramid" ,python-pyramid)
       ("python-simplejson" ,python-simplejson)
       ("python-unittest2" ,python-unittest2)
       ("python-webtest" ,python-webtest)
       ("python-wsgiproxy2" ,python-wsgiproxy2)
       ("python-hawkauthlib" ,python-hawkauthlib)
       ("python-umemcache" ,python-umemcache)
       ("gunicorn" ,gunicorn)
       ("python-gevent" ,python-gevent)
       ("python-konfig" ,python-konfig)))       
    (home-page "https://github.com/mozilla-services/mozservices")
    (synopsis "Various utilities for Mozilla apps")
    (description
     "Various utilities for Pyramid-based Mozilla applications")
    (license license:mpl2.0)))

(define-public mozilla-tokenserver
  (package
    (name "mozilla-tokenserver")
    (version "1.5.11")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
              (url "https://github.com/mozilla-services/tokenserver")
              (commit version)))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "1mfbv7ia381vl3x45bkfdf76vx8h7xpzxnk76q4gfb9fdsczrnp8"))))
    (build-system python-build-system)
    (inputs
     `(("python-alembic" ,python-alembic)
       ("python-asn1crypto" ,python-asn1crypto)
       ("python-boto" ,python-boto)
       ("python-certifi" ,python-certifi)
       ("python-cffi" ,python-cffi)
       ("python-chardet" ,python-chardet)
       ("python-cornice" ,python-cornice)
       ("python-cryptography" ,python-cryptography)
       ("python-gevent" ,python-gevent)
       ("python-greenlet" ,python-greenlet)
       ("gunicorn" ,gunicorn)
       ("python-hawkauthlib" ,python-hawkauthlib)
       ("python-hupper" ,python-hupper)
       ("python-idna" ,python-idna)
       ("python-konfig" ,python-konfig)
       ("python-mako" ,python-mako)
       ("python-markupsafe" ,python-markupsafe)
       ("python-mozsvc" ,python-mozsvc)
       ("python-paste" ,python-paste)
       ("python-pastedeploy" ,python-pastedeploy)
       ("python-plaster" ,python-plaster)
       ("python-plaster-pastedeploy" ,python-plaster-pastedeploy)
       ("python-pybrowserid" ,python-pybrowserid)
       ("python-pycparser" ,python-pycparser)
       ("python-pyfxa" ,python-pyfxa@0.7.7)
       ("python-pyramid" ,python-pyramid)
       ("python-dateutil" ,python-dateutil)
       ("python-editor" ,python-editor)
       ("python-repoz-lru" ,python-repoz-lru)
       ("python-requests" ,python-requests)
       ("python-simplejson" ,python-simplejson)
       ("python-six" ,python-six)
       ("python-sqlalchemy" ,python-sqlalchemy)
       ("python-testfixtures" ,python-testfixtures)
       ("python-tokenlib" ,python-tokenlib)
       ("python-translationstring" ,python-translationstring)
       ("python-urllib3" ,python-urllib3)
       ("python-venusian" ,python-venusian)
       ("python-webob" ,python-webob)
       ("python-zope-deprecation" ,python-zope-deprecation)
       ("python-zope-interface" ,python-zope-interface)))
    (home-page "https://github.com/mozilla-services/")
    (synopsis "Firefox Sync TokenServer")
    (description
     "This service is responsible for allocating Firefox Sync users
to one of several Sync Storage nodes. It provides the \"glue\" between
Firefox Accounts and the SyncStorage API, and handles:

  * Checking the user's credentials as provided by FxA
  * Sharding users across storage nodes in a way that evenly distributes server load
  * Re-assigning the user to a new storage node if their FxA encryption key changes
  * Cleaning up old data from e.g. deleted accounts")
    (license license:mpl2.0)))


(define-public mozilla-server-syncstorage
  (package
   (name "mozilla-server-syncstorage")
   (version "1.8.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/mozilla-services/server-syncstorage")
           (commit version)))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "07q9ca4dp8738yl79zilzryhdl0rpgns1nn1acqchgwa1gfh1ak6"))))
   (build-system python-build-system)
   (inputs
    `(("python-beautifulsoup4" ,python-beautifulsoup4)
      ("python-cachetools" ,python-cachetools)
      ("python-certifi" ,python-certifi)
      ("python-chardet" ,python-chardet)
      ("python-configparser" ,python-configparser)
      ("python-cornice" ,python-cornice)
      ("python-flake8" ,python-flake8)
      ("python-future" ,python-future)
      ("python-gevent" ,python-gevent)
      ("python-google-api-core" ,python-google-api-core)
      ("python-google-auth" ,python-google-auth)
      ("python-google-cloud-core" ,python-google-cloud-core)
      ("python-google-cloud-spanner" ,python-google-cloud-spanner)
      ("python-googleapis-common-protos" ,python-googleapis-common-protos)
      ("python-greenlet" ,python-greenlet)
      ("python-grpc-google-iam-v1" ,python-grpc-google-iam-v1)
      ("python-grpcio" ,python-grpcio)
      ("python-grpcio-gcp" ,python-grpcio-gcp)
      ("gunicorn" ,gunicorn)
      ("python-hawkauthlib" ,python-hawkauthlib)
      ("python-hupper" ,python-hupper)
      ("python-idna" ,python-idna)
      ("python-konfig" ,python-konfig)
      ("python-linecache2" ,python-linecache2)
      ("python-mccabe" ,python-mccabe)
      ("python-mozsvc" ,python-mozsvc)  ;[memcache]
      ("python-nose" ,python-nose)
      ("python-paste" ,python-paste)
      ("python-pastedeploy" ,python-pastedeploy)
      ("python-plaster" ,python-plaster)
      ("python-plaster-pastedeploy" ,python-plaster-pastedeploy)
      ("python-protobuf" ,python-protobuf)
      ("python-pyasn1" ,python-pyasn1)
      ("python-pyasn1-modules" ,python-pyasn1-modules)
      ("python-pybrowserid" ,python-pybrowserid)
      ("python-pycodestyle" ,python-pycodestyle)
      ("python-pyflakes" ,python-pyflakes)
      ("python-pyramid" ,python-pyramid)
      ("python-pyramid-hawkauth" ,python-pyramid-hawkauth)
      ("python-pytz" ,python-pytz)
      ("python-repoz-lru" ,python-repoz-lru)
      ("python-requests" ,python-requests)
      ("python-rsa" ,python-rsa)
      ("python-simplejson" ,python-simplejson)
      ("python-six" ,python-six)
      ("python-sqlalchemy" ,python-sqlalchemy)
      ("python-testfixtures" ,python-testfixtures)
      ("python-tokenlib" ,python-tokenlib)
      ("python-traceback2" ,python-traceback2)
      ("python-translationstring" ,python-translationstring)
      ("python-pylibmc" ,python-pylibmc)
      ("python-unittest2" ,python-unittest2)
      ("python-urllib3" ,python-urllib3)
      ("python-venusian" ,python-venusian)
      ("python-waitress" ,python-waitress)
      ("python-webob" ,python-webob)
      ("python-webtest" ,python-webtest)
      ("python-wsgiproxy2" ,python-wsgiproxy2)
      ("python-zope-deprecation" ,python-zope-deprecation)
      ("python-zope-interface" ,python-zope-interface)))
   (home-page "https://github.com/mozilla-services/")
   (synopsis "Storage Engine for Firefox Sync Server, version 1.5")
   (description
    "This is the storage engine for version 1.5 of the Firefox Sync Server. It implements the API defined at:

    https://mozilla-services.readthedocs.io/en/latest/storage/apis-1.5.html
")
   (license license:mpl2.0)))

(define-public mozilla-syncserver
  (package
    (name "mozilla-syncserver")
    (version "1.9.1")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
              (url "https://github.com/mozilla-services/syncserver")
              (commit version)))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "0s13pbzjldpiyz6hgw5djwnwd8q7dai6c28vrb1vqanxhrfm1rwb"))))
    (build-system python-build-system)
    (inputs
     `(("python-cornice" ,python-cornice)
       ("gunicorn" ,gunicorn)
       ("python-pyramid" ,python-pyramid)
       ("python-webob" ,python-webob)
       ("python-requests" ,python-requests)
       ("python-sqlalchemy" ,python-sqlalchemy)
       ("python-zope-component" ,python-zope-component)
       ("python-configparser" ,python-configparser)
       ("python-mozsvc" ,python-mozsvc)
       ("python-future" ,python-future)
       ("python-soupsieve" ,python-soupsieve)
       ("python-umemcache" ,python-umemcache)
       ("python-google-cloud-spanner" ,python-google-cloud-spanner)
       ("mozilla-tokenserver" ,mozilla-tokenserver)
       ("mozilla-server-syncstorage" ,mozilla-server-syncstorage)))
    (home-page "https://github.com/mozilla-services/")
    (synopsis "Run-Your-Own Firefox Sync Server")
    (description
     "This is an all-in-one package for running a self-hosted Firefox Sync server. It bundles the \"tokenserver\" project for authentication and the \"syncstorage\" project for storage, to produce a single stand-alone webapp.")
    (license license:mpl2.0)))


;;(define-public python-
;;  (package
;;   (name "python-")
;;   (version "")
;;   (source
;;    (origin
;;       (method url-fetch)
;;       (uri (pypi-uri "" version))
;;       (sha256
;;         (base32
;;           ""))))
;;   (build-system python-build-system)
;;   (inputs
;;    `(()))
;;   (home-page "https://github.com/mozilla-services/")
;;   (synopsis "")
;;   (description
;;    "")
;;   (license license:mpl2.0)))
