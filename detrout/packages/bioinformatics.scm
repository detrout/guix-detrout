(define-module (detrout packages bioinformatics)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix hg-download)
  #:use-module (guix build-system ant)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system go)
  #:use-module (guix build-system haskell)
  #:use-module (guix build-system meson)
  #:use-module (guix build-system ocaml)
  #:use-module (guix build-system perl)
  #:use-module (guix build-system python)
  #:use-module (guix build-system qt)
  #:use-module (guix build-system r)
  #:use-module (guix build-system ruby)
  #:use-module (guix build-system scons)
  #:use-module (guix build-system trivial)
  #:use-module (guix deprecation)
  #:use-module (gnu packages)
  #:use-module (gnu packages assembly)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages bioconductor)
  #:use-module (gnu packages bioinformatics)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages check)
  #:use-module (gnu packages code)
  #:use-module (gnu packages commencement)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cpio)
  #:use-module (gnu packages cran)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages datastructures)
  #:use-module (gnu packages dlang)
  #:use-module (gnu packages file)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gd)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages graph)
  #:use-module (gnu packages graphics)
  #:use-module (gnu packages graphviz)
  #:use-module (gnu packages groff)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages guile-xyz)
  #:use-module (gnu packages haskell-check)
  #:use-module (gnu packages haskell-web)
  #:use-module (gnu packages haskell-xyz)
  #:use-module (gnu packages image)
  #:use-module (gnu packages image-processing)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages java)
  #:use-module (gnu packages java-compression)
  #:use-module (gnu packages jemalloc)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages logging)
  #:use-module (gnu packages machine-learning)
  #:use-module (gnu packages man)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages node)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages parallel)
  #:use-module (gnu packages pdf)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages perl-check)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages popt)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-build)  
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages python-compression)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages rdf)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages rsync)
  #:use-module (gnu packages ruby)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages sphinx)
  #:use-module (gnu packages statistics)
  #:use-module (gnu packages swig)
  #:use-module (gnu packages tbb)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages time)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages web)
  #:use-module (gnu packages wget)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26)
  #:use-module (ice-9 match))

(define-public python-stdlib-list
  (package
   (name "python-stdlib-list")
   (version "0.8.0")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "stdlib-list" version))
     (sha256
      (base32
       "17vdn4q0sdlndc2fr9svapxx6366hnrhkn0fswp1xmr0jxqh7rd1"))))
   (build-system python-build-system)
   (arguments
     `(#:tests? #f))                    ; the build environment includes a few non std lib pkgs
   (native-inputs
    `(("python-sphinx" ,python-sphinx)))
   (home-page
    "https://github.com/pypi/-stdlib-list")
   (synopsis
    "List of Python Standard Libraries (2.6-7, 3.2-9)")
   (description
    "List of Python Standard Libraries (2.6-7, 3.2-9)")
   (license license:expat)))


