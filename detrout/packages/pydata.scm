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
  #:use-module (gnu packages xml)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system python)
  #:use-module (guix build-system trivial)
  #:use-module (detrout packages compression)
  #:use-module (srfi srfi-1))

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
                         python-percy
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
    (home-page "")
    (synopsis "Dash table")
    (description "Dash table")
    (license license:expat)))

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
                         python-cudf
                         python-cupy
;                         python-dask-cudf ; not on pypi, repo archived?
                         python-fastparquet
                         python-flake8
                         python-holoviews
                         python-nbconvert
                         python-nbsmoke
                         python-netcdf4
;                         python-pyarrow
                         python-pytest
;                         python-pytest-benchmark
                         python-pytest-cov
                         python-rasterio
                         python-rioxarray
                         python-spatialpandas))
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
    (propagated-inputs (list python-dateutil python-multipledispatch
                             python-numpy))
    (home-page "http://datashape.readthedocs.org/en/latest/")
    (synopsis "A data description language.")
    (description "This package provides a data description language.")
    (license license:bsd-3)))

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
    (propagated-inputs (list python-cramjam python-fsspec python-numpy
                             python-packaging python-pandas))
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

(define-public python-flask-compress
  (package
    (name "python-flask-compress")
    (version "1.12")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "Flask-Compress" version))
              (sha256
               (base32
                "1idgnwabpxcmy083av9ck9mramwbnpkq815sar6qlqcxyfcr85g2"))))
    (build-system python-build-system)
    (propagated-inputs (list python-brotli python-flask))
    (home-page "https://github.com/colour-science/flask-compress")
    (synopsis
     "Compress responses in your Flask app with gzip, deflate or brotli.")
    (description
     "Compress responses in your Flask app with gzip, deflate or brotli.")
    (license license:expat)))

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
                            python-panel
                            python-param
                            python-pyviz-comms))
   (native-inputs (list python-bokeh
                        python-cftime
                        python-codecov
                        python-cudf
                        python-dash
                        python-dask
                        python-datashader
                        python-ffmpeg
                        python-flake8
                        python-ibis-framework
                        python-ipython
                        python-matplotlib
                        python-nbconvert
                        python-nbsmoke
                        python-netcdf4
                        python-networkx
                        python-notebook
                        python-pillow
                        python-plotly
;                        python-pyarrow
                        python-pytest
                        python-pytest-cov
                        python-scikit-image
                        python-scipy
                        python-selenium
                        python-shapely
                        python-spatialpandas
                        python-streamz
                        python-xarray))
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
    (native-inputs (list python-beautifulsoup4
                         python-coverage
                         python-flake8
                         python-holoviews
                         python-keyring
                         python-requests
                         python-rfc3986
                         python-twine))
    (home-page "https://github.com/pyviz-dev/nbsmoke")
    (synopsis "Basic notebook checks. Do they run? Do they contain lint?")
    (description "Basic notebook checks.  Do they run? Do they contain lint?")
    (license license:bsd-3)))

(define-public python-panel
  (package
    (name "python-panel")
    (version "0.13.1")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "panel" version))
              (sha256
               (base32
                "1bqk47sisf14r0sqbihc0gcl89n6bcmxcwq2rvxwzjsim3q0i40f"))))
    (build-system python-build-system)
    (propagated-inputs (list python-bleach
                             python-bokeh
                             python-markdown
                             python-param
                             python-pyct
                             python-pyviz-comms
                             python-requests
                             python-setuptools
                             python-tqdm
                             python-typing-extensions))
    (native-inputs (list python-codecov
                         python-flake8
                         python-folium
                         python-holoviews
                         python-ipympl
                         python-ipython
                         python-nbval
                         python-pandas
                         python-parameterized
                         python-pytest
                         python-pytest-cov
                         python-scipy
                         python-twine))
    (home-page "http://panel.holoviz.org")
    (synopsis "A high level app and dashboarding solution for Python.")
    (description
     "This package provides a high level app and dashboarding solution for Python.")
    (license license:bsd-3)))

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
    (propagated-inputs (list python-requests))
    (home-page "https://github.com/percy/python-percy-client")
    (synopsis
     "Python client library for visual regression testing with Percy (https://percy.io).")
    (description "Python client library for visual regression testing with Percy
  (https://percy.io).")
    (license license:expat)))

