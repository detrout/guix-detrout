;;; Copyright © 2016 Diane Trout <diane@ghic.org>
;;;
;;; These are my local package that are not currently part of Guix,
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.
;;;

(define-module (pydata)
  #:use-module ((guix licenses)
                #:select (asl2.0 bsd-4 bsd-3 bsd-2 non-copyleft cc0 x11 x11-style
                          gpl2 gpl2+ gpl3+ lgpl2.0+ lgpl2.1 lgpl2.1+ lgpl3+ agpl3+
                          isc mpl2.0 psfl public-domain x11-style
                          zpl2.1))
  #:use-module ((guix licenses) #:select (expat zlib) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages attr)
  #:use-module (gnu packages backup)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages file)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages icu4c)
  #:use-module (gnu packages image)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages statistics)
  #:use-module (gnu packages texlive)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages web)
  #:use-module (gnu packages base)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages zip)
  #:use-module (gnu packages tcl)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system python)
  #:use-module (guix build-system trivial)
  #:use-module (srfi srfi-1))

(define-public python-bokeh
  (package
    (name "python-bokeh")
    (version "0.10.0")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "bokeh" version))
        (sha256
          (base32
            "056z86hy92jc5cw9rz3yz917f9dypyawrlr8hfib4qigiv4xi2rd"))))
    (build-system python-build-system)
    (inputs
     `(("python-setuptools" ,python-setuptools)
       ("python-six" ,python-six)
       ("python-requests" ,python-requests)
       ("python-pyyaml" ,python-pyyaml)
       ("python-dateutil" ,python-dateutil)
       ("python-jinja2" ,python-jinja2)
       ("python-numpy" ,python-numpy)
       ("python-pandas" ,python-pandas)
       ("python-flask" ,python-flask)  ;; missing
       ("python-pyzmq" ,python-pyzmq)
       ("python-tornado" ,python-tornado)))
    (arguments
     '(#:tests? #f))  ; FIXME tests require selenium which isn't packaged
    (home-page "http://github.com/bokeh/bokeh")
    (synopsis
      "Statistical and novel interactive HTML plots for Python")
    (description
      "Statistical and novel interactive HTML plots for Python")
    (license bsd-3)))

(define-public python2-bokeh
  (package-with-python2 python-bokeh))

(define-public python-odo
  (package
    (name "python-odo")
    (version "0.3.4")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "odo" version))
       (sha256
        (base32
         "0987ldq06xxz8s3fn49y36j0i0b6ga3df9r94zpxkh4sk5rb7gbp"))))
    (build-system python-build-system)
    (inputs
     `(("python-datashape" ,python-datashape)
       ("python-multipledispatch" ,python-multipledispatch)
       ("python-networkx" ,python-networkx)
       ("python-numpy" ,python-numpy)
       ("python-pandas" ,python-pandas)
       ("python-setuptools" ,python-setuptools)
       ("python-toolz" ,python-toolz)))
    (home-page "https://github.com/blaze/odo")
    (synopsis "Data migration utilities")
    (description "Data migration utilities")
    (license bsd-3)))

(define-public python2-odo
  (package-with-python2 python-odo))

(define-public python-datashape
  (package
    (name "python-datashape")
    (version "0.4.7")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "DataShape" version))
       (sha256
        (base32
         "0y52l6xhggrq5s1d1gjqwmjmwiwkyikfi0iih6mm55jcdmvfzchl"))))
    (build-system python-build-system)
    (inputs
     `(("python-dateutil" ,python-dateutil)
       ("python-multipledispatch" ,python-multipledispatch)
       ("python-numpy" ,python-numpy)
       ("python-setuptools" ,python-setuptools)))
    (home-page
     "http://datashape.readthedocs.org/en/latest/")
    (synopsis "A data description language.")
    (description "A data description language.")
    (license bsd-3)))

(define-public python2-datashape
  (package-with-python2 python-datashape))

(define-public python-multipledispatch
  (package
    (name "python-multipledispatch")
    (version "0.4.8")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "multipledispatch" version))
       (sha256
        (base32
         "0bmra61cj5mayszp8qabr8k9j3waz1k8b2p46r2l5s15xnrizm07"))))
    (build-system python-build-system)
    (inputs
     `(("python-setuptools" ,python-setuptools)))
    (home-page
     "http://github.com/mrocklin/multipledispatch/")
    (synopsis "Multiple dispatch")
    (description "Multiple dispatch")
    (license bsd-3)))

