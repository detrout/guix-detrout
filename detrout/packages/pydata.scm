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
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages check)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages geo)
  #:use-module (gnu packages graph)
  #:use-module (gnu packages graphviz)
  #:use-module (gnu packages jupyter)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages python-compression)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages time)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages video)
  #:use-module (gnu packages xml)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system python)
  #:use-module (guix build-system trivial)
  #:use-module (detrout packages compression)
  #:use-module (detrout packages geo)
  #:use-module (detrout packages networking)
  #:use-module (detrout packages python-web)
  #:use-module (detrout packages python-xyz)
  #:use-module (srfi srfi-1))

(define-public python-clickhouse-cityhash
  (package
    (name "python-clickhouse-cityhash")
    (version "1.0.2.3")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "clickhouse-cityhash" version))
              (sha256
               (base32
                "0z8nl0ly2p1h6nygwxs6y40q8y424w40fkjv3jyf8vvcg4h7sdrg"))))
    (build-system python-build-system)
    (home-page "https://github.com/xzkostyan/python-cityhash")
    (synopsis
     "Python-bindings for CityHash, a fast non-cryptographic hash algorithm")
    (description
     "Python-bindings for CityHash, a fast non-cryptographic hash algorithm")
    (license license:expat)))

  (define-public python-clickhouse-driver
    (package
      (name "python-clickhouse-driver")
      (version "0.2.4")
      (source (origin
                (method url-fetch)
                (uri (pypi-uri "clickhouse-driver" version))
                (sha256
                 (base32
                  "1p2n1iy3s4061i7w7fmvp7w5669qr5cjngi5qw85hpb4pj043g5v"))))
      (build-system python-build-system)
      (propagated-inputs (list python-pytz python-tzlocal))
      (home-page "https://github.com/mymarilyn/clickhouse-driver")
      (synopsis "Python driver with native interface for ClickHouse")
      (description "Python driver with native interface for ClickHouse")
      (license license:expat)))

(define-public python-colorcet
  (package
    (name "python-colorcet")
    (version "3.0.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "colorcet" version))
              (sha256
               (base32
                "1nzkzhnpvqk1jz2h7hy8yhi7hgxc49n9kwi96xh1ma3sd8s25i91"))))
    (build-system python-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       ; only import test directory, colorcet.plotting module has
       ; a circular dependency on holoviews
       (modify-phases %standard-phases
         (replace 'check
           (lambda* (#:key tests? #:allow-other-keys)
             (when tests?
               (invoke "pytest" "colorcet.tests")))))))
    (propagated-inputs (list python-param python-pyct))
    (native-inputs (list python-flake8
                         python-keyring
                         python-nbsmoke
                         python-pytest
                         python-pytest-cov
                         python-pytest-mpl
                         python-rfc3986
                         python-twine))
    (home-page "https://colorcet.holoviz.org")
    (synopsis "Collection of perceptually uniform colormaps")
    (description "Collection of perceptually uniform colormaps")
    (license license:cc-by4.0)))