(define-public python-plotly
  (package
    (name "python-plotly")
    (version "5.10.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "plotly" version))
              (sha256
               (base32
                "1nzsvvcqkv2q876mgzdi5r3pln4jqbcfxpk26lkkn5bskf2xjdjd"))))
    (build-system python-build-system)
    (propagated-inputs (list python-tenacity))
    (home-page "https://plotly.com/python/")
    (synopsis
     "An open-source, interactive data visualization library for Python")
    (description
     "An open-source, interactive data visualization library for Python")
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
    (native-inputs (list python-flake8 python-pytest))
    (home-page "https://github.com/pyviz-dev/pyct")
    (synopsis
     "Python package common tasks for users (e.g. copy examples, fetch data, ...)")
    (description
     "Python package common tasks for users (e.g.  copy examples, fetch data, ...)")
    (license license:bsd-3)))

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

(define-public python-rasterio
  (package
    (name "python-rasterio")
    (version "1.3.2")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "rasterio" version))
              (sha256
               (base32
                "077ccqh0iqmd6z6n6prp63lbg6brxdc94d09k4js6nmw97v346x9"))))
    (build-system python-build-system)
    (propagated-inputs (list python-affine
                             python-attrs
                             python-certifi
                             python-click
                             python-click-plugins
                             python-cligj
                             python-numpy
                             python-setuptools
                             python-snuggs))
    (native-inputs (list python-boto3
                         python-hypothesis
                         python-packaging
                         python-pytest
                         python-pytest-cov
                         python-shapely))
    (home-page "https://github.com/rasterio/rasterio")
    (synopsis "Fast and direct raster I/O for use with Numpy and SciPy")
    (description "Fast and direct raster I/O for use with Numpy and SciPy")
    (license license:bsd-3)))

(define-public python-rioxarray
  (package
  (name "python-rioxarray")
  (version "0.12.0")
  (source (origin
            (method url-fetch)
            (uri (pypi-uri "rioxarray" version))
            (sha256
             (base32
              "08bgwyg3laxaxi080l48dzmz6srb5n2kwj8r30wj937lrnf1d91a"))))
  (build-system python-build-system)
  (propagated-inputs (list python-packaging python-pyproj python-rasterio
                           python-xarray))
  (native-inputs (list python-dask
                       python-mypy
                       python-nbsphinx
                       python-netcdf4
                       python-pre-commit
                       python-pylint
                       python-pytest
                       python-pytest-cov
                       python-pytest-timeout
                       python-scipy
                       python-sphinx-click
                       python-sphinx-rtd-theme))
  (home-page "https://github.com/corteva/rioxarray")
  (synopsis "geospatial xarray extension powered by rasterio")
  (description "geospatial xarray extension powered by rasterio")
  (license license:asl2.0)))

(define-public python-spatialpandas
  (package
    (name "python-spatialpandas")
    (version "0.4.4")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "spatialpandas" version))
              (sha256
               (base32
                "1x9qwar6a0qmirhkk4gkrzi8fl5yvfai0n8wjkk9dixajkvmxlgl"))))
    (build-system python-build-system)
    (propagated-inputs (list python-dask
                             python-fsspec
                             python-numba
                             python-pandas
                             python-param
                             python-pyarrow
                             python-retrying
                             python-snappy))
    (native-inputs (list python-codecov
                         python-flake8
                         python-geopandas
                         python-hilbertcurve
                         python-hypothesis
                         python-keyring
                         python-pytest
                         python-pytest-cov
                         python-rfc3986
                         python-scipy
                         python-shapely
                         python-twine))
    (home-page "https://github.com/holoviz/spatialpandas")
    (synopsis "Pandas extension arrays for spatial/geometric operations")
    (description "Pandas extension arrays for spatial/geometric operations")
    (license license:bsd-2)))
  
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
    (propagated-inputs (list python-setuptools python-six python-toolz
                             python-tornado python-zict))
    (home-page "http://github.com/python-streamz/streamz/")
    (synopsis "Streams")
    (description "Streams")
    (license license:bsd-3)))
