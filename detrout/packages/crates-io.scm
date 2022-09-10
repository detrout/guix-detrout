(define-module (detrout packages crates-io)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages check)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages rust-apps)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system cargo)  ;; needed for maturin
  )

(define-public rust-anyhow-1.0.63
  (package (inherit rust-anyhow-1)
    (name "rust-anyhow")
    (version "1.0.63")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "anyhow" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "02j4c9ifsqhlgkbszb0i4vlakaczxj5gr21rfkgvmvpjwgbs8vx2"))))))

(define-public rust-async-broadcast-0.4
  (package
    (name "rust-async-broadcast")
    (version "0.4.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "async-broadcast" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0qgacs4f8b2x421zw412h8sib8zr74gb42bnm79iqb9vx17h09kd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-event-listener" ,rust-event-listener-2)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-parking-lot" ,rust-parking-lot-0.12))
       #:cargo-development-inputs (("rust-criterion" ,rust-criterion-0.3)
                                   ("rust-doc-comment" ,rust-doc-comment-0.3)
                                   ("rust-easy-parallel" ,rust-easy-parallel-3)
                                   ("rust-futures-lite" ,rust-futures-lite-1)
                                   ("rust-futures-util" ,rust-futures-util-0.3))))
    (home-page "https://github.com/smol-rs/async-broadcast")
    (synopsis "Async broadcast channels")
    (description "Async broadcast channels")
    (license (list license:expat license:asl2.0))))

(define-public rust-async-oneshot-0.5
  (package
    (name "rust-async-oneshot")
    (version "0.5.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "async-oneshot" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0b1f0kvp2cfm53hh4y62w2j5qh0psqpnjc3z2zlkj0fbrddwgiqy"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-futures-micro" ,rust-futures-micro-0.5))
       #:cargo-development-inputs (("rust-criterion" ,rust-criterion-0.3)
                                   ("rust-futures-lite" ,rust-futures-lite-1)
                                   ("rust-waker-fn" ,rust-waker-fn-1))))
    (home-page "https://github.com/irrustible/async-oneshot")
    (synopsis "A fast, small, full-featured, async-aware oneshot channel.")
    (description
     "This package provides a fast, small, full-featured, async-aware oneshot channel.")
    (license license:mpl2.0)))

(define-public rust-autocfg-1.1
  (package
    (name "rust-autocfg")
    (version "1.1.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "autocfg" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ylp3cb47ylzabimazvbz9ms6ap784zhb6syaz6c1jqpmcmq0s6l"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/cuviper/autocfg")
    (synopsis "Automatic cfg for Rust compiler features")
    (description "Automatic cfg for Rust compiler features")
    (license (list license:asl2.0 license:expat))))

(define-public rust-bitmaps-3
  (package (inherit rust-bitmaps-2)
    (name "rust-bitmaps")
    (version "3.2.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "bitmaps" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "00ql08pm4l9hizkldyy54v0pk96g7zg8x6i72c2vkcq0iawl4dkh"))))))

(define-public rust-buddy-alloc-0.4
  (package
    (name "rust-buddy-alloc")
    (version "0.4.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "buddy-alloc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1m9z7wbiblh3fi2wg5510g59ddsmj85b9pmmwa2xn1k4k0wg7ycg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-development-inputs (("rust-criterion" ,rust-criterion-0.3))))
    (home-page "https://github.com/jjyr/buddy-alloc")
    (synopsis
     "Buddy-alloc is a memory allocator for no-std Rust, used for embedded environments.")
    (description
     "Buddy-alloc is a memory allocator for no-std Rust, used for embedded
environments.")
    (license license:expat)))

(define-public rust-buf-min-0.7
  (package
    (name "rust-buf-min")
    (version "0.7.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "buf-min" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1hyr2yicp4xlpada6ndwdr3nmh0dykhqg9zqp9hg99b8bazxd8rl"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-bytes" ,rust-bytes-1)
                       ("rust-ntex-bytes" ,rust-ntex-bytes-0.1))))
    (home-page "https://github.com/botika/buf-min")
    (synopsis "Minimal utf-8 safe buffer traits")
    (description "Minimal utf-8 safe buffer traits")
    (license (list license:expat license:asl2.0))))

(define-public rust-bzip2-0.4.3
  (package (inherit rust-bzip2-0.4)
    (name "rust-bzip2")
    (version "0.4.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "bzip2" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1c495c2zh3knxwby2v1m7b21qddvrkya4mvyqlbm197knn0dkz3a"))))
    (arguments
     `(#:cargo-inputs (("rust-bzip2-sys" ,rust-bzip2-sys-0.1.11)
                       ("rust-futures" ,rust-futures-0.1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-tokio-io" ,rust-tokio-io-0.1))
       #:cargo-development-inputs (("rust-partial-io" ,rust-partial-io-0.3)
                                   ("rust-quickcheck" ,rust-quickcheck-1)
                                   ("rust-quickcheck" ,rust-quickcheck-0.6)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-tokio-core" ,rust-tokio-core-0.1))))))
    

(define-public rust-bzip2-sys-0.1.11
  (package (inherit rust-bzip2-sys-0.1)
    (name "rust-bzip2-sys")
    (version "0.1.11+1.0.8")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "bzip2-sys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1p2crnv8d8gpz5c2vlvzl0j55i3yqg5bi0kwsl1531x77xgraskk"))))))

(define-public rust-cab-0.4
  (package
    (name "rust-cab")
    (version "0.4.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cab" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0l9mgdp8jynb8xr2v08kbb3qc74mhwnrbk6k3xiw0fbx7ki4ssxf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-byteorder" ,rust-byteorder-1)
                       ("rust-flate2" ,rust-flate2-1)
                       ("rust-lzxd" ,rust-lzxd-0.1)
                       ("rust-time" ,rust-time-0.3))
       #:cargo-development-inputs (("rust-anyhow" ,rust-anyhow-1.0.63)
                                   ("rust-clap" ,rust-clap-2)
                                   ("rust-lipsum" ,rust-lipsum-0.8)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-time" ,rust-time-0.3)
                                   ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/mdsteele/rust-cab")
    (synopsis "Read/write Windows cabinet (CAB) files")
    (description "Read/write Windows cabinet (CAB) files")
    (license license:expat)))

(define-public rust-camino-1.1
  (package (inherit rust-camino-1)
    (name "rust-camino")
    (version "1.1.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "camino" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "07jc2jsyyhd2d0clpr0ama61b2hv09qzbfba2mx27pc87qg0xbc8"))))))

(define-public rust-cargo-options-0.3
  (package
    (name "rust-cargo-options")
    (version "0.3.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cargo-options" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ks2ikinfwsh8a5fchcsapwz3z9yxxyavhnsj8v586l78ypaxkcq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-clap" ,rust-clap-3.2.19))))
    (home-page "https://github.com/messense/cargo-options")
    (synopsis "Reusable common Cargo command line options")
    (description "Reusable common Cargo command line options")
    (license license:expat)))

(define-public rust-cargo-metadata-0.15
  (package (inherit rust-cargo-metadata-0.14)
    (name "rust-cargo-metadata")
    (version "0.15.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cargo-metadata" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0dpcddizs4zhbvbsv3kxx9p0qppidxh05jz7dlf45f5rsm9pbfrs"))))
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-camino" ,rust-camino-1)
        ("rust-cargo-platform" ,rust-cargo-platform-0.1.2)
        ("rust-derive-builder" ,rust-derive-builder-0.9)
        ("rust-semver" ,rust-semver-1)
        ("rust-serde" ,rust-serde-1)
        ("rust-serde-json" ,rust-serde-json-1))))))
    

(define-public rust-cargo-platform-0.1.2
  (package (inherit rust-cargo-platform-0.1)
    (name "rust-cargo-platform")
    (version "0.1.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cargo-platform" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "09zsf76b9yr02jh17xq925xp1w824w2bwvb78fd0gpx5m1fq5nyb"))))))

(define-public rust-cargo-zigbuild-0.12
  (package
    (name "rust-cargo-zigbuild")
    (version "0.12.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cargo-zigbuild" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1c4ia06lr5cxp3jfr7a33ifasrk69y5891d213rpy489wi0f3pnw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-anyhow" ,rust-anyhow-1.0.63)
                       ("rust-cargo-options" ,rust-cargo-options-0.3)
                       ("rust-cargo-metadata" ,rust-cargo-metadata-0.15)
                       ("rust-clap" ,rust-clap-3.2.19)
                       ("rust-dirs" ,rust-dirs-4)
                       ("rust-fs-err" ,rust-fs-err-2)
                       ("rust-path-slash" ,rust-path-slash-0.2)
                       ("rust-rustc-version" ,rust-rustc-version-0.4)
                       ("rust-semver" ,rust-semver-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-target-lexicon" ,rust-target-lexicon-0.12)
                       ("rust-which" ,rust-which-4))))
    (home-page "https://github.com/messense/cargo-zigbuild")
    (synopsis "Compile Cargo project with zig as linker")
    (description "Compile Cargo project with zig as linker")
    (license license:expat)))

(define-public rust-cargo-xwin-0.10
  (package
    (name "rust-cargo-xwin")
    (version "0.10.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cargo-xwin" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0n2ybpn18bc85rhcrz58ca01nbfdbn16s4inp2brqzcny9jpf04d"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-anyhow" ,rust-anyhow-1.0.63)
                       ("rust-cargo-options" ,rust-cargo-options-0.3)
                       ("rust-clap" ,rust-clap-3.2.19)
                       ("rust-dirs" ,rust-dirs-4)
                       ("rust-fs-err" ,rust-fs-err-2)
                       ("rust-indicatif" ,rust-indicatif-0.17)
                       ("rust-path-slash" ,rust-path-slash-0.2)
                       ("rust-which" ,rust-which-4)
                       ("rust-xwin" ,rust-xwin-0.2))))
    (home-page "https://github.com/messense/cargo-xwin")
    (synopsis "Cross compile Cargo project to Windows MSVC target with ease")
    (description
     "Cross compile Cargo project to Windows MSVC target with ease")
    (license license:expat)))

(define-public rust-cbindgen-0.24
  (package (inherit rust-cbindgen-0.19)
    (name "rust-cbindgen")
    (version "0.24.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cbindgen" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1yqxqsz2d0cppd8zwihk2139g5gy38wqgl9snj6rnk8gyvnqsdd6"))))
        (arguments
     `(#:cargo-inputs
       (("rust-clap" ,rust-clap-2)
        ("rust-heck" ,rust-heck-0.4)
        ("rust-indexmap" ,rust-indexmap-1)
        ("rust-log" ,rust-log-0.4)
        ("rust-proc-macro2" ,rust-proc-macro2-1)
        ("rust-quote" ,rust-quote-1)
        ("rust-serde" ,rust-serde-1)
        ("rust-serde-json" ,rust-serde-json-1)
        ("rust-syn" ,rust-syn-1.0.99)
        ("rust-tempfile" ,rust-tempfile-3)
        ("rust-toml" ,rust-toml-0.5))
       #:cargo-development-inputs
       (("rust-serial-test" ,rust-serial-test-0.5))))))


(define-public rust-cc-1.0.73
  (package (inherit rust-cc-1)
    (name "rust-cc")
    (version "1.0.73")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "04ccylrjq94jssh8f7d7hxv64gs9f1m1jrsxb7wqgfxk4xljmzrg"))))))

(define-public rust-cfb-0.7
  (package
    (name "rust-cfb")
    (version "0.7.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cfb" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "03y6p3dlm7gfds19bq4ba971za16rjbn7q2v0vqcri52l2kjv3yk"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-byteorder" ,rust-byteorder-1)
                       ("rust-fnv" ,rust-fnv-1)
                       ("rust-uuid" ,rust-uuid-1))
       #:cargo-development-inputs (("rust-clap" ,rust-clap-2)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-rand-pcg" ,rust-rand-pcg-0.3)
                                   ("rust-time" ,rust-time-0.3))))
    (home-page "https://github.com/mdsteele/rust-cfb")
    (synopsis "Read/write Compound File Binary (structured storage) files")
    (description "Read/write Compound File Binary (structured storage) files")
    (license license:expat)))