; these depend on cuda which isn't available in guix
;(define-public python-cudf
;  (package
;    (name "python-cudf")
;    (version "0.6.1.post1")
;    (source (origin
;              (method url-fetch)
;              (uri (pypi-uri "cudf" version))
;              (sha256
;               (base32
;                "0rhfp97syvi8vgvc2045nph6brcmabn8s3b3h0kp6a4s7a98pmb2"))))
;    (build-system python-build-system)
;    (home-page "https://github.com/rapidsai/dask-cuda")
;    (synopsis "")
;    (description "")
;    (license license:asl2.0)))
;
;(define-public python-cupy
;  (package
;    (name "python-cupy")
;    (version "11.1.0")
;    (source (origin
;              (method url-fetch)
;              (uri (pypi-uri "cupy" version))
;              (sha256
;               (base32
;                "1pafd2jga7ba439hsq7qaw44s22imngl5bq5163vvmyx1acnyfz1"))))
;    (build-system python-build-system)
;    (propagated-inputs (list python-fastrlock python-numpy))
;    (native-inputs (list python-hypothesis python-pytest))
;    (home-page "https://cupy.dev/")
;    (synopsis "CuPy: NumPy & SciPy for GPU")
;    (description "CuPy: NumPy & SciPy for GPU")
;    (license license:expat)))
;
(define-public python-dash
  (package
    (name "python-dash")
    (version "2.6.1")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "dash" version))
              (sha256
               (base32
                "0hqnjarpsx3k5diibkqzzsifjrz5przssv9kbrl9nh9mfdd3g24c"))))
    (build-system python-build-system)
    (arguments
     ;; It can't find plotly, even though it's listed.
     `(#:tests? #f
       #:phases
       ;; XXX: The installed scripts import packages that depend on
       ;; this package; disable import check to avoid the cycle.
       (modify-phases %standard-phases
         (delete 'sanity-check))))
    (propagated-inputs (list python-contextvars
                             python-dash-core-components
                             python-dash-html-components
                             python-dash-table
                             python-flask
                             python-flask-compress
                             python-importlib-metadata
                             python-plotly))
    (native-inputs (list python-beautifulsoup4
                         python-coloredlogs
                         python-cryptography
                         python-fire
                         python-lxml
                         python-multiprocess
                         python-percy
                         python-psutil
                         python-pytest
                         python-pyyaml
                         python-requests
                         python-selenium
                         python-waitress))
    (home-page "https://plotly.com/dash")
    (synopsis
     "A Python framework for building reactive web-apps. Developed by Plotly.")
    (description
     "This package provides a Python framework for building reactive web-apps.
  Developed by Plotly.")
    (license license:expat)))

(define-public python-dash-core-components
  (package
    (name "python-dash-core-components")
    (version "2.0.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "dash_core_components" version))
              (sha256
               (base32
                "1vpzcc5nwg4af6rhp9izwi6g2zgfq8b8lfd1jlpmaplpmxs3hwy6"))))
    (build-system python-build-system)
    ;; Tests have circular dependency
    (arguments
     `(#:tests? #f
       #:phases
       ;; XXX: The installed scripts import packages that depend on
       ;; this package; disable import check to avoid the cycle.
       (modify-phases %standard-phases
         (delete 'sanity-check))))
    (home-page "")
    (synopsis "Core component suite for Dash")
    (description "Core component suite for Dash")
    (license license:expat)))

(define-public python-dash-html-components
  (package
    (name "python-dash-html-components")
    (version "2.0.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "dash_html_components" version))
              (sha256
               (base32
                "0l3fy8ax02dwrslxf7vsx6mxm9d47l5qx6chcfd620hg100sc0w7"))))
    (build-system python-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       ;; XXX: The installed scripts import packages that depend on
       ;; this package; disable import check to avoid the cycle.
       (modify-phases %standard-phases
         (delete 'sanity-check))))
    (home-page "https://github.com/plotly/dash-html-components")
    (synopsis "Vanilla HTML components for Dash")
    (description "Vanilla HTML components for Dash")
    (license license:expat)))

(define-public python-dash-table
  (package
    (name "python-dash-table")
    (version "5.0.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "dash_table" version))
              (sha256
               (base32
                "023kpk2p1h8qychallzi1gmafdrlb5kz39lrxkfz53jc7mllsqhq"))))
    (build-system python-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       ;; XXX: The installed scripts import packages that depend on
       ;; this package; disable import check to avoid the cycle.
       (modify-phases %standard-phases
         (delete 'sanity-check))))
    (home-page "")
    (synopsis "Dash table")
    (description "Dash table")
    (license license:expat)))

(define-public python-datafusion
  (package
    (name "python-datafusion")
    (version "0.6.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "datafusion" version))
              (sha256
               (base32
                "0yamjzdl86ikcvzyw9ajs732yazdqz8iz8rpjnh6r8b537xc08n6"))))
    (build-system python-build-system)
    (propagated-inputs (list python-pyarrow))
    (home-page "https://github.com/apache/arrow")
    (synopsis "Build and run queries against data")
    (description "Build and run queries against data")
    (license #f)))

(define-public python-datashader
  (package
    (name "python-datashader")
    (version "0.14.2")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "datashader" version))
              (sha256
               (base32
                "1f149q2p3nzilkz9f9psj824dxp6v39rpkyqkgysbsa3wak8ximb"))))
    (build-system python-build-system)
    (propagated-inputs (list python-colorcet
                             python-dask
                             python-datashape
                             python-distributed
                             python-numba
                             python-pandas
                             python-param
                             python-pillow
                             python-pyct
                             python-requests
                             python-scipy
                             python-xarray))
    (native-inputs (list python-bokeh
                         python-codecov
;                         python-cudf
;                         python-cupy
;                         python-dask-cudf ; not on pypi, repo archived?
                         python-fastparquet
                         python-flake8
;                         python-holoviews
                         python-nbconvert
                         python-nbsmoke
                         python-netcdf4
;                         python-pyarrow
                         python-pytest
;                         python-pytest-benchmark
                         python-pytest-cov
;                         python-rasterio
;                         python-rioxarray
;                         python-spatialpandas
                         ))
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (replace 'check
           (lambda* (#:key tests? #:allow-other-keys)
             (when tests?
               (invoke "pytest" "datashader"))))
         (delete 'sanity-check))))
    (home-page "https://datashader.org")
    (synopsis "Data visualization toolchain based on aggregating into a grid")
    (description "Data visualization toolchain based on aggregating into a grid")
    (license license:bsd-3)))

(define-public python-datashape
  (package
    (name "python-datashape")
    (version "0.5.2")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "datashape" version))
              (sha256
               (base32
                "10ypax7d9wz45mjv705h8pg3ahhlcf83l94a8v0h7w1w1ilylmi3"))))
    (build-system python-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (replace 'check
           (lambda* (#:key tests? #:allow-other-keys)
             (when tests?
               (invoke "pytest" "datashape")))))))
    (native-inputs (list python-pytest))
    (propagated-inputs (list python-dateutil python-multipledispatch
                             python-numpy))
    (home-page "http://datashape.readthedocs.org/en/latest/")
    (synopsis "A data description language.")
    (description "This package provides a data description language.")
    (license license:bsd-3)))

(define-public python-duckdb
  (package
    (name "python-duckdb")
    (version "0.5.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "duckdb" version))
              (sha256
               (base32
                "0k4gya8x246kl2w51w7jnb0hb7q0jk2w47q1w2jgi2m7w0alcy81"))))
    (build-system python-build-system)
    (propagated-inputs (list python-numpy))
    (home-page "https://www.duckdb.org")
    (synopsis "DuckDB embedded database")
    (description "DuckDB embedded database")
    (license license:expat)))

