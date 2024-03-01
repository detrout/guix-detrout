(define-module (detrout packages geo)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages geo)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages sphinx)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system python)
  #:use-module (detrout packages python-xyz)
  #:use-module (detrout packages maths)
  )

(define-public python-fxrays
  (package
    (name "python-fxrays")
    (version "1.3.5")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "FXrays" version))
              (sha256
               (base32
                "0382ax7d299dr18pqjlr0r661l3gmplrdwafvh1m5bdyjrq4sjjk"))))
    (build-system python-build-system)
    (home-page "http://t3m.computop.org")
    (synopsis "Computes extremal rays with filtering")
    (description "Computes extremal rays with filtering")
    (license #f)))

(define-public python-geoalchemy2
  (package
    (name "python-geoalchemy2")
    (version "0.12.5")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "GeoAlchemy2" version))
              (sha256
               (base32
                "0ryx10g0k1lv9m8vwa678sga67sh5mb8gsz46nrmfyrirqnm1hii"))))
    (build-system python-build-system)
    (propagated-inputs (list python-packaging python-sqlalchemy))
    (home-page "https://geoalchemy-2.readthedocs.io/en/latest/")
    (synopsis "Using SQLAlchemy with Spatial Databases")
    (description "Using SQLAlchemy with Spatial Databases")
    (license license:expat)))

(define-public python-hilbertcurve
  (package
    (name "python-hilbertcurve")
    (version "2.0.5")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "hilbertcurve" version))
              (sha256
               (base32
                "0vbrfm7b643faarf8i9njydi6z9y32zhhsfqhs679zpilbch6xva"))))
    (build-system python-build-system)
    (propagated-inputs (list python-numpy))
    (native-inputs (list python-pytest python-sphinx
                         python-sphinx-autodoc-typehints python-sphinx-rtd-theme))
    (home-page "https://github.com/galtay/hilbertcurve")
    (synopsis "Construct Hilbert Curves.")
    (description "Construct Hilbert Curves.")
    (license license:expat)))
  
(define-public python-knot-floer-homology
  (package
    (name "python-knot-floer-homology")
    (version "1.2")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "knot_floer_homology" version))
              (sha256
               (base32
                "08a07iiwazcbkk0q88v1wnihwy008x4c65r4lca38s873gswal8b"))))
    (build-system python-build-system)
    (home-page "https://github.com/3-manifolds/knot_floer_homology")
    (synopsis "Python wrapper for Zoltán Szabó's HFK Calculator")
    (description "Python wrapper for Zoltán Szabó's HFK Calculator")
    (license #f)))

; needs tkinter
(define-public python-plink
  (package
    (name "python-plink")
    (version "2.4.1")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "plink" version))
              (sha256
               (base32
                "0zp55k1qclz65vnd02v78mqzcz7gwjs50gfqniyvpcy0isi13n7q"))))
    (build-system python-build-system)
    (home-page "https://www.math.uic.edu/t3m/plink/doc/")
    (synopsis "A full featured Tk-based knot and link editor")
    (description
     "This package provides a full featured Tk-based knot and link editor")
    (license #f)))

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
    (inputs (list gdal))
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
                         python-cython
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
    (license #f)))
  
(define-public python-snappy
  (package
    (name "python-snappy")
    (version "3.0.3")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "snappy" version))
              (sha256
               (base32
                "091nxqk37bjp7bji6zl89pw9bcyy92pykzdwvb31ph4y6sm9cdn3"))))
    (build-system python-build-system)
    (propagated-inputs (list python-cypari
                             python-decorator
                             python-fxrays
                             python-ipython
                             python-plink
                             python-pypng
                             python-snappy-manifolds
                             python-spherogram))
    (home-page "http://snappy.computop.org")
    (synopsis
     "Studying the topology and geometry of 3-manifolds, with a focus on hyperbolic structures.")
    (description
     "Studying the topology and geometry of 3-manifolds, with a focus on hyperbolic
  structures.")
    (license #f)))

(define-public python-snappy-manifolds
  (package
    (name "python-snappy-manifolds")
    (version "1.1.2")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "snappy_manifolds" version))
              (sha256
               (base32
                "150dm487praqdz0ibv36fl4f4j1hhvsdw15kfanr17872bw351p1"))))
    (build-system python-build-system)
    (home-page "https://github.com/3-manifolds/snappy_manifolds")
    (synopsis "Database of snappy manifolds")
    (description "Database of snappy manifolds")
    (license #f)))
  
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
;                             python-pyarrow
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

(define-public python-spherogram
  (package
    (name "python-spherogram")
    (version "2.1")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "spherogram" version))
              (sha256
               (base32
                "1hf91anc8d6siiy32xrmgr6g7g10j43nc0m46x0n5hypy93bydah"))))
    (build-system python-build-system)
    (propagated-inputs (list python-decorator python-knot-floer-homology
                             python-networkx python-snappy-manifolds))
    (home-page "https://github.com/3-manifolds/Spherogram")
    (synopsis "Spherical diagrams for 3-manifold topology")
    (description "Spherical diagrams for 3-manifold topology")
    (license #f)))