(define-public rust-clap-3.2.19
  (package (inherit rust-clap-3)
    (name "rust-clap")
    (version "3.2.19")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1mbzd518xmwhyk228z5lb01aqiwnmghq5y4za70bad3kfls3km38"))))
    (arguments
     `(#:cargo-inputs
       (("rust-atty" ,rust-atty-0.2)
        ("rust-bitflags" ,rust-bitflags-1)
        ("rust-clap-derive" ,rust-clap-derive-3.2)
        ("rust-indexmap" ,rust-indexmap-1)
        ("rust-os-str-bytes" ,rust-os-str-bytes-2)
        ("rust-strsim" ,rust-strsim-0.10)
        ("rust-termcolor" ,rust-termcolor-1.1.3)
        ("rust-terminal-size" ,rust-terminal-size-0.1)
        ("rust-textwrap" ,rust-textwrap-0.12)
        ("rust-unicode-width" ,rust-unicode-width-0.1)
        ("rust-vec-map" ,rust-vec-map-0.8)
        ("rust-yaml-rust" ,rust-yaml-rust-0.4))
       #:cargo-development-inputs
       (("rust-criterion" ,rust-criterion-0.3)
        ("rust-lazy-static" ,rust-lazy-static-1)
        ("rust-regex" ,rust-regex-1)
        ("rust-version-sync" ,rust-version-sync-0.8))))))
    

(define-public rust-clap-complete-3
  (package
    (name "rust-clap-complete")
    (version "3.2.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap-complete" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0gcrmads4mwfw9488zhs18xz9hc1q262836xaimw4mmx3akrs5z4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-clap" ,rust-clap-3.2.19)
                       ("rust-clap-lex" ,rust-clap-lex-0.2)
                       ("rust-is-executable" ,rust-is-executable-1)
                       ("rust-os-str-bytes" ,rust-os-str-bytes-6)
                       ("rust-pathdiff" ,rust-pathdiff-0.2)
                       ("rust-shlex" ,rust-shlex-1)
                       ("rust-unicode-xid" ,rust-unicode-xid-0.2))
       #:cargo-development-inputs (("rust-clap" ,rust-clap-3.2.19)
                                   ("rust-pretty-assertions" ,rust-pretty-assertions-1)
                                   ("rust-snapbox" ,rust-snapbox-0.2)
                                   ("rust-trycmd" ,rust-trycmd-0.13))))
    (home-page "https://github.com/clap-rs/clap/tree/master/clap_complete")
    (synopsis "Generate shell completion scripts for your clap::Command")
    (description "Generate shell completion scripts for your clap::Command")
    (license (list license:expat license:asl2.0))))

(define-public rust-clap-complete-fig-3
  (package
    (name "rust-clap-complete-fig")
    (version "3.2.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap-complete-fig" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1fb4965w8wyrcwq35ywgx4mzfsv2cqba73mdlvmp6ii1q70b8dzd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-clap" ,rust-clap-3.2.19)
                       ("rust-clap-complete" ,rust-clap-complete-3))
       #:cargo-development-inputs (("rust-snapbox" ,rust-snapbox-0.2))))
    (home-page "https://github.com/clap-rs/clap/tree/master/clap_complete_fig")
    (synopsis "A generator library used with clap for Fig completion scripts")
    (description
     "This package provides a generator library used with clap for Fig completion
scripts")
    (license (list license:expat license:asl2.0))))

(define-public rust-clap-derive-3.2
  (package (inherit rust-clap-derive-3)
    (name "rust-clap-derive")
    (version "3.2.18")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap_derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0r9az0cl33xx0i9g18l56l3vd5ayjvcflvza2gdf8jwcab78n37a"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-heck" ,rust-heck-0.4)
                       ("rust-proc-macro-error" ,rust-proc-macro-error-1)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/clap-rs/clap/tree/master/clap_derive")
    (synopsis
     "Parse command line argument by defining a struct, derive crate.")
    (description
     "Parse command line argument by defining a struct, derive crate.")
    (license (list license:expat license:asl2.0))))

(define-public rust-clap-lex-0.2
  (package
    (name "rust-clap-lex")
    (version "0.2.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap-lex" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ib1a9v55ybnaws11l63az0jgz5xiy24jkdgsmyl7grcm3sz4l18"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-os-str-bytes" ,rust-os-str-bytes-6))))
    (home-page "https://github.com/clap-rs/clap/tree/master/clap_lex")
    (synopsis "Minimal, flexible command line parser")
    (description "Minimal, flexible command line parser")
    (license (list license:expat license:asl2.0))))

(define-public rust-cli-table-0.4
  (package
    (name "rust-cli-table")
    (version "0.4.7")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cli-table" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "179pvik96qavn84rd74n3v0i4msnxq5hq39n25qbxi72v4bb3yxd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-cli-table-derive" ,rust-cli-table-derive-0.4)
                       ("rust-csv" ,rust-csv-1)
                       ("rust-termcolor" ,rust-termcolor-1.1.3)
                       ("rust-unicode-width" ,rust-unicode-width-0.1))))
    (home-page "https://github.com/devashishdxt/cli-table")
    (synopsis "A crate for printing tables on command line")
    (description
     "This package provides a crate for printing tables on command line")
    (license (list license:expat license:asl2.0))))

(define-public rust-cli-table-derive-0.4
  (package
    (name "rust-cli-table-derive")
    (version "0.4.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cli-table-derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1m4sh8z0b8q8bhxljdfl9rvk654jcdwzn93n8rn0lyv2vawvzwra"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/devashishdxt/cli-table")
    (synopsis "A crate for printing tables on command line")
    (description
     "This package provides a crate for printing tables on command line")
    (license (list license:expat license:asl2.0))))

(define-public rust-configparser-3
  (package (inherit rust-configparser-2)
    (name "rust-configparser")
    (version "3.0.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "configparser" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "066bdscah69mdj3dpx8cs1wf9blqs6plqqjl36jkd1489c6xxjv5"))))))

(define-public rust-cookie-0.16
  (package (inherit rust-cookie-0.15)
    (name "rust-cookie")
    (version "0.16.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cookie" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "01fa6z8sqqg19ya0l9ifh8vn05l5hpxdzkbh489mpymhw5np1m4l"))))))

(define-public rust-core-foundation-0.9.3
  (package (inherit rust-core-foundation-0.9)
    (name "rust-core-foundation")
    (version "0.9.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "core-foundation" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ii1ihpjb30fk38gdikm5wqlkmyr8k46fh4k2r8sagz5dng7ljhr"))))))

(define-public rust-core-foundation-sys-0.8.3
  (package (inherit rust-core-foundation-sys-0.8)
    (name "rust-core-foundation-sys")
    (version "0.8.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "core-foundation-sys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1p5r2wckarkpkyc4z83q08dwpvcafrb1h6fxfa3qnikh8szww9sq"))))))

(define-public rust-crc32fast-1.3
  (package (inherit rust-crc32fast-1)
    (name "rust-crc32fast")
    (version "1.3.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "crc32fast" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "03c8f29yx293yf43xar946xbls1g60c207m9drf8ilqhr25vsh5m"))))))

(define-public rust-crossbeam-utils-0.8
  (package (inherit rust-crossbeam-utils-0.7)
    (name "rust-crossbeam-utils")
    (version "0.8.11")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "crossbeam-utils" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1g426qw2j7czkbg0vw6mzifhgy1ng4qgpp2sn4vlamkvvi57v22i"))))))

(define-public rust-dialoguer-0.10
  (package (inherit rust-dialoguer-0.3)
    (name "rust-dialoguer")
    (version "0.10.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dialoguer" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ccf0xnhlcfxjb68688cb538x4xhslpx9if0q3ymfs7gxhvpwbm9"))))))

(define-public rust-dirs-4
  (package (inherit rust-dirs-3)
    (name "rust-dirs")
    (version "4.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dirs" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0n8020zl4f0frfnzvgb9agvk4a14i1kjz4daqnxkgslndwmaffna"))))))

(define-public rust-dunce-1.0.2
  (package (inherit rust-dunce-1)
    (name "rust-dunce")
    (version "1.0.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dunce" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0hbmlqjwj8q0vl3qsz72hlphszfb80jr9r205bypfmfgf7140d25"))))))

(define-public rust-enclose-1
  (package
    (name "rust-enclose")
    (version "1.1.8")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "enclose" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0mwk686pzbzabb8s52k4lyiy0qifnm4glbk6b819qvj2v99zamhh"))))
    (build-system cargo-build-system)
    (home-page "https://crates.io/crates/enclose")
    (synopsis "A convenient macro for cloning values into a closure.")
    (description
     "This package provides a convenient macro for cloning values into a closure.")
    (license license:expat)))

(define-public rust-enumflags2-0.7
  (package (inherit rust-enumflags2-0.6)
    (name "rust-enumflags2")
    (version "0.7.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "enumflags2" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1jswynhjjwsp6rfnyapbvhzxrf8lpfgr0f8mhd238f4m3g94qpg7"))))))

(define-public rust-fat-macho-0.4
  (package
    (name "rust-fat-macho")
    (version "0.4.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "fat-macho" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1w5hd1ma3cpai2kcjrg1jh0ksbz23cy8bqlbmis1fwcjraw1wgls"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-goblin" ,rust-goblin-0.5)
                       ("rust-llvm-bitcode" ,rust-llvm-bitcode-0.1))))
    (home-page "https://github.com/messense/fat-macho-rs.git")
    (synopsis "Mach-O Fat Binary Reader and Writer")
    (description "Mach-O Fat Binary Reader and Writer")
    (license license:expat)))

(define-public rust-fs-err-2.7
  (package (inherit rust-fs-err-2)
    (name "rust-fs-err")
    (version "2.7.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "fs-err" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0bk5fmwyk8b3lgfl5mi133s743hwq3z6awgvi6pd75d48nirzmsv"))))
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-scroll" ,rust-scroll-0.11)
        ("rust-plain" ,rust-plain-0.2)
        ("rust-log" ,rust-log-0.4))))))

(define-public rust-futures-micro-0.5
  (package
    (name "rust-futures-micro")
    (version "0.5.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "futures-micro" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "09n8d1qnpk6mjpnv338wkbgyppvd4aygfddwlwb8pmlk6m5jcq5l"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-pin-project-lite" ,rust-pin-project-lite-0.2))
       #:cargo-development-inputs (("rust-futures-lite" ,rust-futures-lite-0.1))))
    (home-page "https://github.com/irrustible/futures-micro")
    (synopsis "Minimal, no_std compatible async prelude.")
    (description "Minimal, no_std compatible async prelude.")
    (license (list license:asl2.0))))

(define-public rust-glommio-0.7
  (package
    (name "rust-glommio")
    (version "0.7.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "glommio" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "19lp0sa0fcm4w7nk093hlzg6y4rq1b4asz2khdv3kjxbgkk14sfx"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-ahash" ,rust-ahash-0.7)
                       ("rust-backtrace" ,rust-backtrace-0.3)
                       ("rust-bitflags" ,rust-bitflags-1)
                       ("rust-bitmaps" ,rust-bitmaps-3)
                       ("rust-buddy-alloc" ,rust-buddy-alloc-0.4)
                       ("rust-cc" ,rust-cc-1)
                       ("rust-concurrent-queue" ,rust-concurrent-queue-1)
                       ("rust-crossbeam" ,rust-crossbeam-0.8)
                       ("rust-enclose" ,rust-enclose-1)
                       ("rust-flume" ,rust-flume-0.10)
                       ("rust-futures-lite" ,rust-futures-lite-1)
                       ("rust-intrusive-collections" ,rust-intrusive-collections-0.9)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-lockfree" ,rust-lockfree-0.5)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-membarrier" ,rust-membarrier-0.2)
                       ("rust-nix" ,rust-nix-0.23)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-rlimit" ,rust-rlimit-0.6)
                       ("rust-scoped-tls" ,rust-scoped-tls-1)
                       ("rust-scopeguard" ,rust-scopeguard-1)
                       ("rust-signal-hook" ,rust-signal-hook-0.3)
                       ("rust-sketches-ddsketch" ,rust-sketches-ddsketch-0.1)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-socket2" ,rust-socket2-0.3)
                       ("rust-tracing" ,rust-tracing-0.1)
                       ("rust-typenum" ,rust-typenum-1))
       #:cargo-development-inputs (("rust-fastrand" ,rust-fastrand-1)
                                   ("rust-futures" ,rust-futures-0.3)
                                   ("rust-hdrhistogram" ,rust-hdrhistogram-7)
                                   ("rust-pretty-env-logger" ,rust-pretty-env-logger-0.4)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-tokio" ,rust-tokio-1)
                                   ("rust-tracing-subscriber" ,rust-tracing-subscriber-0.3))))
    (home-page "https://github.com/DataDog/glommio")
    (synopsis
     "Glommio is a thread-per-core crate that makes writing highly parallel asynchronous applications in a thread-per-core architecture easier for rustaceans.")
    (description
     "Glommio is a thread-per-core crate that makes writing highly parallel
asynchronous applications in a thread-per-core architecture easier for
rustaceans.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-goblin-0.5
  (package (inherit rust-goblin-0.2)
    (name "rust-goblin")
    (version "0.5.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "goblin" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0hs1npqx1nx4fwjm59c1n9pr581w0l0fwxk5dwdd5n0dxn1njrm7"))))))

(define-public rust-hdrhistogram-7
  (package (inherit rust-hdrhistogram-6)
    (name "rust-hdrhistogram")
    (version "7.5.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "hdrhistogram" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ar3wlm3rqnjmp0mwnwrcjirxbs76nd00x899shp89nka8wzxabf"))))))

(define-public rust-heck-0.4
  (package (inherit rust-heck-0.3)
    (name "rust-heck")
    (version "0.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "heck" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ygphsnfwl2xpa211vbqkz1db6ri1kvkg8p8sqybi37wclg7fh15"))))))

(define-public rust-human-panic-1
  (package
    (name "rust-human-panic")
    (version "1.0.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "human-panic" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0djfad84iwl86kabj8rqfhv5nn1qi1fd9hb7z72xgjxb02jmgwrr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-backtrace" ,rust-backtrace-0.3)
                       ("rust-os-type" ,rust-os-type-2)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-derive" ,rust-serde-derive-1)
                       ("rust-termcolor" ,rust-termcolor-1)
                       ("rust-toml" ,rust-toml-0.5)
                       ("rust-uuid" ,rust-uuid-0.8))))
    (home-page "https://github.com/yoshuawuyts/human-panic")
    (synopsis "Panic messages for humans")
    (description "Panic messages for humans")
    (license (list license:expat license:asl2.0))))

(define-public rust-indicatif-0.17
  (package (inherit rust-indicatif-0.15)
    (name "rust-indicatif")
    (version "0.17.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "indicatif" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1prx7c8vhy2qapijmyyi4whcjn2lbbk27cc56b06xn3hdqh2pi7w"))))
    (arguments
     `(#:cargo-inputs
       (("rust-console" ,rust-console-0.13)
        ("rust-lazy-static" ,rust-lazy-static-1)
        ("rust-number-prefix" ,rust-number-prefix-0.4)
        ("rust-rayon" ,rust-rayon-1)
        ("rust-regex" ,rust-regex-1)
        ("rust-unicode-segmentation" ,rust-unicode-segmentation-1)
        ("rust-unicode-width" ,rust-unicode-width-0.1))
       #:cargo-development-inputs
       (("rust-rand" ,rust-rand-0.7)
        ("rust-tokio" ,rust-tokio-0.2))))))