(define-public python2-multipledispatch
  (package-with-python2 python-multipledispatch))

(define-public python-toolz
  (package
    (name "python-toolz")
    (version "0.7.4")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "toolz" version))
       (sha256
        (base32
         "1zass275yjn1srw7rgkq6ghvhz9gr2zsk21hpa46qsx1wzjwkhj3"))))
    (build-system python-build-system)
    (inputs
     `(("python-setuptools" ,python-setuptools)))
    (home-page "http://github.com/pytoolz/toolz/")
    (synopsis
     "List processing tools and functional utilities")
    (description
     "List processing tools and functional utilities")
    (license bsd-3)))

(define-public python2-toolz
  (package-with-python2 python-toolz))

(define-public python-django
  (package
    (name "python-django")
    (version "1.8.4")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "Django" version))
       (sha256
        (base32
         "1n3hb80v7wl5j2mry5pfald6i9z42a9c3m9405877iqw3v49csc2"))))
    (build-system python-build-system)
    (inputs
     `(("python-setuptools" ,python-setuptools)))
    (home-page "https://www.djangoproject.com")
    (description
     "A high-level Python Web framework that encourages rapid development and clean, pragmatic design.")
    (synopsis
     "A high-level Python Web framework that encourages rapid development and clean, pragmatic design.")
    (license bsd-3)))

(define-public python2-django
  (package-with-python2 python-django))

(define-public python-psycopg2
  (package
  (name "python-psycopg2")
  (version "2.6.1")
  (source
    (origin
      (method url-fetch)
      (uri (pypi-uri "psycopg2" version))
      (sha256
        (base32
          "0k4hshvrwsh8yagydyxgmd0pjm29lwdxkngcq9fzfzkmpsxrmkva"))))
  (build-system python-build-system)
  (inputs
    `(("python-setuptools" ,python-setuptools)
      ("postgresql" ,postgresql)))
  (home-page "http://initd.org/psycopg/")
  (synopsis
    "psycopg2 - Python-PostgreSQL Database Adapter")
  (description
    "psycopg2 - Python-PostgreSQL Database Adapter")
  (license lgpl3+)))

(define-public python2-psycopg2
  (package-with-python2 python-psycopg2))

(define-public python-flask
  (package
    (name "python-flask")
    (version "0.10.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "Flask" version))
       (sha256
        (base32
         "0wrkavjdjndknhp8ya8j850jq7a1cli4g5a93mg8nh1xz2gq50sc"))))
    (build-system python-build-system)
    (inputs
     `(("python-setuptools" ,python-setuptools)
       ("python-sphinx" ,python-sphinx)
       ("python-werkzeug" ,python-werkzeug)
       ("python-jinja2" ,python-jinja2)
       ("python-itsdangerous" ,python-itsdangerous)
       ("python-simplejson" ,python-simplejson)
       ("python-blinker" ,python-blinker)))
    (arguments
     '(#:tests? #f))  ; FIXME tests fail
    (home-page "http://github.com/mitsuhiko/flask/")
    (synopsis
     "A microframework based on Werkzeug, Jinja2 and good intentions")
    (description
     "A microframework based on Werkzeug, Jinja2 and good intentions")
    (license bsd-3)))

(define-public python2-flask
  (package-with-python2 python-flask))

;; builds
(define-public python-werkzeug
  (package
  (name "python-werkzeug")
  (version "0.11.1")
  (source
    (origin
      (method url-fetch)
      (uri (pypi-uri "Werkzeug" version))
      (sha256
        (base32
          "19z02pv0svpnbjp20r8s1zi4609idpq7ihnb952n1a0zda33f2r8"))))
  (build-system python-build-system)
  (inputs
   `(("python-setuptools" ,python-setuptools)
     ("python-sphinx" ,python-sphinx)
     ("python-pytest" ,python-pytest)
     ("python-requests" ,python-requests)
     ("python-simplejson" ,python-simplejson)
     ("python-nose" ,python-nose)
     ("python-lxml" ,python-lxml)
     ("redis" ,redis)
     ("python-redis" ,python-redis)
     ;; ("memcached" ,memcached)
     ;; ("python-pylibmc" ,python-pylibmc) ;; memcache client
     ))
  (home-page "http://werkzeug.pocoo.org/")
  (synopsis
    "The Swiss Army knife of Python web development")
  (description
    "The Swiss Army knife of Python web development")
  (license bsd-3)))

(define-public python2-werkzeug
  (package-with-python2 python-werkzeug))

;; wsgiref
;; factory_boy