(define-public python-duckdb-engine
  (package
    (name "python-duckdb-engine")
    (version "0.6.3")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "duckdb_engine" version))
              (sha256
               (base32
                "0d30gnvhrnlzmh5kcrb6m1k6wxa294n878pf0ff5hf5zqd7dlq6s"))))
    (build-system python-build-system)
    (propagated-inputs (list python-duckdb python-numpy python-sqlalchemy))
    (home-page "https://github.com/Mause/duckdb_engine")
    (synopsis "SQLAlchemy driver for duckdb")
    (description "SQLAlchemy driver for duckdb")
    (license license:expat)))

(define-public python-fastrlock
  (package
    (name "python-fastrlock")
    (version "0.8")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "fastrlock" version))
              (sha256
               (base32
                "0c89nh3r6xb47yhm46dgc3gpq9gizn15lw6ysxrj3cr417nh1hcw"))))
    (build-system python-build-system)
    (home-page "https://github.com/scoder/fastrlock")
    (synopsis "Fast, re-entrant optimistic lock implemented in Cython")
    (description "Fast, re-entrant optimistic lock implemented in Cython")
    (license license:expat)))

(define-public python-fastparquet
  (package
    (name "python-fastparquet")
    (version "0.8.3")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "fastparquet" version))
              (sha256
               (base32
                "0zic8a59a5nm5signbhx5378hvnv8iy1j53q7mpaxzrn3z2qwkj5"))))
    (build-system python-build-system)
    (arguments
     `(#:tests? #f  ; there are no tests in the pypi version, should check source repository
       #:phases
       (modify-phases %standard-phases
         (add-before 'build 'set-numpy
           (lambda _
             (substitute* '("setup.py")
               (("oldest-supported-numpy") "numpy")))))))
    (native-inputs (list python-pytest python-pytest-runner python-setuptools python-wheel))
    (propagated-inputs (list python-cramjam
                             python-fsspec
                             python-lzo
                             python-numpy
                             python-packaging
                             python-pandas))
    (home-page "https://github.com/dask/fastparquet/")
    (synopsis "Python support for Parquet file format")
    (description "Python support for Parquet file format")
    (license license:asl2.0)))

(define-public python-ffmpeg
  (package
    (name "python-ffmpeg")
    (version "1.4")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "ffmpeg" version))
              (sha256
               (base32
                "1fdml3drkwcppgwwgpb01k55v0a7jwcc4cw4jcwivwhgi4n6jcb9"))))
    (build-system python-build-system)
    (propagated-inputs (list ffmpeg))
    (home-page "https://github.com/jiashaokun/ffmpeg")
    (synopsis "ffmpeg python package url [https://github.com/jiashaokun/ffmpeg]")
    (description
     "ffmpeg python package url [https://github.com/jiashaokun/ffmpeg]")
    (license #f)))

(define-public python-holoviews
  (package
   (name "python-holoviews")
   (version "1.15.0")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "holoviews" version))
            (sha256
             (base32
              "1fmmbs0095a78xgb9k3b6rg5i8nv71mq6qb2qjpaghq68k960bii"))))
   (build-system python-build-system)
   (propagated-inputs (list python-colorcet
                            python-numpy
                            python-packaging
                            python-pandas
;                            python-panel ;needs a bunch of js libraries not available.
                            python-param
                            python-pyviz-comms))
   (native-inputs (list python-bokeh
                        python-codecov
                        python-flake8
                        python-matplotlib
                        python-nbconvert
                        python-netcdf4
                        python-notebook
                        python-pytest
                        python-pytest-cov
                        python-scikit-image))
    (arguments
     `(#:tests? #t
       #:phases
       (modify-phases %standard-phases
         (replace 'check
           (lambda* (#:key tests? #:allow-other-keys)
             (when tests?
               (invoke "python" "-m" "pytest" "holoviews")))))))
   (home-page "https://www.holoviews.org")
   (synopsis
    "Stop plotting your data - annotate your data and let it visualize itself.")
   (description
    "Stop plotting your data - annotate your data and let it visualize itself.")
   (license license:bsd-3)))