(define-public rust-intrusive-collections-0.9
  (package
    (name "rust-intrusive-collections")
    (version "0.9.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "intrusive-collections" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "12l80x569di2nsvn0krmly5l2m2zv4n3ykvxw7rj0wcxg2kk3rdz"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-memoffset" ,rust-memoffset-0.5))
       #:cargo-development-inputs (("rust-rand" ,rust-rand-0.8)
                                   ("rust-rand-xorshift" ,rust-rand-xorshift-0.3)
                                   ("rust-typed-arena" ,rust-typed-arena-2))))
    (home-page "https://github.com/Amanieu/intrusive-rs")
    (synopsis
     "Intrusive collections for Rust (linked list and red-black tree)")
    (description
     "Intrusive collections for Rust (linked list and red-black tree)")
    (license (list license:asl2.0 license:expat))))

(define-public rust-keyring-1
  (package
    (name "rust-keyring")
    (version "1.2.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "keyring" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1r8hka1hkb9li0f7qybpb5dhngk5y288syjpfjrcrgyavncq7yrq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-byteorder" ,rust-byteorder-1)
                       ("rust-secret-service" ,rust-secret-service-2)
                       ("rust-security-framework" ,rust-security-framework-2.6)
                       ("rust-winapi" ,rust-winapi-0.3))
       #:cargo-development-inputs (("rust-clap" ,rust-clap-3.2.19)
                                   ("rust-doc-comment" ,rust-doc-comment-0.3)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-rpassword" ,rust-rpassword-5)
                                   ("rust-whoami" ,rust-whoami-1))))
    (home-page "https://github.com/hwchen/keyring-rs")
    (synopsis "Cross-platform library for managing passwords/credentials")
    (description "Cross-platform library for managing passwords/credentials")
    (license (list license:expat license:asl2.0))))

(define-public rust-lddtree-0.2
  (package
    (name "rust-lddtree")
    (version "0.2.9")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "lddtree" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0wlckszl78rk3z6373r73v8ar1rhch6yqh4r6ps072hd45pn9nb2"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-fs-err" ,rust-fs-err-2)
                       ("rust-glob" ,rust-glob-0.3)
                       ("rust-goblin" ,rust-goblin-0.5))))
    (home-page "https://github.com/messense/lddtree-rs")
    (synopsis "Read the ELF dependency tree")
    (description "Read the ELF dependency tree")
    (license license:expat)))

(define-public rust-libc-0.2.132
  (package (inherit rust-libc-0.2)
    (name "rust-libc")
    (version "0.2.132")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "libc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "199vm5mz5gmd73lx07g06g2d9kl1qrd4dcky2bdrcfhw6kjy8wc3"))))))

(define-public rust-lock-api-0.4.8
  (package (inherit rust-lock-api-0.4)
    (name "rust-lock-api")
    (version "0.4.8")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "lock-api" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1463iqx8adn26vz5lkn5qh8kpgzj32vwzl8hhbycn9dgmidbz04z"))))
    (arguments
     `(#:cargo-inputs (("rust-autocfg" ,rust-autocfg-1.1)
                       ("rust-owning-ref" ,rust-owning-ref-0.4)
                       ("rust-scopeguard" ,rust-scopeguard-1)
                       ("rust-serde" ,rust-serde-1))))))
    
(define-public rust-lockfree-0.5
  (package
    (name "rust-lockfree")
    (version "0.5.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "lockfree" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "08yx0aq2qg37s60ki680w57ywlh97mw0y12sijwpqg0imnsr9vkl"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-owned-alloc" ,rust-owned-alloc-0.2))))
    (home-page "https://gitlab.com/bzim/lockfree/")
    (synopsis
     "This crate provides concurrent data structures and a solution to the ABA problem as an alternative of hazard pointers")
    (description
     "This crate provides concurrent data structures and a solution to the ABA problem
as an alternative of hazard pointers")
    (license license:expat)))

(define-public rust-llvm-bitcode-0.1
  (package
    (name "rust-llvm-bitcode")
    (version "0.1.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "llvm-bitcode" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1fskb2nzddg8m038kh2lm91gb5yg0l4j3rcnv44kz7f37kcxz5cb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-num-enum" ,rust-num-enum-0.5))))
    (home-page "https://github.com/messense/llvm-bitcode-rs.git")
    (synopsis "LLVM Bitcode parser in Rust")
    (description "LLVM Bitcode parser in Rust")
    (license license:expat)))

(define-public rust-lzxd-0.1
  (package
    (name "rust-lzxd")
    (version "0.1.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "lzxd" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "04xjqs0n9yrl5ifsr2bq1aqqqa2amnj3z5ny8pdxznfx1pr64i3q"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/Lonami/lzxd")
    (synopsis
     "Decompression implementation for Microsoft's LZXD compression format.
")
    (description
     "Decompression implementation for Microsoft's LZXD compression format.")
    (license (list license:expat license:asl2.0))))

(define-public rust-membarrier-0.2
  (package
    (name "rust-membarrier")
    (version "0.2.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "membarrier" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "072vjmfdr0hggcdxbi7dg2mkmhkygc2ca1jrddk2pyz5sw8hhnwj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-kernel32-sys" ,rust-kernel32-sys-0.2)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-libc" ,rust-libc-0.2))))
    (home-page "https://github.com/jeehoonkang/membarrier-rs")
    (synopsis "Process-wide memory barrier")
    (description "Process-wide memory barrier")
    (license (list license:expat license:asl2.0))))

(define-public rust-memo-map-0.3
  (package
    (name "rust-memo-map")
    (version "0.3.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "memo-map" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0h0c80ilf74872nfn1dx65zdj60cxcczrbks113l9kk0jp07dhmf"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/mitsuhiko/memo-map")
    (synopsis "A crate implementing a synchronized map for memoization")
    (description
     "This package provides a crate implementing a synchronized map for memoization")
    (license license:asl2.0)))

(define-public rust-minijinja-0.17
  (package
    (name "rust-minijinja")
    (version "0.17.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "minijinja" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1hwpk81qj2603s23cjx1mfmai5vk31834blbhnrgxhb314a61zyc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-indexmap" ,rust-indexmap-1)
                       ("rust-memo-map" ,rust-memo-map-0.3)
                       ("rust-percent-encoding" ,rust-percent-encoding-2)
                       ("rust-self-cell" ,rust-self-cell-0.10)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-v-htmlescape" ,rust-v-htmlescape-0.15))
       #:cargo-development-inputs (("rust-insta" ,rust-insta-1)
                                   ("rust-serde-json" ,rust-serde-json-1)
                                   ("rust-similar-asserts" ,rust-similar-asserts-1))))
    (home-page "https://github.com/mitsuhiko/minijinja")
    (synopsis "a powerful template engine for Rust with minimal dependencies")
    (description
     "a powerful template engine for Rust with minimal dependencies")
    (license license:asl2.0)))

(define-public rust-msi-0.5
  (package
    (name "rust-msi")
    (version "0.5.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "msi" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "145cj5yb4kh8wwncxbsvn4jgqidr5s31a1jvg4axplcw3rsac8ci"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-byteorder" ,rust-byteorder-1)
                       ("rust-cfb" ,rust-cfb-0.7)
                       ("rust-encoding" ,rust-encoding-0.2)
                       ("rust-uuid" ,rust-uuid-1))
       #:cargo-development-inputs (("rust-clap" ,rust-clap-2)
                                   ("rust-pest" ,rust-pest-2)
                                   ("rust-pest-derive" ,rust-pest-derive-2)
                                   ("rust-time" ,rust-time-0.3))))
    (home-page "https://github.com/mdsteele/rust-msi")
    (synopsis "Read/write Windows Installer (MSI) files")
    (description "Read/write Windows Installer (MSI) files")
    (license license:expat)))

(define-public rust-nanorand-0.6
  (package (inherit rust-nanorand-0.5)
    (name "rust-nanorand")
    (version "0.6.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "nanorand" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1drz0xrhss13d15p9lzzypn2a2r7kqdsihkymqck84lzn8y7ds82"))))))

(define-public rust-native-tls-0.2.10
  (package (inherit rust-native-tls-0.2)
    (name "rust-native-tls")
    (version "0.2.10")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "native-tls" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ad4dhkbc3r9rbqdym1cl5zwkqzfa9i8bs0p1c79hzsm30v2yzpx"))))
    (arguments
     `(#:tests? #f                      ; tests require network access
       #:cargo-inputs
       (("rust-lazy-static" ,rust-lazy-static-1)
        ("rust-libc" ,rust-libc-0.2)
        ("rust-log" ,rust-log-0.4)
        ("rust-openssl" ,rust-openssl-0.10)
        ("rust-openssl-probe" ,rust-openssl-probe-0.1)
        ("rust-openssl-sys" ,rust-openssl-sys-0.9)
        ("rust-schannel" ,rust-schannel-0.1.17)
        ("rust-security-framework" ,rust-security-framework-2)
        ("rust-security-framework-sys" ,rust-security-framework-sys-2)
        ("rust-tempfile" ,rust-tempfile-3))
       #:cargo-development-inputs
       (("rust-hex" ,rust-hex-0.4)
        ("rust-test-cert-gen" ,rust-test-cert-gen-0.1))))))

(define-public rust-nix-0.24
  (package (inherit rust-nix-0.22)
    (name "rust-nix")
    (version "0.24.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "nix" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1z35n1bhzslr7zawy2c0fl90jjy9l5b3lnsidls3908vfk0xnp0r"))))))

