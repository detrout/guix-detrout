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

(define-module (detrout packages pydata)
  #:use-module ((guix licenses)
                #:select ( bsd-4 bsd-3 gpl3+ lgpl3+ ))
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages time)
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
    (version "0.11.1")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "bokeh" version))
        (sha256
          (base32
            "0wn4sfs06sq70xizdb3sgs5bhxlzisn5qy4zrjpgmmp7d27kv9rl"))))
    (build-system python-build-system)
    (inputs
     `(("python-six" ,python-six)
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
       ("python-numpy" ,python-numpy)))
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
    (home-page "http://github.com/pytoolz/toolz/")
    (synopsis
     "List processing tools and functional utilities")
    (description
     "List processing tools and functional utilities")
    (license bsd-3)))

(define-public python2-toolz
  (package-with-python2 python-toolz))