(define-public python-ibis-framework
  (package
    (name "python-ibis-framework")
    (version "3.1.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "ibis-framework" version))
              (sha256
               (base32
                "18qv57qmphx0p4iiwqysqghc20p0lpc01d4g9mdmanzpk64aixjy"))))
    (build-system python-build-system)
    (propagated-inputs (list python-atpublic
                             python-clickhouse-cityhash
                             python-clickhouse-driver
                             python-dask
                             python-datafusion
                             python-duckdb
                             python-duckdb-engine
                             python-fsspec
                             python-geoalchemy2
                             python-geopandas
                             python-graphviz
                             python-impyla
                             python-lz4
                             python-multipledispatch
                             python-numpy
                             python-packaging
                             python-pandas
                             python-parsy
                             python-psycopg2
;                             python-pyarrow
                             python-pydantic
                             python-pymysql
                             python-pyspark
                             python-regex
                             python-requests
                             python-shapely
                             python-sqlalchemy
                             python-tabulate
                             python-toolz))
    (home-page "https://ibis-project.org")
    (synopsis "Productivity-centric Python Big Data Framework")
    (description "Productivity-centric Python Big Data Framework")
    (license #f)))

(define-public python-impyla
  (package
    (name "python-impyla")
    (version "0.17.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "impyla" version))
              (sha256
               (base32
                "01ik8jlrc0rfs0mnwyxkjajzz4qz3w631allcdq40pypjkswhi1f"))))
    (build-system python-build-system)
    (propagated-inputs (list python-bitarray python-six python-thrift
                             python-thrift-sasl))
    (home-page "https://github.com/cloudera/impyla")
    (synopsis "Python client for the Impala distributed query engine")
    (description "Python client for the Impala distributed query engine")
    (license license:asl2.0)))

(define-public python-nbsmoke
  (package
    (name "python-nbsmoke")
    (version "0.6.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "nbsmoke" version))
              (sha256
               (base32
                "0x08bd2ds8406hkpfsdhgja36mnad326dhl0zz3ppqmc5wz36mcb"))))
    (build-system python-build-system)
    (propagated-inputs (list python-ipykernel
                             python-jupyter-client
                             python-nbconvert
                             python-nbformat
                             python-param
                             python-pyflakes
                             python-pytest))
; tests fail with the wrong path argument
    (arguments
     `(#:tests? #f))
;    (arguments
;     `(#:phases
;       (modify-phases %standard-phases
;         (replace 'check
;           (lambda* (#:key tests? #:allow-other-keys)
;             (when tests?
;               (invoke "pytest")))))))
    (home-page "https://github.com/pyviz-dev/nbsmoke")
    (synopsis "Basic notebook checks. Do they run? Do they contain lint?")
    (description "Basic notebook checks.  Do they run? Do they contain lint?")
    (license license:bsd-3)))

(define-public python-panel
  (package
    (name "python-panel")
    (version "0.13.1")
    (source (origin
      ;; theres bundled source in the pypi release
      (method git-fetch)
      (uri (git-reference
            (url "https://github.com/holoviz/panel")
            (commit (string-append "v" version))))
      (file-name (git-file-name name version))
      (sha256
       (base32 "04bx9lig4j8x6q93yk11avnh8170353ach457psygvg6l5q1cvbz"))))
    (build-system python-build-system)
    (propagated-inputs (list python-bleach
                             python-bokeh
                             python-markdown
                             python-param
                             python-pyct
                             python-pyviz-comms
                             python-requests
                             python-tqdm
                             python-typing-extensions))
    (native-inputs (list python-codecov
                         python-flake8
                         python-folium
                         python-ipympl
                         python-ipython
                         python-nbval
                         python-pandas
                         python-parameterized
                         python-pytest
                         python-pytest-cov
                         python-setuptools
                         python-scipy
                         python-twine))
    (arguments
     `(#:phases (modify-phases %standard-phases
                  (add-after 'unpack 'patch-test-suite
                    (lambda _
                      (let ((port (open-file "panel/.version" "w")))
                        (display "{\"version_string\": \"0.13.1\"}" port)
                        (newline port)
                        (close-port port)))))))
    (home-page "http://panel.holoviz.org")
    (synopsis "A high level app and dashboarding solution for Python.")
    (description
     "This package provides a high level app and dashboarding solution for Python.")
    (license license:bsd-3)))

(define-public python-parsy
  (package
    (name "python-parsy")
    (version "2.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "parsy" version))
              (sha256
               (base32
                "09259wlbylcd7pky3w6r2ai5ps9d2ww515rrknb0vf5hxgh6rlvz"))))
    (build-system python-build-system)
    (home-page "https://github.com/python-parsy/parsy")
    (synopsis "easy-to-use parser combinators, for parsing in pure Python")
    (description "easy-to-use parser combinators, for parsing in pure Python")
    (license license:expat)))

(define-public python-percy
  (package
    (name "python-percy")
    (version "2.0.2")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "percy" version))
              (sha256
               (base32
                "07821yabrqjyg0z45xlm4vz4hgm4gs7p7mqa3hi5ryh1qhnn2f32"))))
    (build-system python-build-system)
    (native-inputs (list git python-pytest python-requests-mock))
    (propagated-inputs (list python-requests))
    (home-page "https://github.com/percy/python-percy-client")
    (synopsis
     "Python client library for visual regression testing with Percy (https://percy.io).")
    (description "Python client library for visual regression testing with Percy
  (https://percy.io).")
    (license license:expat)))

(define-public python-pyct
  (package
    (name "python-pyct")
    (version "0.4.8")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "pyct" version))
              (sha256
               (base32
                "1xzndlib2f5pdrzxg381bym1b5406ff4psis15f56rqmb9dm5mr3"))))
    (build-system python-build-system)
    (propagated-inputs (list python-param))
    (native-inputs (list python-requests python-flake8 python-pytest python-pyyaml))
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (replace 'check
           (lambda* (#:key tests? #:allow-other-keys)
             (when tests?
               (invoke "pytest" "pyct")))))))
    (home-page "https://github.com/pyviz-dev/pyct")
    (synopsis
     "Python package common tasks for users (e.g. copy examples, fetch data, ...)")
    (description
     "Python package common tasks for users (e.g.  copy examples, fetch data, ...)")
    (license license:bsd-3)))

(define-public python-py4j
  (package
    (name "python-py4j")
    (version "0.10.9.7")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "py4j" version))
              (sha256
               (base32
                "1fwdx92cdaiviradksfyygg05g1fpc3x2lf65bv5rnispcam6vhb"))))
    (build-system python-build-system)
    (home-page "https://www.py4j.org/")
    (synopsis
     "Enables Python programs to dynamically access arbitrary Java objects")
    (description
     "Enables Python programs to dynamically access arbitrary Java objects")
    (license license:bsd-3)))

(define-public python-pyspark
  (package
    (name "python-pyspark")
    (version "3.3.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "pyspark" version))
              (sha256
               (base32
                "1xrcx7nfwxw7r1g6rbgq3h192f7x1nkgr0js9l94syv40naqxgky"))))
    (build-system python-build-system)
    (propagated-inputs (list python-py4j))
    (home-page "https://github.com/apache/spark/tree/master/python")
    (synopsis "Apache Spark Python API")
    (description "Apache Spark Python API")
    (license #f)))
  
(define-public python-pyviz-comms
  (package
    (name "python-pyviz-comms")
    (version "2.2.1")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "pyviz_comms" version))
              (sha256
               (base32
                "0cyzbm9f7cwhr2af9clfa9f11khkp5vnv0n6ncsdklj3rsw4aqd2"))))
    (build-system python-build-system)
    (propagated-inputs (list python-param))
    (native-inputs (list python-flake8 python-pytest))
    (home-page "https://holoviz.org")
    (synopsis "Bidirectional communication for the HoloViz ecosystem.")
    (description "Bidirectional communication for the HoloViz ecosystem.")
    (license license:bsd-3)))

(define-public python-streamz
  (package
    (name "python-streamz")
    (version "0.6.4")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "streamz" version))
              (sha256
               (base32
                "1wrljqy6wk10cka8g6c19139a0ay21r5f2al870qki1f9j8dcxsm"))))
    (build-system python-build-system)
    (propagated-inputs
     (list python-six
           python-toolz
           python-tornado-6
           python-zict))
    (native-inputs
     (list python-cython
           python-confluent-kafka
           python-dask
           python-distributed
           python-flaky
           python-networkx
           python-pytest
           python-setuptools))
    (home-page "http://github.com/python-streamz/streamz/")
    (synopsis "Streamz helps you build pipelines to manage continuous streams of data")
    (description "Streamz helps you build pipelines to manage continuous streams of data. It is simple to use in simple cases, but also supports complex pipelines that involve branching, joining, flow control, feedback, back pressure, and so on.

Optionally, Streamz can also work with both Pandas and cuDF dataframes, to provide sensible streaming operations on continuous tabular data.")
    (license license:bsd-3)))

(define-public python-thrift
  (package
    (name "python-thrift")
    (version "0.16.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "thrift" version))
              (sha256
               (base32
                "0224q7gjaglympaxnvg2d87ms6d0ysgkr8ia66fizlnyzj468nrb"))))
    (build-system python-build-system)
    (propagated-inputs (list python-six))
    (home-page "http://thrift.apache.org")
    (synopsis "Python bindings for the Apache Thrift RPC system")
    (description "Python bindings for the Apache Thrift RPC system")
    (license #f)))

(define-public python-thrift-sasl
  (package
    (name "python-thrift-sasl")
    (version "0.4.3")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "thrift_sasl" version))
              (sha256
               (base32
                "1nkkyyj6f16csc95kwkbinm62n22n0yqgkmz7adkv8ch1mv5ppav"))))
    (build-system python-build-system)
    (propagated-inputs (list python-pure-sasl python-six python-thrift))
    (home-page "https://github.com/cloudera/thrift_sasl")
    (synopsis
     "Thrift SASL Python module that implements SASL transports for Thrift (`TSaslClientTransport`).")
    (description
     "Thrift SASL Python module that implements SASL transports for Thrift
  (`TSaslClientTransport`).")
    (license license:asl2.0)))