(define-public rust-nix-0.22.3
  (package (inherit rust-nix-0.22)
    (name "rust-nix")
    (version "0.22.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "nix" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1bsgc8vjq07a1wg9vz819bva3dvn58an4r87h80dxrfqkqanz4g4"))))))


(define-public rust-num-enum-0.5
  (package
    (name "rust-num-enum")
    (version "0.5.7")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "num-enum" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1j8rq7i4xnbzy72z82k41469xlj1bmn4ixagd9wlbvv2ark9alyg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-num-enum-derive" ,rust-num-enum-derive-0.5))
       #:cargo-development-inputs (("rust-anyhow" ,rust-anyhow-1.0.63)
                                   ("rust-rustversion" ,rust-rustversion-1)
                                   ("rust-trybuild" ,rust-trybuild-1)
                                   ("rust-walkdir" ,rust-walkdir-2))))
    (home-page "https://github.com/illicitonion/num_enum")
    (synopsis
     "Procedural macros to make inter-operation between primitives and enums easier.")
    (description
     "Procedural macros to make inter-operation between primitives and enums easier.")
    (license (list license:bsd-3 license:expat license:asl2.0))))

(define-public rust-num-enum-derive-0.5
  (package
    (name "rust-num-enum-derive")
    (version "0.5.7")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "num-enum-derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1kj6b8f2fx8prlcl6y1k97668s5aiia4f9gjlk0nmpak3rj9h11v"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-proc-macro-crate" ,rust-proc-macro-crate-1)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/illicitonion/num_enum")
    (synopsis
     "Internal implementation details for ::num_enum (Procedural macros to make inter-operation between primitives and enums easier)")
    (description
     "Internal implementation details for ::num_enum (Procedural macros to make
inter-operation between primitives and enums easier)")
    (license (list license:bsd-3 license:expat license:asl2.0))))

(define-public rust-number-prefix-0.4
  (package (inherit rust-number-prefix-0.3)
    (name "rust-number-prefix")
    (version "0.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "number_prefix" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1wvh13wvlajqxkb1filsfzbrnq0vrmrw298v2j3sy82z1rm282w3"))))))

(define-public rust-ntest-0.7
  (package (inherit rust-ntest-0.3)
    (name "rust-ntest")
    (version "0.7.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntest" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1yyih3b0bcr9gj11m9xj330as2sjihblkmb2bmv10lp38q5m0rg8"))))))

(define-public rust-ntex-0.5
  (package
    (name "rust-ntex")
    (version "0.5.25")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntex" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1d6n621dmjyc5mkqci5d4ycyba23w28g46i4d493xccving0q802"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-async-channel" ,rust-async-channel-1)
                       ("rust-async-oneshot" ,rust-async-oneshot-0.5)
                       ("rust-base64" ,rust-base64-0.13)
                       ("rust-bitflags" ,rust-bitflags-1)
                       ("rust-brotli2" ,rust-brotli2-0.3)
                       ("rust-cookie" ,rust-cookie-0.16)
                       ("rust-encoding-rs" ,rust-encoding-rs-0.8)
                       ("rust-flate2" ,rust-flate2-1)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-httparse" ,rust-httparse-1)
                       ("rust-httpdate" ,rust-httpdate-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-nanorand" ,rust-nanorand-0.6)
                       ("rust-ntex-async-std" ,rust-ntex-async-std-0.1)
                       ("rust-ntex-bytes" ,rust-ntex-bytes-0.1)
                       ("rust-ntex-codec" ,rust-ntex-codec-0.6)
                       ("rust-ntex-connect" ,rust-ntex-connect-0.1)
                       ("rust-ntex-glommio" ,rust-ntex-glommio-0.1)
                       ("rust-ntex-h2" ,rust-ntex-h2-0.1)
                       ("rust-ntex-http" ,rust-ntex-http-0.1)
                       ("rust-ntex-io" ,rust-ntex-io-0.1)
                       ("rust-ntex-macros" ,rust-ntex-macros-0.1)
                       ("rust-ntex-router" ,rust-ntex-router-0.5)
                       ("rust-ntex-rt" ,rust-ntex-rt-0.4)
                       ("rust-ntex-service" ,rust-ntex-service-0.3)
                       ("rust-ntex-tls" ,rust-ntex-tls-0.1)
                       ("rust-ntex-tokio" ,rust-ntex-tokio-0.1)
                       ("rust-ntex-util" ,rust-ntex-util-0.1)
                       ("rust-num-cpus" ,rust-num-cpus-1)
                       ("rust-openssl" ,rust-openssl-0.10)
                       ("rust-percent-encoding" ,rust-percent-encoding-2)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-polling" ,rust-polling-2)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-rustls" ,rust-rustls-0.20)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-urlencoded" ,rust-serde-urlencoded-0.7)
                       ("rust-sha-1" ,rust-sha-1-0.10)
                       ("rust-socket2" ,rust-socket2-0.4)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-url" ,rust-url-2)
                       ("rust-webpki-roots" ,rust-webpki-roots-0.22))
       #:cargo-development-inputs (("rust-env-logger" ,rust-env-logger-0.9)
                                   ("rust-futures-util" ,rust-futures-util-0.3)
                                   ("rust-openssl" ,rust-openssl-0.10)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-rustls" ,rust-rustls-0.20)
                                   ("rust-rustls-pemfile" ,rust-rustls-pemfile-1)
                                   ("rust-time" ,rust-time-0.3)
                                   ("rust-webpki-roots" ,rust-webpki-roots-0.22))))
    (home-page "https://github.com/ntex-rs/ntex.git")
    (synopsis "Framework for composable network services")
    (description "Framework for composable network services")
    (license license:expat)))

(define-public rust-ntex-async-std-0.1
  (package
    (name "rust-ntex-async-std")
    (version "0.1.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntex-async-std" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1vbkjjc57vifxllx3a3r6n6fnzzpc3hncgpzq4lzgwn13dvfwapd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-async-oneshot" ,rust-async-oneshot-0.5)
                       ("rust-async-std" ,rust-async-std-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-ntex-bytes" ,rust-ntex-bytes-0.1)
                       ("rust-ntex-io" ,rust-ntex-io-0.1)
                       ("rust-ntex-util" ,rust-ntex-util-0.1)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2))))
    (home-page "https://ntex.rs")
    (synopsis "async-std intergration for ntex framework")
    (description "async-std intergration for ntex framework")
    (license license:expat)))

(define-public rust-ntex-bytes-0.1
  (package
    (name "rust-ntex-bytes")
    (version "0.1.16")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntex-bytes" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0hangmxzqhwh2948fpsvwwncpmlb9a6813gsp1kf62alvqwbqivm"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-simdutf8" ,rust-simdutf8-0.1))
       #:cargo-development-inputs (("rust-ntex" ,rust-ntex-0.5)
                                   ("rust-serde-json" ,rust-serde-json-1)
                                   ("rust-serde-test" ,rust-serde-test-1))))
    (home-page "https://github.com/ntex-rs")
    (synopsis "Types and traits for working with bytes (bytes crate fork)")
    (description "Types and traits for working with bytes (bytes crate fork)")
    (license license:expat)))

(define-public rust-ntex-codec-0.6
  (package
    (name "rust-ntex-codec")
    (version "0.6.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntex-codec" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1nkgwjy26c7ih32ncgv4nnqj18d2iir9dx1df5fr3fs6v48y39v9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-ntex-bytes" ,rust-ntex-bytes-0.1))))
    (home-page "https://ntex.rs")
    (synopsis "Utilities for encoding and decoding frames")
    (description "Utilities for encoding and decoding frames")
    (license license:expat)))

(define-public rust-ntex-connect-0.1
  (package
    (name "rust-ntex-connect")
    (version "0.1.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntex-connect" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ivlp9vvqv4g7z9wgpm2vinshhr932gvvda0m2cdxb0br7zzsjaf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-ntex-async-std" ,rust-ntex-async-std-0.1)
                       ("rust-ntex-bytes" ,rust-ntex-bytes-0.1)
                       ("rust-ntex-glommio" ,rust-ntex-glommio-0.1)
                       ("rust-ntex-http" ,rust-ntex-http-0.1)
                       ("rust-ntex-io" ,rust-ntex-io-0.1)
                       ("rust-ntex-rt" ,rust-ntex-rt-0.4)
                       ("rust-ntex-service" ,rust-ntex-service-0.3)
                       ("rust-ntex-tls" ,rust-ntex-tls-0.1)
                       ("rust-ntex-tokio" ,rust-ntex-tokio-0.1)
                       ("rust-ntex-util" ,rust-ntex-util-0.1)
                       ("rust-openssl" ,rust-openssl-0.10)
                       ("rust-rustls" ,rust-rustls-0.20)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-webpki-roots" ,rust-webpki-roots-0.22))
       #:cargo-development-inputs (("rust-env-logger" ,rust-env-logger-0.9)
                                   ("rust-rand" ,rust-rand-0.8))))
    (home-page "https://ntex.rs")
    (synopsis "ntexwork connect utils for ntex framework")
    (description "ntexwork connect utils for ntex framework")
    (license license:expat)))

(define-public rust-ntex-glommio-0.1
  (package
    (name "rust-ntex-glommio")
    (version "0.1.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntex-glommio" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0lj9r9p9bd16gr2i7h4wa0nbmk3jacjngkx5xs9162zflvwvfjnw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-async-oneshot" ,rust-async-oneshot-0.5)
                       ("rust-futures-lite" ,rust-futures-lite-1)
                       ("rust-glommio" ,rust-glommio-0.7)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-ntex-bytes" ,rust-ntex-bytes-0.1)
                       ("rust-ntex-io" ,rust-ntex-io-0.1)
                       ("rust-ntex-util" ,rust-ntex-util-0.1))))
    (home-page "https://ntex.rs")
    (synopsis "glommio intergration for ntex framework")
    (description "glommio intergration for ntex framework")
    (license license:expat)))

(define-public rust-ntex-h2-0.1
  (package
    (name "rust-ntex-h2")
    (version "0.1.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntex-h2" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "10r9kfzgxa4nyb7lbz8h5280hpk9l6fmqa54kpra6xcdfc9zlj5v"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-fxhash" ,rust-fxhash-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-ntex-bytes" ,rust-ntex-bytes-0.1)
                       ("rust-ntex-codec" ,rust-ntex-codec-0.6)
                       ("rust-ntex-connect" ,rust-ntex-connect-0.1)
                       ("rust-ntex-http" ,rust-ntex-http-0.1)
                       ("rust-ntex-io" ,rust-ntex-io-0.1)
                       ("rust-ntex-rt" ,rust-ntex-rt-0.4)
                       ("rust-ntex-service" ,rust-ntex-service-0.3)
                       ("rust-ntex-util" ,rust-ntex-util-0.1)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-thiserror" ,rust-thiserror-1))
       #:cargo-development-inputs (("rust-env-logger" ,rust-env-logger-0.9)
                                   ("rust-hex" ,rust-hex-0.4)
                                   ("rust-ntex" ,rust-ntex-0.5)
                                   ("rust-ntex-connect" ,rust-ntex-connect-0.1)
                                   ("rust-ntex-tls" ,rust-ntex-tls-0.1)
                                   ("rust-openssl" ,rust-openssl-0.10)
                                   ("rust-quickcheck" ,rust-quickcheck-1)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-serde" ,rust-serde-1)
                                   ("rust-serde-json" ,rust-serde-json-1)
                                   ("rust-walkdir" ,rust-walkdir-2))))
    (home-page "https://github.com/ntex-rs/ntex-h2")
    (synopsis "An HTTP/2 client and server")
    (description "An HTTP/2 client and server")
    (license license:expat)))

