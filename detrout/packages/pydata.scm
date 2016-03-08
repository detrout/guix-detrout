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
  #:use-module (gnu packages qt)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system python)
  #:use-module (guix build-system trivial)
  #:use-module (srfi srfi-1))

;;(define-public python-pandas
;;  (package
;;    (inherit python-pandas)
;;    (version "0.17.1")
;;    (source (origin
;;              (method url-fetch)
;;              (uri (pypi-uri "pandas" version))
;;              (sha256
;;               (base32 "1j95yx32ggqx8jf13h3c8qfp34ixpyg8ipqcdjmn143d6q67rmf6"))))))

;;; New packages

(define-public python-jupyter-core
  (package
    (name "python-jupyter-core")
    (version "4.0.6")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "jupyter_core" version))
       (sha256
        (base32
         "130rgmq3bx5g3m16287gaf5a3mygn1y6pckhc9vzg3q13lxqm9ln"))))
    (build-system python-build-system)
    (arguments
     `(#:phases
       (alist-cons-after
        'install 'check
        (lambda _
          (with-directory-excursion "/tmp"
            (system* "nosetests" "-v" "jupyter_core")))
        (alist-delete 'check %standard-phases))))
    (propagated-inputs
     `(("python-traitlets" ,python-traitlets)))
    (inputs
     `(("python-setuptools" ,python-setuptools)))
    (home-page "http://jupyter.org")
    (synopsis
     "Jupyter core package. A base package on which Jupyter projects rely.")
    (description
     "Jupyter core package. A base package on which Jupyter projects rely.")
    (license bsd-3)))

(define-public python2-jupyter-core
  (package-with-python2 python-jupyter-core))

(define-public python-nbformat
  (package
    (name "python-nbformat")
    (version "4.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "nbformat" version))
       (sha256
        (base32
         "1dax510ydx51c64kg7n6hb5ajaqnfn9xaf63hz9zr7cvb1bwjqaj"))))
    (build-system python-build-system)
    (arguments
     `(#:phases
       (alist-cons-after
        'install 'check
        (lambda _
          (with-directory-excursion "/tmp"
            (system* "nosetests" "-v" "nbformat")))
        (alist-delete 'check %standard-phases))))
    (propagated-inputs
     `(("python-ipython-genutils" ,python-ipython-genutils)
       ("python-traitlets" ,python-traitlets)
       ("python-jsonschema" ,python-jsonschema) ;; >= 2.0 && !=2.5.0
       ("python-jupyter-core" ,python-jupyter-core)
       ))
    (inputs
     `(("python-setuptools" ,python-setuptools)
       ("python-nose" ,python-nose)))
    (home-page "http://jupyter.org")
    (synopsis "The Jupyter Notebook format")
    (description "The Jupyter Notebook format")
    (license bsd-3)))

(define-public python2-nbformat
  (package-with-python2 python-nbformat))

(define-public python-nbconvert
  (package
    (name "python-nbconvert")
    (version "4.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "nbconvert" version))
       (sha256
        (base32
         "076gsh1a9vj9vf5ifd51hcrdpwd3mfvf6y7n5382gl9x552nwag0"))))
    (build-system python-build-system)
    (arguments
     `(#:phases
       (alist-cons-after
        'install 'check
        (lambda _
          (with-directory-excursion "/tmp"
            (system* "nosetests" "-v" "nbconvert")))
        (alist-delete 'check %standard-phases))))
    (propagated-inputs
     `(("python-mistune" ,python-mistune) ;; != 0.6
       ("python-jinja2" ,python-jinja2)
       ("python-pygments" ,python-pygments)
       ("python-traitlets" ,python-traitlets)
       ("python-jupyter-core" ,python-jupyter-core)
       ("python-nbformat" ,python-nbformat)
       ))
    (inputs
     `(("python-setuptools" ,python-setuptools)
       ("python-nose" ,python-nose)))
    (home-page "http://jupyter.org")
    (synopsis "Converting Jupyter Notebooks")
    (description "Converting Jupyter Notebooks")
    (license bsd-3)))

(define-public python2-nbconvert
  (package-with-python2 python-nbconvert))

(define-public python-jupyter-client
  (package
    (name "python-jupyter-client")
    (version "4.1.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "jupyter_client" version))
       (sha256
        (base32
         "1f5x4k2v0ljj7fdq39q2c5g5kcacgf32jqzc8vdn46h3qg3ga7pz"))))
    (build-system python-build-system)
    (arguments
     ;; tests depend on ipykernel which hasn't been built yet.
     `(#:tests? #f))
    (propagated-inputs
     `(("python-traitlets" ,python-traitlets)
       ("python-jupyter-core" ,python-jupyter-core)
       ("python-pyzmq" ,python-pyzmq)))
       ;; test wants ipykernel but that makes a cycle
    (inputs
     `(("python-setuptools" ,python-setuptools)))
    (home-page "http://jupyter.org")
    (synopsis
     "Jupyter protocol implementation and client libraries")
    (description
     "Jupyter protocol implementation and client libraries")
    (license bsd-3)))

(define-public python2-jupyter-client
  (package-with-python2 python-jupyter-client))

(define-public python-ipykernel
  (package
    (name "python-ipykernel")
    (version "4.2.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "ipykernel" version))
       (sha256
        (base32
         "1c4q08ism9mr3k7iq5wn26mjn1azlmm8xpdb0p1w5khsw11xlxm8"))))
    (build-system python-build-system)
    (arguments
     `(#:phases
       (alist-cons-after
        'install 'check
        (lambda _
          (with-directory-excursion "/tmp"
            (system* "nosetests" "-v" "ipykernel")))
        (alist-delete 'check %standard-phases))))
    (propagated-inputs
     `(("python-ipython" ,python-ipython)
       ("python-traitlets" ,python-traitlets)
       ("python-jupyter-client" ,python-jupyter-client)))
    (inputs
     `(("python-setuptools" ,python-setuptools)
       ("python-nose" ,python-nose)))
    (home-page "http://ipython.org")
    (synopsis "IPython Kernel for Jupyter")
    (description "IPython Kernel for Jupyter")
    (license bsd-3)))

(define-public python2-ipykernel
  (package-with-python2 python-ipykernel))

(define-public python-ipython
  (package
    (name "python-ipython")
    (version "4.1.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "ipython" version))
       (sha256
        (base32
         "13z3flczxphp9rqapdwxj93m5yl75is7286pvswhdhvfvzgl1cqw"))))
    (build-system python-build-system)
    (arguments
     '(#:tests? #f)) ; no source package for testpath
    (propagated-inputs
     `(("python-decorator" ,python-decorator)
       ("python-pickleshare" ,python-pickleshare)
       ("python-simplegeneric" ,python-simplegeneric)
       ("python-traitlets" ,python-traitlets)
       ("python-nbformat" ,python-nbformat)
       ("python-nbconvert" ,python-nbconvert)))
       ;; extra_requires that create loops ipython
       ;;("python-ipywidgets" ,python-ipywidgets)
       ;;("python-ipyparallel" ,python-ipyparallel)
       ;;("python-qtconsole" ,python-qtconsole)
       ;;("python-ipykernel" ,python-ipykernel)
    (inputs
     `(("python-setuptools" ,python-setuptools)
       ;; for tests
       ;;("python-nose" ,python-nose)
       ;;("python-requests" ,python-requests)
       ;;("python-testpath" ,python-testpath)
       ;;("python-pygments" ,python-pygments)
       ;; for docs
       ("python-sphinx" ,python-sphinx)))
    (home-page "http://ipython.org")
    (synopsis
     "IPython: Productive Interactive Computing")
    (description
     "IPython: Productive Interactive Computing")
    (license bsd-3)))

(define-public python2-ipython
  (package-with-python2 python-ipython))

(define-public python-ipyparallel
  (package
    (name "python-ipyparallel")
    (version "5.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "ipyparallel" version))
       (sha256
        (base32
         "1cpydbm1k02y5m4grp0c1z5lbgkpp5f4xp3j5v49g9lmd70ikqs8"))))
    (build-system python-build-system)
    (arguments
     `(#:phases
       (alist-cons-after
        'install 'check
        (lambda _
          (with-directory-excursion "/tmp"
            (system* "nosetests" "-v" "ipyparallel")))
        (alist-delete 'check %standard-phases))))
    (propagated-inputs
     `(("python-ipython-genutils" ,python-ipython-genutils)
       ("python-decorator" ,python-decorator)
       ("python-pyzmq" ,python-pyzmq)
       ("python-ipython" ,python-ipython)
       ("python-jupyter-client" ,python-jupyter-client)
       ("python-ipykernel" ,python-ipykernel)
       ("python-tornado" ,python-tornado)
       ))
    (inputs
     `(("python-setuptools" ,python-setuptools)
       ("python-nose" ,python-nose)))
    (home-page "http://ipython.org")
    (synopsis
     "Interactive Parallel Computing with IPython")
    (description
     "Interactive Parallel Computing with IPython")
    (license bsd-3)))

(define-public python2-ipyparallel
  (package-with-python2 python-ipyparallel))

(define-public python-jupyter-console
  (package
    (name "python-jupyter-console")
    (version "4.1.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "jupyter_console" version))
       (sha256
        (base32
         "1qsa9h7db8qzd4hg9l5mfl8299y4i7jkd6p3vpksk3r5ip8wym6p"))))
    (build-system python-build-system)
    (arguments
     `(#:phases
       (alist-cons-after
        'install 'check
        (lambda _
          (with-directory-excursion "/tmp"
            (system* "nosetests" "-v" "jupyter_console")))
        (alist-delete 'check %standard-phases))))
    (propagated-inputs
     `(("python-jupyter-client" ,python-jupyter-client)
       ("python-ipython" ,python-ipython)
       ("python-ipykernel" ,python-ipykernel)))
    (inputs
     `(("python-setuptools" ,python-setuptools)
       ("python-nose" ,python-nose)
       ("python-pexpect" ,python-pexpect)))
    (home-page "https://jupyter.org")
    (synopsis "Jupyter terminal console")
    (description "Jupyter terminal console")
    (license bsd-3)))

(define-public python2-jupyter-console
  (package-with-python2 python-jupyter-console))

(define-public python-notebook
  (package
    (name "python-notebook")
    (version "4.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "notebook" version))
       (sha256
        (base32
         "141xn3s48kn7sxikkjhm2pdakv81rmqyl7z210824f1mldxl75xm"))))
    (build-system python-build-system)
    (arguments
     `(#:phases
       (alist-cons-after
        'install 'check
        (lambda _
          (with-directory-excursion "/tmp"
            (system* "nosetests" "-v" "notebook")))
        (alist-delete 'check %standard-phases))))
    (propagated-inputs
     `(("python-jinja2" ,python-jinja2)
       ("python-tornado" ,python-tornado)
       ("python-ipython-genutils" ,python-ipython-genutils)
       ("python-traitlets" ,python-traitlets)
       ("python-jupyter-core" ,python-jupyter-core)
       ("python-jupyter-client" ,python-jupyter-client)
       ("python-nbformat" ,python-nbformat)
       ("python-nbconvert" ,python-nbconvert)
       ("python-terminado" ,python-terminado)
       ("python-ipykernel" ,python-ipykernel)))
    (inputs
     `(("python-setuptools" ,python-setuptools)
       ("python-sphinx" ,python-sphinx)
       ("python-nose" ,python-nose)
       ("python-requests" ,python-requests)))
    (home-page "http://jupyter.org")
    (synopsis
     "Web-based notebook environment for interactive computing")
    (description
     "A web-based notebook environment for interactive computing")
    (license bsd-3)))

(define-public python2-notebook
  (package-with-python2 python-notebook))

(define-public python-qtconsole
  (package
    (name "python-qtconsole")
    (version "4.2.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "qtconsole" version))
       (sha256
        (base32
         "1dz5pahigymap0mf59722jxb3hcakwl9kccpivi9xpjvygs18wwk"))))
    (build-system python-build-system)
    (arguments
     `(#:phases
       (alist-cons-after
        'install 'check
        (lambda _
          (with-directory-excursion "/tmp"
            (system* "nosetests" "-v" "qtconsole")))
        (alist-delete 'check %standard-phases))))
    (propagated-inputs
     `(("python-traitlets" ,python-traitlets)
       ("python-jupyter-core" ,python-jupyter-core)
       ("python-jupyter-client" ,python-jupyter-client)
       ("python-pygments" ,python-pygments)
       ("python-pyqt" ,python-pyqt)))
       ;;("python-ipykernel" ,python-ipykernel) ;; recommened install
    (inputs
     `(("python-setuptools" ,python-setuptools)
       ("python-nose" ,python-nose)
       ("python-pexpect" ,python-pexpect)
       ("python-sphinx" ,python-sphinx)))
    (home-page "http://jupyter.org")
    (synopsis "Jupyter Qt console")
    (description "Jupyter Qt console")
    (license bsd-3)))

(define-public python2-qtconsole
  (package-with-python2 python-qtconsole))

(define-public python-ipywidgets
  (package
    (name "python-ipywidgets")
    (version "4.1.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "ipywidgets" version))
       (sha256
        (base32
         "0a0hcvf7aww0y3i9458npf86wp1faafyspqi5my57sdd8mg35syf"))))
    (build-system python-build-system)
    (arguments
     `(#:phases
       (alist-cons-after
        'install 'check
        (lambda _
          (with-directory-excursion "/tmp"
            (system* "nosetests" "-v" "ipywidgets")))
        (alist-delete 'check %standard-phases))))
    (propagated-inputs
     `(("python-ipython" ,python-ipython)
       ("python-ipykernel" ,python-ipykernel)
       ("python-traitlets" ,python-traitlets)
       ("python-notebook" ,python-notebook)))
    (inputs
     `(("python-setuptools" ,python-setuptools)
       ("python-nose", python-nose)))
    (home-page "http://ipython.org")
    (synopsis "IPython HTML widgets for Jupyter")
    (description "IPython HTML widgets for Jupyter")
    (license bsd-3)))

(define-public python2-ipywidgets
  (package-with-python2 python-ipywidgets))

(define-public python-jupyter
  (package
    (name "python-jupyter")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "jupyter" version))
       (sha256
        (base32
         "0pwf3pminkzyzgx5kcplvvbvwrrzd3baa7lmh96f647k30rlpp6r"))))
    (build-system python-build-system)
    (arguments
     `(#:tests? #f))
    (propagated-inputs
     `(("python-notebook" ,python-notebook)
       ;;("python-qtconsole" ,python-qtconsole)
       ("python-jupyter-console" ,python-jupyter-console)
       ("python-nbconvert" ,python-nbconvert)
       ("python-ipykernel" ,python-ipykernel)
       ("python-ipywidgets" ,python-ipywidgets)))
    (inputs
     `(("python-setuptools" ,python-setuptools)))
    (home-page "http://jupyter.org")
    (synopsis
     "Jupyter metapackage, Install all the Jupyter components in one go")
    (description
     "Jupyter metapackage, Install all the Jupyter components in one go")
    (license bsd-3)))

(define-public python2-jupyter
  (package-with-python2 python-jupyter))

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

;; wsgiref
;; factory_boy
