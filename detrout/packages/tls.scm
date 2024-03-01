(define-module (detrout packages tls)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system go)
  #:use-module (guix build-system perl)
  #:use-module (guix build-system python)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages)
  #:use-module (gnu packages augeas)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages check)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages dns)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages hurd)
  #:use-module (gnu packages libbsd)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages libidn)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages nettle)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages sphinx)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages time)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages base)
  #:use-module (srfi srfi-1))

(define-public python-augeas
  (package
    (name "python-augeas")
    (version "1.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "python-augeas" version))
       (sha256
        (base32
         "131vzy7bnnqdglz6hd79zkkdqfbyz0rxhwsz0mbzq3xlhsga952i"))))
    (build-system python-build-system)
    (propagated-inputs
     `(("python-cffi" ,python-cffi)
       ("augeas" ,augeas)))
    (home-page "http://augeas.net/")
    (synopsis "Python bindings for Augeas")
    (description "Python bindings for Augeas")
    (license license:lgpl2.1)))

(define-public python-certbot-apache
  (package
    (name "python-certbot-apache")
    ;; Certbot and python-acme are developed in the same repository, and their
    ;; versions should remain synchronized.
    (version "1.14.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "certbot-apache" version))
              (sha256
               (base32
                "1c5d46iwhiw43ld0zivv4lci4z7blv5vla4l5if1xppj3aif8zw8"))))
    (build-system python-build-system)
    (native-inputs
     `(("python-mock" ,python-mock)
       ("python-pytest" ,python-pytest)))
    (propagated-inputs
     `(("python-acme" ,python-acme)
       ("python-augeas" ,python-augeas)
       ("python-configargparse" ,python-configargparse)
       ("python-pyrfc3339" ,python-pyrfc3339)
       ("python-pyopenssl" ,python-pyopenssl)
       ("python-parsedatetime" ,python-parsedatetime)
       ("python-requests" ,python-requests)
       ("python-six" ,python-six)
       ("python-pytz" ,python-pytz)
       ("python-zope-component" ,python-zope-component)
       ("python-zope-interface" ,python-zope-interface)))
    (synopsis "Apache plugin for Certbot")
    (description "The objective of Certbot, Let's Encrypt, and the ACME (Automated
 Certificate Management Environment) protocol is to make it possible
 to set up an HTTPS server and have it automatically obtain a
 browser-trusted certificate, without any human intervention.  This is
 accomplished by running a certificate management agent on the web
 server.

 This agent is used to:

   - Automatically prove to the Let's Encrypt CA that you control the website
   - Obtain a browser-trusted certificate and set it up on your web server
   - Keep track of when your certificate is going to expire, and renew it
   - Help you revoke the certificate if that ever becomes necessary.

 This package contains the Apache plugin to the main application.")
    (home-page "https://certbot.eff.org/")
    (license license:asl2.0)))