(define-public rust-ntex-io-0.1
  (package
    (name "rust-ntex-io")
    (version "0.1.8")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntex-io" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0bpzpvlx86087f1f30g64f3azwhq0yjaayjb90n9i167r7b79r3k"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-ntex-bytes" ,rust-ntex-bytes-0.1)
                       ("rust-ntex-codec" ,rust-ntex-codec-0.6)
                       ("rust-ntex-service" ,rust-ntex-service-0.3)
                       ("rust-ntex-util" ,rust-ntex-util-0.1)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2))
       #:cargo-development-inputs (("rust-env-logger" ,rust-env-logger-0.9)
                                   ("rust-ntex" ,rust-ntex-0.5)
                                   ("rust-rand" ,rust-rand-0.8))))
    (home-page "https://ntex.rs")
    (synopsis "Utilities for encoding and decoding frames")
    (description "Utilities for encoding and decoding frames")
    (license license:expat)))

(define-public rust-ntex-macros-0.1
  (package
    (name "rust-ntex-macros")
    (version "0.1.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntex-macros" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "117d2w4fiq99lbv3k0ghgixdadql5g170l378q22nw8cl7r5k8sh"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))
       #:cargo-development-inputs (("rust-futures" ,rust-futures-0.3)
                                   ("rust-ntex" ,rust-ntex-0.3))))
    (home-page "")
    (synopsis "ntex proc macros")
    (description "ntex proc macros")
    (license license:expat)))

(define-public rust-ntex-router-0.5
  (package
    (name "rust-ntex-router")
    (version "0.5.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntex-router" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "17hvrjamc4zp22ycgi7fa93vyzw2xrz66djvc6ljnmgwd751nqv7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-http" ,rust-http-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-ntex-bytes" ,rust-ntex-bytes-0.1)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-serde" ,rust-serde-1))
       #:cargo-development-inputs (("rust-http" ,rust-http-0.2)
                                   ("rust-serde-derive" ,rust-serde-derive-1))))
    (home-page "https://github.com/ntex-rs/ntex.git")
    (synopsis "Path router")
    (description "Path router")
    (license license:expat)))

(define-public rust-ntex-rt-0.4
  (package
    (name "rust-ntex-rt")
    (version "0.4.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntex-rt" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0grz2yxsnh8y85z5p4v315ylp70gcsw2iqyagsk7cnh43dx50mr9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-async-channel" ,rust-async-channel-1)
                       ("rust-async-oneshot" ,rust-async-oneshot-0.5)
                       ("rust-async-std" ,rust-async-std-1)
                       ("rust-futures-channel" ,rust-futures-channel-0.3)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-glommio" ,rust-glommio-0.7)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://ntex.rs")
    (synopsis "ntex runtime")
    (description "ntex runtime")
    (license license:expat)))

(define-public rust-ntex-service-0.3
  (package
    (name "rust-ntex-service")
    (version "0.3.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntex-service" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "171v8854jkmnian6l7v6fxdanlrjqvn3s771n6h8vhfsrqqbcbrh"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-pin-project-lite" ,rust-pin-project-lite-0.2))
       #:cargo-development-inputs (("rust-ntex" ,rust-ntex-0.5)
                                   ("rust-ntex-util" ,rust-ntex-util-0.1))))
    (home-page "https://ntex.rs")
    (synopsis "ntex service")
    (description "ntex service")
    (license license:expat)))

(define-public rust-ntex-tls-0.1
  (package
    (name "rust-ntex-tls")
    (version "0.1.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntex-tls" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0jwkrpdd61va376yd97i07jcr61ncfi90q7lffsjr0ffria1g100"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-ntex-bytes" ,rust-ntex-bytes-0.1)
                       ("rust-ntex-io" ,rust-ntex-io-0.1)
                       ("rust-ntex-service" ,rust-ntex-service-0.3)
                       ("rust-ntex-util" ,rust-ntex-util-0.1)
                       ("rust-openssl" ,rust-openssl-0.10)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-rustls" ,rust-rustls-0.20))
       #:cargo-development-inputs (("rust-env-logger" ,rust-env-logger-0.9)
                                   ("rust-log" ,rust-log-0.4)
                                   ("rust-ntex" ,rust-ntex-0.5)
                                   ("rust-rustls-pemfile" ,rust-rustls-pemfile-0.2)
                                   ("rust-webpki-roots" ,rust-webpki-roots-0.22))))
    (home-page "https://ntex.rs")
    (synopsis "An implementation of SSL streams for ntex backed by OpenSSL")
    (description "An implementation of SSL streams for ntex backed by OpenSSL")
    (license license:expat)))

(define-public rust-ntex-tokio-0.1
  (package
    (name "rust-ntex-tokio")
    (version "0.1.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntex-tokio" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0f7y55r6jgjzylkb9ikz7vkk3134ajgrsr3s3ajxngr0xpflgkzh"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-ntex-bytes" ,rust-ntex-bytes-0.1)
                       ("rust-ntex-io" ,rust-ntex-io-0.1)
                       ("rust-ntex-util" ,rust-ntex-util-0.1)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://ntex.rs")
    (synopsis "tokio intergration for ntex framework")
    (description "tokio intergration for ntex framework")
    (license license:expat)))

(define-public rust-ntex-util-0.1
  (package
    (name "rust-ntex-util")
    (version "0.1.17")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntex-util" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0y96qrz7l1sax17qgwbkb4xivsyqbgacpdl0zjh65i4ra3m1bgwb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-sink" ,rust-futures-sink-0.3)
                       ("rust-futures-timer" ,rust-futures-timer-3)
                       ("rust-fxhash" ,rust-fxhash-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-ntex-rt" ,rust-ntex-rt-0.4)
                       ("rust-ntex-service" ,rust-ntex-service-0.3)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-slab" ,rust-slab-0.4))
       #:cargo-development-inputs (("rust-futures-util" ,rust-futures-util-0.3)
                                   ("rust-ntex" ,rust-ntex-0.5)
                                   ("rust-ntex-bytes" ,rust-ntex-bytes-0.1)
                                   ("rust-ntex-macros" ,rust-ntex-macros-0.1))))
    (home-page "https://ntex.rs")
    (synopsis "Utilities for ntex framework")
    (description "Utilities for ntex framework")
    (license license:expat)))

(define-public rust-num-threads-0.1
  (package
    (name "rust-num-threads")
    (version "0.1.6")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "num-threads" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0i5vmffsv6g79z869flp1sja69g1gapddjagdw1k3q9f3l2cw698"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-libc" ,rust-libc-0.2))))
    (home-page "https://github.com/jhpratt/num_threads")
    (synopsis
     "A minimal library that determines the number of running threads for the current process.")
    (description
     "This package provides a minimal library that determines the number of running
threads for the current process.")
    (license (list license:expat license:asl2.0))))

(define-public rust-once-cell-1.14
  (package (inherit rust-once-cell-1)
    (name "rust-once-cell")
    (version "1.14.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "once_cell" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1h6pc09c5yf1vyyb32sp12k3j9w853vfn22bl9yxgjiikswm8wig"))))))

(define-public rust-ordered-stream-0.0.1
  (package
    (name "rust-ordered-stream")
    (version "0.0.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ordered-stream" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1cfc4mgsl29ij9g27hfxlk51jcg35kdv2ldapl46xzdckq2hqqs4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2))))
    (home-page "https://github.com/danieldg/ordered-stream")
    (synopsis "Streams that are ordered relative to external events")
    (description "Streams that are ordered relative to external events")
    (license (list license:expat license:asl2.0))))

(define-public rust-os-type-2
  (package
    (name "rust-os-type")
    (version "2.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "os-type" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1293gl2x38q7bhk3f7155k1aq0nvhq6vdksgz1cq6abhchgpdpy3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-regex" ,rust-regex-1))))
    (home-page "https://github.com/schultyy/os_type")
    (synopsis "Detect the operating system type")
    (description "Detect the operating system type")
    (license license:expat)))

(define-public rust-owned-alloc-0.2
  (package
    (name "rust-owned-alloc")
    (version "0.2.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "owned-alloc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1mh54983yz8chn6lc4rgvhazys73dc129y654a9gy4ls3x0ypz1h"))))
    (build-system cargo-build-system)
    (home-page "https://gitlab.com/bzim/owned-alloc")
    (synopsis "A crate to help reducing manual memory management errors.")
    (description
     "This package provides a crate to help reducing manual memory management errors.")
    (license license:expat)))

(define-public rust-parking-lot-0.12
  (package (inherit rust-parking-lot-0.11)
    (name "rust-parking-lot")
    (version "0.12.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "parking-lot" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "13r2xk7mnxfc5g0g6dkdxqdqad99j7s7z8zhzz4npw5r0g0v4hip"))))
    (arguments
     `(#:cargo-inputs (("rust-lock-api" ,rust-lock-api-0.4.8)
                       ("rust-parking-lot-core" ,rust-parking-lot-core-0.9.3))
       #:cargo-development-inputs (("rust-bincode" ,rust-bincode-1)
                                   ("rust-rand" ,rust-rand-0.8))))))

(define-public rust-parking-lot-core-0.9.3
  (package (inherit rust-parking-lot-0.9)
    (name "rust-parking-lot-core")
    (version "0.9.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "parking-lot-core" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ab95rljb99rm51wcic16jgbajcr6lgbqkrr21w7bc2wyb5pk8h9"))))
    (arguments
     `(#:cargo-inputs (("rust-backtrace" ,rust-backtrace-0.3)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-petgraph" ,rust-petgraph-0.6)
                       ("rust-redox-syscall" ,rust-redox-syscall-0.2)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-thread-id" ,rust-thread-id-4)
                       ("rust-windows-sys" ,rust-windows-sys-0.36))))))


(define-public rust-path-slash-0.2
  (package (inherit rust-path-slash-0.1)
    (name "rust-path-slash")
    (version "0.2.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "path-slash" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0hjgljv4vy97qqw9gxnwzqhhpysjss2yhdphfccy3c388afhk48y"))))))

(define-public rust-pep440-0.2
  (package
    (name "rust-pep440")
    (version "0.2.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "pep440" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "12dx79jwmql7nnq1jgayy4ijwh6v26b6sjfdiqz91g7slq6b0hc8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-regex" ,rust-regex-1))))
    (home-page "https://github.com/relrod/pep440-rs")
    (synopsis "Parse and compare Python PEP440 style version numbers")
    (description "Parse and compare Python PEP440 style version numbers")
    (license (list license:bsd-2 license:asl2.0))))

(define-public rust-pin-project-lite-0.2.9
  (package (inherit rust-pin-project-lite-0.2)
    (name "rust-pin-project-lite")
    (version "0.2.9")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "pin-project-lite" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "05n1z851l356hpgqadw4ar64mjanaxq1qlwqsf2k05ziq8xax9z0"))))))