(define-public python-sinfo
  (package
   (name "python-sinfo")
   (version "0.3.4")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "sinfo" version))
     (sha256
      (base32
       "0kdsp883mx0lfyykv0p12bvs203kdm3skb8bw5wf2pc7kb393sl1"))))
   (build-system python-build-system)
   (propagated-inputs
    `(("python-stdlib-list" ,python-stdlib-list)))
   (home-page
    "https://gitlab.com/joelostblom/session_info")
   (synopsis
    "Reports version information for modules loaded")
   (description
    "Reports version information for modules loaded in the current
 session, Python, and the OS.")

   (license license:bsd-3)))

(define-public python-anndata
  (package
    (name "python-anndata")
    (version "0.7.6")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "anndata" version))
       (sha256
        (base32
         "1ch8yp0xmag6z0kl01pljm35lbbwax7lrimfhiclpkd4m6xngk53"))))
    (build-system python-build-system)
    (arguments
     `(#:use-setuptools? #f))
;;     `(#:phases
;;       (modify-phases %standard-phases
;;         (add-after 'unpack 'delete-inconvenient-tests
;;           (lambda _
;;             ;; This test depends on python-scikit-learn.
;;             (delete-file "anndata/tests/test_inplace_subset.py")
;;             #t))
;;         (delete 'check)
;;         (add-after 'install 'check
;;           (lambda* (#:key inputs outputs #:allow-other-keys)
;;             (add-installed-pythonpath inputs outputs)
;;             (invoke "pytest" "-vv"))))))
    (propagated-inputs
     `(("python-h5py" ,python-h5py)
       ("python-importlib-metadata" ,python-importlib-metadata)
       ("python-natsort" ,python-natsort)
       ("python-numcodecs" ,python-numcodecs)
       ("python-packaging" ,python-packaging)
       ("python-pandas" ,python-pandas)
       ("python-scipy" ,python-scipy)
       ("python-zarr" ,python-zarr)))
    (native-inputs
     `(("python-joblib" ,python-joblib)
       ("python-pytest" ,python-pytest)
       ("python-flit" ,python-flit)
       ("python-setuptools-scm" ,python-setuptools-scm)))
    (home-page "https://github.com/scverse/anndata")
    (synopsis "Annotated data for data analysis pipelines")
    (description "Anndata is a package for simple (functional) high-level APIs
for data analysis pipelines.  In this context, it provides an efficient,
scalable way of keeping track of data together with learned annotations and
reduces the code overhead typically encountered when using a mostly
object-oriented library such as scikit-learn.")
    (license license:bsd-3)))

(define-public python-scanpy
  (package
    (name "python-scanpy")
    (version "1.7.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "scanpy" version))
       (sha256
        (base32
         "0c66adnfizsyk0h8bv2yhmay876z0klpxwpn4z6m71wly7yplpmd"))))
    (build-system python-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (replace 'check
           (lambda* (#:key inputs #:allow-other-keys)
             ;; These tests require Internet access.
             (delete-file-recursively "scanpy/tests/notebooks")
             (delete-file "scanpy/tests/test_clustering.py")
             (delete-file "scanpy/tests/test_datasets.py")

             ;; TODO: I can't get the plotting tests to work, even with Xvfb.
             (delete-file "scanpy/tests/test_plotting.py")
             (delete-file "scanpy/tests/test_preprocessing.py")
             (delete-file "scanpy/tests/test_read_10x.py")

             (setenv "PYTHONPATH"
                     (string-append (getcwd) ":"
                                    (getenv "PYTHONPATH")))
             (invoke "pytest")
             #t)))))
    (propagated-inputs
     `(("python-anndata" ,python-anndata)
       ("python-h5py" ,python-h5py)
       ("python-igraph" ,python-igraph)
       ("python-joblib" ,python-joblib)
       ("python-legacy-api-wrap" ,python-legacy-api-wrap)
       ("python-louvain" ,python-louvain)
       ("python-matplotlib" ,python-matplotlib)
       ("python-natsort" ,python-natsort)
       ("python-networkx" ,python-networkx)
       ("python-numba" ,python-numba)
       ("python-packaging" ,python-packaging)
       ("python-pandas" ,python-pandas)
       ("python-patsy" ,python-patsy)
       ("python-scikit-learn" ,python-scikit-learn)
       ("python-scipy" ,python-scipy)
       ("python-seaborn" ,python-seaborn)
       ("python-sinfo" ,python-sinfo)
       ("python-statsmodels" ,python-statsmodels)
       ("python-tables" ,python-tables)
       ("python-tqdm" ,python-tqdm)
       ("python-umap-learn" ,python-umap-learn)))
    (native-inputs
     `(("python-pytest" ,python-pytest)
       ("python-pytoml" ,python-pytoml)
       ("python-setuptools-scm" ,python-setuptools-scm)))
    (home-page "https://github.com/scverse/scanpy")
    (synopsis "Single-Cell Analysis in Python.")
    (description "Scanpy is a scalable toolkit for analyzing single-cell gene
expression data.  It includes preprocessing, visualization, clustering,
pseudotime and trajectory inference and differential expression testing.  The
Python-based implementation efficiently deals with datasets of more than one
million cells.")
    (license license:bsd-3)))


(define-public python-interlap
  (package
  (name "python-interlap")
  (version "0.2.7")
  (source
    (origin
      (method url-fetch)
      (uri (pypi-uri "interlap" version))
      (sha256
        (base32
          "1jbfh00bkrf0i5psa6n75rlgmqp5389xixa9j29w8rxhah6g7r1i"))))
  (build-system python-build-system)
  (home-page "http://brentp.github.io/interlap/")
  (synopsis
    "Interlap: fast, simple interval overlap testing")
  (description
    "Interlap: fast, simple interval overlap testing")
  (license license:expat)))


(define-public parasail
  (package
   (name "parasail")
   (version "2.4.3")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/jeffdaily/parasail/")
           (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32 "0lmdcvrfipmm41bbkqirf06yf9szikxvhcgl9iwrb8vqjzszfjrj"))))
   (home-page "https://github.com/jeffdaily/parasail")
   (build-system gnu-build-system)
   (native-inputs
    `(("autoconf" ,autoconf)
      ("automake" ,automake)
      ("libtool" ,libtool)))
   (inputs
    `(("libomp" ,libomp)
      ("zlib" ,zlib)))
   (synopsis "Pairwise Sequence Alignment Library")
   (description "parasail is a SIMD C (C99) library containing implementations of the
Smith-Waterman (local), Needleman-Wunsch (global), and various
semi-global pairwise sequence alignment algorithms.  Here, semi-global
means insertions before the start or after the end of either the query
or target sequence are optionally not penalized.  parasail implements
most known algorithms for vectorized pairwise sequence alignment,
including diagonal [Wozniak, 1997], blocked [Rognes and Seeberg, 2000]
striped [Farrar, 2007], and prefix scan [Daily, 2015].
Therefore, parasail is a reference implementation for these
algorithms in addition to providing an implementation of the
best-performing algorithm(s) to date on today's most advanced CPUs.")
   (license license:bsd-3)))

(define-public python-parasail
  (package
  (name "python-parasail")
  (version "1.2.4")
  (source
    (origin
      (method url-fetch)
      (uri (pypi-uri "parasail" version))
      (sha256
        (base32
          "1lpaxw99szwws65k63l8rvd14sawfqi13dyb6ys1nijaj9i0fvlf"))))
  (build-system python-build-system)
  (arguments
   `(#:phases
       (modify-phases %standard-phases
         (add-before 'build 'skip-parasail-download
           (lambda* (#:key inputs #:allow-other-keys)
             (let* ((parasail (assoc-ref inputs "parasail"))
                    (lib (string-append parasail "/" "lib" "/" "libparasail.so"))
                    (dest "parasail/libparasail.so"))
             (setenv "PARASAIL_SKIP_BUILD" "1")))))))
  (propagated-inputs
   `(("python-numpy" ,python-numpy)
     ("parasail" ,parasail)))
  (home-page
    "https://github.com/jeffdaily/parasail-python")
  (synopsis "Pairwise sequence alignment library")
  (description
    "Pairwise sequence alignment library")
  (license license:bsd-3)))

(define-public python-liftoff
  (package
   (name "python-liftoff")
   (version "1.6.1")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "Liftoff" version))
     (sha256
      (base32
       "0lahmwl7r7axn321hkiwprcalhgfdfchavkg9p1azgkd36sa6n1w"))
     (patches
      (parameterize
          ((%patch-path
            (map (lambda (directory)
                   (string-append directory "/detrout/packages/patches"))
                 %load-path)))
      (search-patches "python-liftoff-permissive-requires.patch")))))
   (build-system python-build-system)
;;   (arguments
;;    `(#:tests? #f))
   (propagated-inputs
    `(("python-biopython" ,python-biopython)
      ("python-gffutils" ,python-gffutils)
      ("python-interlap" ,python-interlap)
      ("python-networkx" ,python-networkx)
      ("python-numpy" ,python-numpy)
      ("python-parasail" ,python-parasail)
      ("python-pyfaidx" ,python-pyfaidx)
      ("python-pysam" ,python-pysam)
      ("python-ujson" ,python-ujson)))
   (home-page "https://github.com/ashumate/Liftoff")
   (synopsis "Gene annotation mapping tool")
   (description "Gene annotation mapping tool")
   (license license:gpl3)))