(define-public rust-platform-info-0.2
  (package
    (name "rust-platform-info")
    (version "0.2.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "platform-info" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "187jxpbpjy7mmf522s7p6i557vffcdgf6hx1brppwmixw16jqcw4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-libc" ,rust-libc-0.2)
                       ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/uutils/platform-info")
    (synopsis "A simple cross-platform interface to get info about a system")
    (description
     "This package provides a simple cross-platform interface to get info about a system")
   (license license:expat)))

(define-public rust-proc-macro2-1.0.43
  (package (inherit rust-proc-macro2-1)
    (name "rust-proc-macro2")
    (version "1.0.43")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "proc-macro2" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1avvpf4qki8mg2na60yr3afbsfl5p6vllac6516xgwy93g3a4b0a"))))))

(define-public rust-pyproject-toml-0.3
  (package
    (name "rust-pyproject-toml")
    (version "0.3.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "pyproject-toml" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1yx8m8a6hf578dxdpv9irrfin2fyfsdyq6bgkxwab24ayznha11q"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-serde" ,rust-serde-1)
                       ("rust-toml" ,rust-toml-0.5))))
    (home-page "https://github.com/PyO3/pyproject-toml-rs.git")
    (synopsis "pyproject.toml parser in Rust")
    (description "pyproject.toml parser in Rust")
    (license license:expat)))

(define-public rust-python-pkginfo-0.5
  (package
    (name "rust-python-pkginfo")
    (version "0.5.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "python-pkginfo" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1wh3jn71zp6fv9ic65sx47k5hgh7p23ln9qs6b25r36w5bd5277m"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-bzip2" ,rust-bzip2-0.4.3)
                       ("rust-flate2" ,rust-flate2-1)
                       ("rust-fs-err" ,rust-fs-err-2)
                       ("rust-mailparse" ,rust-mailparse-0.13)
                       ("rust-rfc2047-decoder" ,rust-rfc2047-decoder-0.1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-tar" ,rust-tar-0.4)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-xz" ,rust-xz2-0.1)
                       ("rust-zip" ,rust-zip-0.6))))
    (home-page "https://github.com/PyO3/python-pkginfo-rs")
    (synopsis "Parse Python package metadata from sdist and bdists and etc.")
    (description
     "Parse Python package metadata from sdist and bdists and etc.")
    (license license:expat)))

(define-public rust-roaring-0.9
  (package
    (name "rust-roaring")
    (version "0.9.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "roaring" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1xx5hl7vplvn7ljw8libpvs04j3dpdhg233yzrb9j09j9smrqlyx"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-bytemuck" ,rust-bytemuck-1)
                       ("rust-byteorder" ,rust-byteorder-1)
                       ("rust-retain-mut" ,rust-retain-mut-0.1))
       #:cargo-development-inputs (("rust-proptest" ,rust-proptest-1))))
    (home-page "https://github.com/RoaringBitmap/roaring-rs")
    (synopsis
     "https://roaringbitmap.org: A better compressed bitset - pure Rust implementation")
    (description
     "https://roaringbitmap.org: A better compressed bitset - pure Rust implementation")
    (license (list license:expat license:asl2.0))))

(define-public rust-rlimit-0.6
  (package
    (name "rust-rlimit")
    (version "0.6.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rlimit" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "09hpr6dfrx7xzlps7g25akqp2p32190vhcj3ymid6vrpaiaz42yc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-libc" ,rust-libc-0.2))))
    (home-page "https://github.com/Nugine/rlimit/")
    (synopsis "Resource limits")
    (description "Resource limits")
    (license license:expat)))

(define-public rust-rpassword-7
  (package (inherit rust-rpassword-5)
    (name "rust-rpassword")
    (version "7.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rpassword" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (patches
               (parameterize
                   ((%patch-path
                     (map (lambda (directory)
                            (string-append directory "/detrout/packages/patches"))
                          %load-path)))
               (search-patches "rpassword-7-remove-serde-json.patch")))
              (sha256
               (base32
                "100n7imx25q004bgqnc5blrw7knliczhadfc6a29476zcv5n7dr6"))))))

(define-public rust-rfc2047-decoder-0.1
  (package
    (name "rust-rfc2047-decoder")
    (version "0.1.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rfc2047-decoder" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0xwxl6ykyfkp476cjfnigm1f36kyfaxsm5k7w9an2i3z72xg5v47"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-base64" ,rust-base64-0.13)
                       ("rust-charset" ,rust-charset-0.1)
                       ("rust-quoted-printable" ,rust-quoted-printable-0.4))))
    (home-page "https://github.com/soywod/rfc2047-decoder")
    (synopsis "Simple RFC 2047 MIME Message Header decoder")
    (description "Simple RFC 2047 MIME Message Header decoder")
    (license license:bsd-3)))

(define-public rust-schannel-0.1.17
  (package (inherit rust-schannel-0.1)
    (name "rust-schannel")
    (version "0.1.20")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "schannel" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1qnvajc4wg0gzfj4mmg4a9fd45nps5gyvcj4j9fs4bj68q8p7ml8"))))
    (arguments
     `(#:cargo-inputs
       (("rust-lazy-static" ,rust-lazy-static-1)
        ("rust-windows-sys" ,rust-windows-sys-0.36))
       #:cargo-development-inputs
       (("rust-windows-sys" ,rust-windows-sys-0.36))))))

(define-public rust-scroll-0.11
  (package (inherit rust-scroll-0.10)
    (name "rust-scroll")
    (version "0.11.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "scroll" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1nhrhpzf95pxbcjjy222blwf8rl3adws6vsqax0yzyxsa6snbi84"))))
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-scroll-derive" ,rust-scroll-derive-0.11)
        ("rust-rustc-version" ,rust-rustc-version-0.2))
       #:cargo-development-inputs
       (("rust-byteorder" ,rust-byteorder-1)
        ("rust-rayon" ,rust-rayon-1))))))


(define-public rust-scroll-derive-0.11
  (package (inherit rust-scroll-derive-0.10)
    (name "rust-scroll-derive")
    (version "0.11.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "scroll-derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "03i5qn4jfcl2iwxhfvw9kf48a656ycbf5km99xr1wcnibjnadgdx"))))))

(define-public rust-secret-service-2
  (package
    (name "rust-secret-service")
    (version "2.0.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "secret-service" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "18l0yz9sb062jddcx56qi70d4ry2js3irkgysdgii0w77d15rnp1"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-aes" ,rust-aes-0.7)
                       ("rust-block-modes" ,rust-block-modes-0.8)
                       ("rust-hkdf" ,rust-hkdf-0.11)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-num" ,rust-num-0.4)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-sha2" ,rust-sha2-0.9)
                       ("rust-zbus" ,rust-zbus-1)
                       ("rust-zbus-macros" ,rust-zbus-macros-1)
                       ("rust-zvariant" ,rust-zvariant-2)
                       ("rust-zvariant-derive" ,rust-zvariant-derive-2))))
    (home-page "https://github.com/hwchen/secret-service-rs.git")
    (synopsis "Library to interface with Secret Service API")
    (description "Library to interface with Secret Service API")
    (license (list license:expat license:asl2.0))))

(define-public rust-security-framework-2.6
  (package (inherit rust-security-framework-2)
    (name "rust-security-framework")
    (version "2.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "security-framework" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1p0hgqba3h2glm7mgp5d45l2gpmh28kn5vddlfa032mg5wblzh9d"))))
    (arguments
     `(#:tests? #f                      ;missing files
       #:cargo-inputs
       (("rust-bitflags" ,rust-bitflags-1)
        ("rust-core-foundation" ,rust-core-foundation-0.9.3)
        ("rust-core-foundation-sys" ,rust-core-foundation-sys-0.8.3)
        ("rust-libc" ,rust-libc-0.2)
        ("rust-security-framework-sys" ,rust-security-framework-sys-2.6))
       #:cargo-development-inputs
       (("rust-hex" ,rust-hex-0.4)
        ("rust-tempdir" ,rust-tempdir-0.3))))))

(define-public rust-security-framework-sys-2.6
  (package (inherit rust-security-framework-sys-2)
    (name "rust-security-framework-sys")
    (version "2.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "security-framework-sys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0mn5lm0jip9nm6ydqm6qd9alyiwq15c027777jsbyibs2wxa2q01"))))))

(define-public rust-self-cell-0.10
  (package
    (name "rust-self-cell")
    (version "0.10.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "self-cell" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1by8h3axgpbiph5nbq80z6a41hd4cqlqc66hgnngs57y42j6by8y"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-rustversion" ,rust-rustversion-1))
       #:cargo-development-inputs (("rust-once-cell" ,rust-once-cell-1.14))))
    (home-page "https://github.com/Voultapher/self_cell")
    (synopsis
     "Safe-to-use proc-macro-free self-referential structs in stable Rust.")
    (description
     "Safe-to-use proc-macro-free self-referential structs in stable Rust.")
    (license license:asl2.0)))

(define-public rust-serde-1.0.144
  (package (inherit rust-serde-1)
    (name "rust-serde")
    (version "1.0.144")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0q3qy4cv4jjmwa23nrgrppfxh2g8ahr7fs4iijw47k9xvq87fx0g"))))
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-serde-derive" ,rust-serde-derive-1.0.144))))))
    
(define-public rust-serde-derive-1.0.144
  (package (inherit rust-serde-derive-1)
    (name "rust-serde-derive")
    (version "1.0.144")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde_derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "003sx1ihjcfwj2az357qj7i38b1ji3w8krw35y0h3ldidy0kmvcl"))))))

(define-public rust-serde-json-1.0.85
  (package (inherit rust-serde-json-1)
    (name "rust-serde-json")
    (version "1.0.85")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde_json" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0i2akpn5js5jv0nm5vwrwk3xsm40pbdi82kda3h5r7ggmbijhnp5"))))))

(define-public rust-semver-1.0.13
  (package (inherit rust-semver-1)
    (name "rust-semver")
    (version "1.0.13")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "semver" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "049ppz71ayvgwy1sa87c0dh49gvj6ls8rvnyna5xc0whf0g89xlk"))))))

;; this may be some official guix version
(define-public rust-similar-asserts-1
  (package
    (name "rust-similar-asserts")
    (version "1.4.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "similar-asserts" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "060gzblmwpfcfxx7qh9yh2yaarldrdfkajm306gi4xbb06nl9xmv"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-console" ,rust-console-0.15)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-similar" ,rust-similar-2))
       #:cargo-development-inputs (("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/mitsuhiko/similar-asserts")
    (synopsis "provides assert_eq! like macros with colorized diff output")
    (description "provides assert_eq! like macros with colorized diff output")
    (license license:asl2.0)))

(define-public rust-sketches-ddsketch-0.1
  (package
    (name "rust-sketches-ddsketch")
    (version "0.1.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "sketches-ddsketch" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1vk4fa3adwcx0dqqrcz3vp955wfcaw555gg6w8ib2cygbypfrlh4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-development-inputs (("rust-approx" ,rust-approx-0.5)
                                   ("rust-rand" ,rust-rand-0.7)
                                   ("rust-rand-distr" ,rust-rand-distr-0.2))))
    (home-page "https://github.com/mheffner/rust-sketches-ddsketch")
    (synopsis "A direct port of the Golang DDSketch implementation.
")
    (description
     "This package provides a direct port of the Golang DDSketch implementation.")
    (license license:asl2.0)))

(define-public rust-syn-1.0.99
  (package (inherit rust-syn-1)
    (name "rust-syn")
    (version "1.0.99")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "syn" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "04xba78p559nl737llv7nqcwm723dp6ah5bbp0h5w1amqrpfznsq"))))
    (arguments
     `(#:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1.0.43)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-unicode-ident" ,rust-unicode-ident-1))
       #:cargo-development-inputs (("rust-anyhow" ,rust-anyhow-1)
                                   ("rust-automod" ,rust-automod-1)
                                   ("rust-flate2" ,rust-flate2-1)
                                   ("rust-insta" ,rust-insta-1)
                                   ("rust-rayon" ,rust-rayon-1)
                                   ("rust-ref-cast" ,rust-ref-cast-1)
                                   ("rust-regex" ,rust-regex-1)
                                   ("rust-reqwest" ,rust-reqwest-0.11)
                                   ("rust-syn-test-suite" ,rust-syn-test-suite-0.0.0)
                                   ("rust-tar" ,rust-tar-0.4)
                                   ("rust-termcolor" ,rust-termcolor-1))))))

(define-public rust-syn-test-suite-0.0.0
  (package
    (name "rust-syn-test-suite")
    (version "0.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "syn-test-suite" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "15yz9q7rgxaplv0zbnanzyv1la4gmg47yq5wlkcwv3cck4qlncdm"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/dtolnay/syn")
    (synopsis "Test suite of the syn crate")
    (description "Test suite of the syn crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-tar-0.4.38
  (package (inherit rust-tar-0.4)
    (name "rust-tar")
    (version "0.4.38")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tar" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ikiz14wbfmaaw5mrv93msa8v6n3i595z5kw9p0fdqa40dy80mab"))))))

(define-public rust-target-lexicon-0.12.4
  (package (inherit rust-target-lexicon-0.12)
    (name "rust-target-lexicon")
    (version "0.12.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "target-lexicon" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1hfk4v8gbhczr6jwsy1ja6yg4npkvznym6b7r4fbgjc0fw428960"))))))

(define-public rust-test-log-0.2
  (package
    (name "rust-test-log")
    (version "0.2.11")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "test-log" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "03pmvrg6lc2qgnby9w2fhn1vzqysbl643p7jy14a0s7bz9aciw1q"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))
       #:cargo-development-inputs (("rust-env-logger" ,rust-env-logger-0.9)
                                   ("rust-log" ,rust-log-0.4)
                                   ("rust-tokio" ,rust-tokio-1)
                                   ("rust-tracing" ,rust-tracing-0.1)
                                   ("rust-tracing-futures" ,rust-tracing-futures-0.2)
                                   ("rust-tracing-subscriber" ,rust-tracing-subscriber-0.3))))
    (home-page "https://github.com/d-e-s-o/test-log")
    (synopsis
     "A replacement of the #[test] attribute that initializes logging and/or
tracing infrastructure before running tests.
")
    (description
     "This package provides a replacement of the #[test] attribute that initializes
logging and/or tracing infrastructure before running tests.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-thiserror-1.0.33
  (package (inherit rust-thiserror-1)
    (name "rust-thiserror")
    (version "1.0.33")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "thiserror" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0mwa7kvqp0lzk5bcv53yrna9ln31hyhvfzdc6la6aic7j6d562ix"))))
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-thiserror-impl" ,rust-thiserror-impl-1.0.33))
       #:cargo-development-inputs
       (("rust-anyhow" ,rust-anyhow-1)
        ("rust-ref-cast" ,rust-ref-cast-1)
        ("rust-rustversion" ,rust-rustversion-1)
        ("rust-trybuild" ,rust-trybuild-1))))))

(define-public rust-thiserror-impl-1.0.33
  (package (inherit rust-thiserror-impl-1)
    (name "rust-thiserror-impl")
    (version "1.0.33")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "thiserror-impl" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "028cmrmfb2n5yyvrrypdf8mj4x8y2g17v4gl2sdc85lff07yjlf2"))))))

(define-public rust-textwrap-0.15
  (package (inherit rust-textwrap-0.12)
    (name "rust-textwrap")
    (version "0.15.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "textwrap" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1yw513k61lfiwgqrfvsjw1a5wpvm0azhpjr2kr0jhnq9c56is55i"))))
    (arguments
     `(#:cargo-inputs (("rust-hyphenation" ,rust-hyphenation-0.8)
                       ("rust-smawk" ,rust-smawk-0.3)
                       ("rust-terminal-size" ,rust-terminal-size-0.1)
                       ("rust-unicode-linebreak" ,rust-unicode-linebreak-0.1)
                       ("rust-unicode-width" ,rust-unicode-width-0.1))
       #:cargo-development-inputs (("rust-criterion" ,rust-criterion-0.3)
                                   ("rust-lipsum" ,rust-lipsum-0.8)
                                   ("rust-termion" ,rust-termion-1)
                                   ("rust-unic-emoji-char" ,rust-unic-emoji-char-0.9)
                                   ("rust-version-sync" ,rust-version-sync-0.9))))))

; 0.3.14 needed rustc 1.59
(define-public rust-time-0.3.13
  (package (inherit rust-time-0.3)
    (name "rust-time")
    (version "0.3.13")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "time" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0iga3vqslwxjam1n67njc220b53ki3wkyzq7gwy8nidiljgzyxnv"))))
    (arguments
     `(#:cargo-inputs (("rust-itoa" ,rust-itoa-1)
                       ("rust-js-sys" ,rust-js-sys-0.3)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-num-threads" ,rust-num-threads-0.1)
                       ("rust-quickcheck" ,rust-quickcheck-1)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-time-macros" ,rust-time-macros-0.2.4))
       #:cargo-development-inputs (("rust-criterion" ,rust-criterion-0.3)
                                   ("rust-criterion-cycles-per-byte" ,rust-criterion-cycles-per-byte-0.1)
                                   ("rust-quickcheck-macros" ,rust-quickcheck-macros-1)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-serde" ,rust-serde-1.0.144)
                                   ("rust-serde-json" ,rust-serde-json-1.0.85)
                                   ("rust-serde-test" ,rust-serde-test-1)
                                   ("rust-trybuild" ,rust-trybuild-1))))))

(define-public rust-time-macros-0.2.4
  (package (inherit rust-time-macros-0.2)
    (name "rust-time-macros")
    (version "0.2.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "time-macros" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "14h712p63k121cwi80x8ydn99k703wkcw2ksivd7r0addwd7nra2"))))))

(define-public rust-tracing-0.1.36
  (package (inherit rust-tracing-0.1)
    (name "rust-tracing")
    (version "0.1.36")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tracing" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "01s3qsm1jfz4h4l401lhy8j2yfds45kpb234l447v9k0pmkrbkig"))))
    (arguments
     `(#:cargo-inputs
       (("rust-cfg-if" ,rust-cfg-if-1)
        ("rust-log" ,rust-log-0.4)
        ("rust-pin-project-lite" ,rust-pin-project-lite-0.2.9)
        ("rust-tracing-attributes" ,rust-tracing-attributes-0.1.22)
        ("rust-tracing-core" ,rust-tracing-core-0.1.29))
       #:cargo-development-inputs
       (("rust-criterion" ,rust-criterion-0.3)
        ("rust-futures" ,rust-futures-0.1)
        ("rust-log" ,rust-log-0.4)
        ("rust-tokio" ,rust-tokio-0.2)
        ("rust-wasm-bindgen-test" ,rust-wasm-bindgen-test-0.3))))))

(define-public rust-tracing-attributes-0.1.22
  (package (inherit rust-tracing-attributes-0.1)
    (name "rust-tracing-attributes")
    (version "0.1.22")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tracing-attributes" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1qjf90dvc9jiw78bjzb3iqzrhaybypg8nm0n0zhwi6smmy9miiqi"))))))

(define-public rust-tracing-core-0.1.29
  (package (inherit rust-tracing-core-0.1)
    (name "rust-tracing-core")
    (version "0.1.29")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tracing-core" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1xr2dqar64fj4y43vy0xvaxs6n3xssd3z0jbf408lmbn60qa9vjs"))))
    (arguments
     `(#:cargo-inputs (("rust-once-cell" ,rust-once-cell-1)
                       ("rust-valuable" ,rust-valuable-0.1))))))

(define-public rust-termcolor-1.1.3
  (package (inherit rust-termcolor-1)
    (name "rust-termcolor")
    (version "1.1.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "termcolor" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0mbpflskhnz3jf312k50vn0hqbql8ga2rk0k79pkgchip4q4vcms"))))
    (arguments
     `(#:cargo-inputs (("rust-winapi-util" ,rust-winapi-util-0.1))))))

(define-public rust-uds-windows-1
  (package (inherit rust-uds-windows-0.1)
    (name "rust-uds-windows")
    (version "1.0.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "uds-windows" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "03ckj6vnzvm4r5xd17dxyyqqqcfgs3xqj53hcswykk6k4i1n0rff"))))))

(define-public rust-unic-emoji-char-0.9
  (package
    (name "rust-unic-emoji-char")
    (version "0.9.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "unic-emoji-char" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ka9fr7s6lv0z43r9xphg9injn35pfxf9g9q18ki0wl9d0g241qb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-unic-char-property" ,rust-unic-char-property-0.9)
                       ("rust-unic-char-range" ,rust-unic-char-range-0.9)
                       ("rust-unic-ucd-version" ,rust-unic-ucd-version-0.9))))
    (home-page "https://github.com/open-i18n/rust-unic/")
    (synopsis "UNIC â Unicode Emoji â Emoji Character Properties")
    (description "UNIC â Unicode Emoji â Emoji Character Properties")
    (license (list license:expat license:asl2.0))))

(define-public rust-unicode-ident-1
  (package
    (name "rust-unicode-ident")
    (version "1.0.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "unicode-ident" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1bqswc96ws8l6k7xx56dg521a3l5imi3mhlcz7rsi6a92mxb7xf4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-development-inputs (("rust-criterion" ,rust-criterion-0.3)
                                   ("rust-fst" ,rust-fst-0.4)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-roaring" ,rust-roaring-0.9)
                                   ("rust-ucd-trie" ,rust-ucd-trie-0.1)
                                   ("rust-unicode-xid" ,rust-unicode-xid-0.2))))
    (home-page "https://github.com/dtolnay/unicode-ident")
    (synopsis
     "Determine whether characters have the XID_Start or XID_Continue properties according to Unicode Standard Annex #31")
    (description
     "Determine whether characters have the XID_Start or XID_Continue properties
according to Unicode Standard Annex #31")
    (license #f)))

(define-public rust-uuid-1
  (package (inherit rust-uuid-0.7)
    (name "rust-uuid")
    (version "1.1.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "uuid" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0bwdz7bgigbh4625ga564xxbqy4srhbmzq3nqkz1ypsd67s6jr6x"))))))

(define-public rust-v-htmlescape-0.15
  (package
    (name "rust-v-htmlescape")
    (version "0.15.8")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "v-htmlescape" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "135inp4x7cc32k0hzrymlz1baf0rj0ah5h82nrpa9w0hqpxmg0jf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-buf-min" ,rust-buf-min-0.7))))
    (home-page "https://github.com/botika/v_escape")
    (synopsis "The simd optimized HTML escaping code")
    (description "The simd optimized HTML escaping code")
    (license (list license:expat license:asl2.0))))

(define-public rust-valuable-0.1
  (package
    (name "rust-valuable")
    (version "0.1.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "valuable" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0v9gp3nkjbl30z0fd56d8mx7w1csk86wwjhfjhr400wh9mfpw2w3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-valuable-derive" ,rust-valuable-derive-0.1))
       #:cargo-development-inputs (("rust-criterion" ,rust-criterion-0.3))))
    (home-page "https://github.com/tokio-rs/valuable")
    (synopsis
     "Object-safe value inspection, used to pass un-typed structured data across trait-object boundaries.
")
    (description
     "Object-safe value inspection, used to pass un-typed structured data across
trait-object boundaries.")
    (license license:expat)))

(define-public rust-valuable-derive-0.1
  (package
    (name "rust-valuable-derive")
    (version "0.1.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "valuable-derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0cjvqljzsj891cjzlwv0ihrv4m0n5211a6pr6b7cz42ich66ji4x"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/tokio-rs/valuable")
    (synopsis "Macros for the `valuable` crate.")
    (description "Macros for the `valuable` crate.")
    (license license:expat)))

(define-public rust-whoami-1
  (package (inherit rust-whoami-0.8)
    (name "rust-whoami")
    (version "1.2.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "whoami" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1s355zs8ir1li29cwvzgaqm6jyb51svmhqyx2hqgp8i0bbx5hjsj"))))))

(define-public rust-which-4.2
  (package (inherit rust-which-4)
    (name "rust-which")
    (version "4.2.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "which" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1bi4gklz7qcw19z4d2a4c1wsq083zc2387745rvsidhkc57baksw"))))
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-either" ,rust-either-1)
        ("rust-lazy-static" ,rust-lazy-static-1)
        ("rust-libc" ,rust-libc-0.2.132)
        ("rust-regex" ,rust-regex-1))))))

(define-public rust-windows-sys-0.36
  (package
    (name "rust-windows-sys")
    (version "0.36.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-sys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1lmqangv0zg1l46xiq7rfnqwsx8f8m52mqbgg2mrx7x52rd1a17a"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-windows-aarch64-msvc" ,rust-windows-aarch64-msvc-0.36)
                       ("rust-windows-i686-gnu" ,rust-windows-i686-gnu-0.36)
                       ("rust-windows-i686-msvc" ,rust-windows-i686-msvc-0.36)
                       ("rust-windows-x86-64-gnu" ,rust-windows-x86-64-gnu-0.36)
                       ("rust-windows-x86-64-msvc" ,rust-windows-x86-64-msvc-0.36))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Rust for Windows")
    (description "Rust for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-aarch64-msvc-0.36
  (package
    (name "rust-windows-aarch64-msvc")
    (version "0.36.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-aarch64-msvc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ixaxs2c37ll2smprzh0xq5p238zn8ylzb3lk1zddqmd77yw7f4v"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Code gen support for the windows crate")
    (description "Code gen support for the windows crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-i686-gnu-0.36
  (package
    (name "rust-windows-i686-gnu")
    (version "0.36.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-i686-gnu" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1dm3svxfzamrv6kklyda9c3qylgwn5nwdps6p0kc9x6s077nq3hq"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Code gen support for the windows crate")
    (description "Code gen support for the windows crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-i686-msvc-0.36
  (package
    (name "rust-windows-i686-msvc")
    (version "0.36.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-i686-msvc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "097h2a7wig04wbmpi3rz1akdy4s8gslj5szsx8g2v0dj91qr3rz2"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Code gen support for the windows crate")
    (description "Code gen support for the windows crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-x86-64-gnu-0.36
  (package
    (name "rust-windows-x86-64-gnu")
    (version "0.36.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-x86-64-gnu" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1qfrck3jnihymfrd01s8260d4snql8ks2p8yaabipi3nhwdigkad"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Code gen support for the windows crate")
    (description "Code gen support for the windows crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-x86-64-msvc-0.36
  (package
    (name "rust-windows-x86-64-msvc")
    (version "0.36.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-x86-64-msvc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "103n3xijm5vr7qxr1dps202ckfnv7njjnnfqmchg8gl5ii5cl4f8"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Code gen support for the windows crate")
    (description "Code gen support for the windows crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-xwin-0.2
  (package
    (name "rust-xwin")
    (version "0.2.7")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "xwin" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1p4p4fvf183n90cs66hixqr0bmqxabfbyl1z0i6n9hkcc0ch9p8h"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-anyhow" ,rust-anyhow-1.0.63)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-cab" ,rust-cab-0.4)
                       ("rust-camino" ,rust-camino-1.1)
                       ("rust-clap" ,rust-clap-3.2.19)
                       ("rust-cli-table" ,rust-cli-table-0.4)
                       ("rust-flate2" ,rust-flate2-1)
                       ("rust-indicatif" ,rust-indicatif-0.17)
                       ("rust-msi" ,rust-msi-0.5)
                       ("rust-native-tls" ,rust-native-tls-0.2)
                       ("rust-parking-lot" ,rust-parking-lot-0.12)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-sha2" ,rust-sha2-0.10)
                       ("rust-tempfile" ,rust-tempfile-3)
                       ("rust-tracing" ,rust-tracing-0.1.36)
                       ("rust-tracing-subscriber" ,rust-tracing-subscriber-0.3)
                       ("rust-twox-hash" ,rust-twox-hash-1)
                       ("rust-ureq" ,rust-ureq-2)
                       ("rust-zip" ,rust-zip-0.6))
       #:cargo-development-inputs (("rust-insta" ,rust-insta-1)
                                   ("rust-similar-asserts" ,rust-similar-asserts-1)
                                   ("rust-walkdir" ,rust-walkdir-2))))
    (home-page "https://github.com/Jake-Shadle/xwin")
    (synopsis
     "Allows downloading and repacking the MSVC CRT and Windows SDK for cross compilation")
    (description
     "Allows downloading and repacking the MSVC CRT and Windows SDK for cross
compilation")
    (license (list license:asl2.0 license:expat))))

(define-public rust-zbus-1
  (package
    (name "rust-zbus")
    (version "1.9.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "zbus" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0jgwydwjgk16dyrzdbc1k0dnqj9kv9p3fwcv92a7l9np3hlv5glw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-async-broadcast" ,rust-async-broadcast-0.4)
                       ("rust-async-channel" ,rust-async-channel-1)
                       ("rust-async-executor" ,rust-async-executor-1)
                       ("rust-async-io" ,rust-async-io-1)
                       ("rust-async-lock" ,rust-async-lock-2)
                       ("rust-async-recursion" ,rust-async-recursion-0.3)
                       ("rust-async-task" ,rust-async-task-4)
                       ("rust-async-trait" ,rust-async-trait-0.1)
                       ("rust-byteorder" ,rust-byteorder-1)
                       ("rust-derivative" ,rust-derivative-2)
                       ("rust-dirs" ,rust-dirs-4)
                       ("rust-enumflags2" ,rust-enumflags2-0.6)
                       ("rust-event-listener" ,rust-event-listener-2)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-sink" ,rust-futures-sink-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-hex" ,rust-hex-0.4)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-nix" ,rust-nix-0.22.3)
                       ("rust-once-cell" ,rust-once-cell-1.14)
                       ("rust-ordered-stream" ,rust-ordered-stream-0.0.1)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-xml-rs" ,rust-serde-xml-rs-0.4)
                       ("rust-serde-repr" ,rust-serde-repr-0.1)
                       ("rust-sha1" ,rust-sha1-0.6)
                       ("rust-static-assertions" ,rust-static-assertions-1)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tracing" ,rust-tracing-0.1)
                       ("rust-uds-windows" ,rust-uds-windows-1)
                       ("rust-winapi" ,rust-winapi-0.3)
                       ("rust-zbus-macros" ,rust-zbus-macros-3)
                       ("rust-zbus-names" ,rust-zbus-names-2)
                       ("rust-zvariant" ,rust-zvariant-3))
       #:cargo-development-inputs (("rust-async-std" ,rust-async-std-1)
                                   ("rust-doc-comment" ,rust-doc-comment-0.3)
                                   ("rust-futures-util" ,rust-futures-util-0.3)
                                   ("rust-ntest" ,rust-ntest-0.7)
                                   ("rust-tempfile" ,rust-tempfile-3)
                                   ("rust-test-log" ,rust-test-log-0.2)
                                   ("rust-tokio" ,rust-tokio-1)
                                   ("rust-tracing-subscriber" ,rust-tracing-subscriber-0.3))))
    (home-page "https://gitlab.freedesktop.org/dbus/zbus/")
    (synopsis "API for D-Bus communication")
    (description "API for D-Bus communication")
    (license license:expat)))

(define-public rust-zbus-macros-3
  (package
    (name "rust-zbus-macros")
    (version "3.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "zbus-macros" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0avlsm9b754k4jivzyxs52jjy1smz0qrwaashsqwlidr531p8n7x"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-proc-macro-crate" ,rust-proc-macro-crate-0.1)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-syn" ,rust-syn-1))
       #:cargo-development-inputs (("rust-async-io" ,rust-async-io-1)
                                   ("rust-doc-comment" ,rust-doc-comment-0.3)
                                   ("rust-futures-util" ,rust-futures-util-0.3)
                                   ("rust-rustversion" ,rust-rustversion-1)
                                   ("rust-serde" ,rust-serde-1)
                                   ("rust-trybuild" ,rust-trybuild-1))))
    (home-page "https://gitlab.freedesktop.org/dbus/zbus/")
    (synopsis "proc-macros for zbus")
    (description "proc-macros for zbus")
    (license license:expat)))

(define-public rust-zbus-macros-1
  (package (inherit rust-zbus-macros-3)
    (name "rust-zbus-macros")
    (version "1.9.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "zbus-macros" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "19p0pdwdf52zkaknav0pj5qvgcf52xk8a4p3a4ymxybwhjkmjfgs"))))))

(define-public rust-zbus-names-2
  (package
    (name "rust-zbus-names")
    (version "2.2.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "zbus-names" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1x8axn2jdx3gcq2mxsjixhjfjsq3zp3nv42k1xlra9imibyhi921"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-serde" ,rust-serde-1)
                       ("rust-static-assertions" ,rust-static-assertions-1)
                       ("rust-zvariant" ,rust-zvariant-3))
       #:cargo-development-inputs (("rust-doc-comment" ,rust-doc-comment-0.3))))
    (home-page "https://gitlab.freedesktop.org/dbus/zbus/")
    (synopsis "A collection of D-Bus bus names types")
    (description "This package provides a collection of D-Bus bus names types")
    (license license:expat)))

(define-public rust-zip-0.6
  (package (inherit rust-zip-0.5)
    (name "rust-zip")
    (version "0.6.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "zip" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "138brxnsknbvdh7h5h4rysfpcgvspp3pa177jsscnlmvfg7mn8mz"))))
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-byteorder" ,rust-byteorder-1)
        ("rust-bzip2" ,rust-bzip2-0.4.3)
        ("rust-crossbeam-utils" ,rust-crossbeam-utils-0.8)
        ("rust-crc32fast" ,rust-crc32fast-1.3)
        ("rust-flate2" ,rust-flate2-1)
        ("rust-thiserror" ,rust-thiserror-1)
        ("rust-time" ,rust-time-0.3.13))))))

(define-public rust-zvariant-3
  (package
    (name "rust-zvariant")
    (version "3.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "zvariant" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "04d96999d86pdmp19sklw8xxk8z7iix2dscq7wjimb1fkc26r52a"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-arrayvec" ,rust-arrayvec-0.7)
                       ("rust-byteorder" ,rust-byteorder-1)
                       ("rust-enumflags2" ,rust-enumflags2-0.7)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-bytes" ,rust-serde-bytes-0.11)
                       ("rust-static-assertions" ,rust-static-assertions-1)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-url" ,rust-url-2)
                       ("rust-uuid" ,rust-uuid-1)
                       ("rust-zvariant-derive" ,rust-zvariant-derive-3))
       #:cargo-development-inputs (("rust-criterion" ,rust-criterion-0.3)
                                   ("rust-doc-comment" ,rust-doc-comment-0.3)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-serde-json" ,rust-serde-json-1)
                                   ("rust-serde-repr" ,rust-serde-repr-0.1))))
    (home-page "https://gitlab.freedesktop.org/dbus/zbus/")
    (synopsis "D-Bus & GVariant encoding & decoding")
    (description "D-Bus & GVariant encoding & decoding")
    (license license:expat)))

(define-public rust-zvariant-2
  (package (inherit rust-zvariant-3)
    (name "rust-zvariant")
    (version "2.10.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "zvariant" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0995d59vl8409mk3qrbshqrz5d76dq52szg0x2vqji07y9app356"))))))

(define-public rust-zvariant-derive-3
  (package
    (name "rust-zvariant-derive")
    (version "3.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "zvariant-derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1469g3lb8k2bg4yv40s6ix2jv8iwi8jxp30ykgvvyffnp2pybz18"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-proc-macro-crate" ,rust-proc-macro-crate-1)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))
       #:cargo-development-inputs (("rust-byteorder" ,rust-byteorder-1)
                                   ("rust-doc-comment" ,rust-doc-comment-0.3)
                                   ("rust-enumflags2" ,rust-enumflags2-0.7)
                                   ("rust-serde" ,rust-serde-1)
                                   ("rust-serde-repr" ,rust-serde-repr-0.1))))
    (home-page "https://gitlab.freedesktop.org/dbus/zbus/")
    (synopsis "D-Bus & GVariant encoding & decoding")
    (description "D-Bus & GVariant encoding & decoding")
    (license license:expat)))

(define-public rust-zvariant-derive-2
  (package (inherit rust-zvariant-derive-3)
    (name "rust-zvariant-derive")
    (version "2.10.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "zvariant-derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1s9xk9c4p9vl0j2vr1abqc12mgv500sjc3fnh8ij3d1yb4i5xjp4"))))))
