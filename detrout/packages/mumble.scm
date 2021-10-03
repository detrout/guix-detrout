(define-module (detrout packages mumble)
  #:use-module (guix download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system cargo)
  #:use-module (guix store)
  #:use-module (gnu packages)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-gtk)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages tls)
  )


(define-public rust-input-buffer-0.4
  (package
    (inherit rust-input-buffer-0.3)
    (name "rust-input-buffer")
    (version "0.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "input_buffer" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "04yl6pdjawq5grl946hn3imfs2cx0r0vrc0jvdyim3s4bybnfygr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-bytes" ,rust-bytes-1))))))


(define-public rust-tungstenite-0.12
  (package
    (name "rust-tungstenite")
    (version "0.12.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tungstenite" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
           ;; v15 hash "1db5j4792b197v95y7hr8j9n0qn75rdc1xcd19mjfbmxi9axicm0"
           "093wzyi1405j9r4qdvrpkzmpnh4z18jr67amkbx7426px2bq5nla"))))
    (build-system cargo-build-system)
    (arguments
      `(#:cargo-inputs
        (("rust-base64" ,rust-base64-0.13)
         ("rust-byteorder" ,rust-byteorder-1)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-http" ,rust-http-0.2)
         ("rust-httparse" ,rust-httparse-1)
         ("rust-input-buffer" ,rust-input-buffer-0.4)
         ("rust-log" ,rust-log-0.4)
         ("rust-native-tls" ,rust-native-tls-0.2)
         ("rust-rand" ,rust-rand-0.8)
         ;;("rust-rustls" ,rust-rustls-0.19)
         ;;("rust-rustls-native-certs" ,rust-rustls-native-certs-0.5)
         ("rust-sha-1" ,rust-sha-1-0.9)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-url" ,rust-url-2)
         ("rust-utf-8" ,rust-utf-8-0.7)
         ("rust-webpki" ,rust-webpki-0.21))
        #:cargo-development-inputs
        (("rust-criterion" ,rust-criterion-0.3)
         ("rust-env-logger" ,rust-env-logger-0.8)
         ("rust-net2" ,rust-net2-0.2))))
    (native-inputs
     `(("pkg-config" ,pkg-config)
       ("openssl" ,openssl-1.0)))
    (home-page
      "https://github.com/snapview/tungstenite-rs")
    (synopsis
      "Lightweight stream-based WebSocket implementation")
    (description
      "Lightweight stream-based WebSocket implementation")
    (license (list license:expat license:asl2.0))))

(define-public rust-tokio-tungstenite-0.13
  (package
    (name "rust-tokio-tungstenite")
    (version "0.13.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tokio-tungstenite" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
           ;; 15 "1n6b8qgjgnxl5g1fwmsfcgmshpv814yhqja56nc9h75gbkwf67ai"
           "06w65px7rd6jn6h0qs1djia8xnhgi5hbrv0p23m7gl5ry5sz99g1" ))))
    (build-system cargo-build-system)
    (arguments
      `(#:cargo-inputs
        (("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-log" ,rust-log-0.4)
         ("rust-native-tls" ,rust-native-tls-0.2)
         ("rust-pin-project" ,rust-pin-project-1)
         ("rust-rustls" ,rust-rustls-0.19)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-native-tls"
          ,rust-tokio-native-tls-0.3)
         ("rust-tokio-rustls" ,rust-tokio-rustls-0.22)
         ("rust-tungstenite" ,rust-tungstenite-0.12)
         ("rust-webpki" ,rust-webpki-0.21)
         ("rust-webpki-roots" ,rust-webpki-roots-0.21))
        #:cargo-development-inputs
        (("rust-env-logger" ,rust-env-logger-0.7)
         ("rust-futures-channel"
          ,rust-futures-channel-0.3)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-url" ,rust-url-2))))
    (home-page
      "https://github.com/snapview/tokio-tungstenite")
    (synopsis
      "Tokio binding for Tungstenite, the Lightweight stream-based WebSocket implementation")
    (description
      "Tokio binding for Tungstenite, the Lightweight stream-based WebSocket implementation")
    (license license:expat)))

(define-public rust-argparse-0.2
  (package
    (name "rust-argparse")
    (version "0.2.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "argparse" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0iqy2jkifwq0azrrh26qjssp7sknjylycq35jkalzb744xcbz3iz"))))
    (build-system cargo-build-system)
    (home-page
      "http://github.com/tailhook/rust-argparse")
    (synopsis
      "Powerful command-line argument parsing library")
    (description
      "Powerful command-line argument parsing library")
    (license license:expat)))

(define-public rust-protobuf-codegen-2
  (package
    (name "rust-protobuf-codegen")
    (version "2.25.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "protobuf-codegen" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0v02fl46p44xj5y1d6hn970f00rvlyh84v8vgwgdx9nsvbh8raab"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-protobuf" ,rust-protobuf-2))))
    (home-page
      "https://github.com/stepancheg/rust-protobuf/")
    (synopsis
      "Code generator for rust-protobuf.

Includes a library and `protoc-gen-rust` binary.

See `protoc-rust` and `protobuf-codegen-pure` crates.
")
    (description
      "Code generator for rust-protobuf.

Includes a library and `protoc-gen-rust` binary.

See `protoc-rust` and `protobuf-codegen-pure` crates.
")
    (license license:expat)))

(define-public rust-protobuf-codegen-pure-2
  (package
    (name "rust-protobuf-codegen-pure")
    (version "2.25.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "protobuf-codegen-pure" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1dzj4kcgbj5w2m6cndfbjqsbk9rwbbsrlfbcl2a5f37d2riv3fm2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-protobuf" ,rust-protobuf-2)
         ("rust-protobuf-codegen"
          ,rust-protobuf-codegen-2))))
    (home-page
      "https://github.com/stepancheg/rust-protobuf/tree/master/protobuf-codegen-pure/")
    (synopsis
      "Pure-rust codegen for protobuf using protobuf-parser crate

WIP
")
    (description
      "Pure-rust codegen for protobuf using protobuf-parser crate

WIP
")
    (license license:expat)))

(define-public rust-protobuf-2
  (package
    (name "rust-protobuf")
    (version "2.25.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "protobuf" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0fn6k8vhxknsc6zk6frbrvky4vkhpl48mkjzjgnmqdf9y989s4i3"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytes" ,rust-bytes-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-derive" ,rust-serde-derive-1))))
    (home-page
      "https://github.com/stepancheg/rust-protobuf/")
    (synopsis
      "Rust implementation of Google protocol buffers
")
    (description
      "Rust implementation of Google protocol buffers
")
    (license license:expat)))

(define-public rust-mumble-protocol-0.4
  (package
    (name "rust-mumble-protocol")
    (version "0.4.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "mumble-protocol" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0q3iqzrzrpr3p9jsfrzzg5wndxna96prcl4268y8bsf6cdphjwa0"))))
    (build-system cargo-build-system)
    (arguments
      `(#:cargo-inputs
        (("rust-byteorder" ,rust-byteorder-1)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-openssl" ,rust-openssl-0.10)
         ("rust-protobuf" ,rust-protobuf-2)
         ("rust-protobuf-codegen-pure"
          ,rust-protobuf-codegen-pure-2)
         ("rust-tokio-util" ,rust-tokio-util-0.6))
        #:cargo-development-inputs
        (("rust-argparse" ,rust-argparse-0.2)
         ("rust-futures" ,rust-futures-0.3)
         ("rust-native-tls" ,rust-native-tls-0.2)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-native-tls"
          ,rust-tokio-native-tls-0.3)
         ("rust-tokio-util" ,rust-tokio-util-0.6))))
    (home-page
      "https://github.com/johni0702/rust-mumble-protocol")
    (synopsis
      "Rust implementation of the Mumble protocol")
    (description
      "Rust implementation of the Mumble protocol")
    (license (list license:expat license:asl2.0))))

(define-public rust-handy-async-0.2
  (package
    (name "rust-handy-async")
    (version "0.2.13")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "handy-async" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0ckjpr2ca2mw2dfkwbx4k97y6gpijnl5ibd77wxrnfyx6ia5qp8n"))))
    (build-system cargo-build-system)
    (arguments
      `(#:cargo-inputs
        (("rust-byteorder" ,rust-byteorder-1)
         ("rust-futures" ,rust-futures-0.1))))
    (home-page "https://github.com/sile/handy_async")
    (synopsis
      "A handy library for describing asynchronous code declaratively")
    (description
      "This package provides a handy library for describing asynchronous code declaratively")
    (license license:expat)))

(define-public rust-splay-tree-0.2
  (package
    (name "rust-splay-tree")
    (version "0.2.10")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "splay-tree" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1hgcjpqgfjhz35mdi62dns0lgag105painfbaalgga60jc6yx79h"))))
    (build-system cargo-build-system)
    (arguments
      `(#:cargo-inputs
        (("rust-serde" ,rust-serde-1))
        #:cargo-development-inputs
        (("rust-rand" ,rust-rand-0.4)
         ("rust-serde-json" ,rust-serde-json-1))))
    (home-page "https://github.com/sile/splay_tree")
    (synopsis
      "Splay Tree based Data Structures (map, set, heap)")
    (description
      "Splay Tree based Data Structures (map, set, heap)")
    (license license:expat)))

(define-public rust-trackable-0.1
  (package
    (name "rust-trackable")
    (version "0.1.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "trackable" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0nm2wcmlib0z88xfwp66j4ikfxzainhssmby600m62i4fq4gvpk5"))))
    (build-system cargo-build-system)
    (arguments
      `(#:cargo-development-inputs
        ("rust-rand" ,rust-rand-0.3)))
    (home-page "https://github.com/sile/trackable")
    (synopsis
      "This library provides a way to track objects manually as an alternative to mechanisms like backtracing")
    (description
      "This library provides a way to track objects manually as an alternative to mechanisms like backtracing")
    (license license:expat)))


(define-public rust-rtp-0.1
  (package
    (name "rust-rtp")
    (version "0.1.0")
    (source
     (origin
;;       (method url-fetch)
;;       (uri (string-append "file:///home/diane/src/mumble/rust-rtp-" version ".tar.gz"))
;;       (file-name
;;        (string-append name "-" version ".tar.gz"))
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Johni0702/rtp")
             (commit "5ac992825514a7e8596fec0777686970bc541290")))
       (file-name (git-file-name name version))
       (sha256
        (base32
;;         "0gvncywvlanffpv849qncjfyrr7hqrs1wr6a0g54pz1vp4vr6qjj"
         "0bynfnvbza9q1r87pvbll0iwpm3d8nw8vsdkh23j9h2c757giscg"
         ))))
    (build-system cargo-build-system)
    (arguments
     `(#:rust ,rust-1.52
       #:cargo-inputs
       (("rust-trackable"  ,rust-trackable-0.1)
        ("rust-handy-async" ,rust-handy-async-0.2)
        ("rust-rust-crypto" ,rust-rust-crypto-0.2)
        ("rust-num" ,rust-num-0.1)
        ("rust-splay-tree" ,rust-splay-tree-0.2))
       #:cargo-development-inputs
       (("rust-clap" ,rust-clap-2)
        ("rust-fibers" ,rust-fibers-0.1)
        ("rust-futures" ,rust-futures-0.1))))
    (home-page "https://github.com/Johni0702/rtp")
    (synopsis "A Rust implementation of RTP and profiles derived from it.")
    (description
     "A Rust implementation of RTP and profiles derived from it.")
    (license license:expat)))

(define-public rust-nbchan-0.1
  (package
    (name "rust-nbchan")
    (version "0.1.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "nbchan" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0q4pgwm8vvz857zc331dmgg8lf2avjrq4ix7y9lir52fvcgddcbj"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "https://github.com/sile/nbchan")
    (synopsis
      "Highly optimized non-blocking communication channels")
    (description
      "Highly optimized non-blocking communication channels")
    (license license:expat)))

(define-public rust-fibers-0.1
  (package
    (name "rust-fibers")
    (version "0.1.13")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "fibers" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1rs61dd1q0a5fq25i2zinry8blzxqjs94y4hi8p3vnkygmrpvsfc"))))
    (build-system cargo-build-system)
    (arguments
      `(#:cargo-inputs
        (("rust-futures" ,rust-futures-0.1)
         ("rust-mio" ,rust-mio-0.6)
         ("rust-nbchan" ,rust-nbchan-0.1)
         ("rust-num-cpus" ,rust-num-cpus-1)
         ("rust-splay-tree" ,rust-splay-tree-0.2))
        #:cargo-development-inputs
        (("rust-clap" ,rust-clap-2)
         ("rust-handy-async" ,rust-handy-async-0.2)
         ("rust-httparse" ,rust-httparse-1))))
    (home-page "https://github.com/dwango/fibers-rs")
    (synopsis
      "A Rust library to execute a number of lightweight asynchronous tasks (a.k.a, fibers) based on futures and mio")
    (description
      "This package provides a Rust library to execute a number of lightweight asynchronous tasks (a.k.a, fibers) based on futures and mio")
    (license license:expat)))

(define-public rust-webrtc-sdp-0.3
  (package
    (name "rust-webrtc-sdp")
    (version "0.3.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "webrtc-sdp" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1n80lyak8jhz1brlvffzssnnhr0l6fmqn661wxz74kd9cgs6znwq"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-log" ,rust-log-0.4)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-derive" ,rust-serde-derive-1)
         ("rust-url" ,rust-url-2))))
    (home-page
      "https://github.com/mozilla/webrtc-sdp")
    (synopsis
      "This create parses strings in the format of the Session Description Protocol according to RFC4566. It specifically supports the subset of features required to support WebRTC according to the JSEP draft.")
    (description
      "This create parses strings in the format of the Session Description Protocol according to RFC4566.  It specifically supports the subset of features required to support WebRTC according to the JSEP draft.")
    (license license:mpl2.0)))

(define-public rust-bindgen-0.56
  (package
    (name "rust-bindgen")
    (version "0.56.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "bindgen" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0fajmgk2064ca1z9iq1jjkji63qwwz38z3d67kv6xdy0xgdpk8rd"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-1)
         ("rust-cexpr" ,rust-cexpr-0.4)
         ("rust-clang-sys" ,rust-clang-sys-1)
         ("rust-clap" ,rust-clap-2)
         ("rust-env-logger" ,rust-env-logger-0.8)
         ("rust-lazy-static" ,rust-lazy-static-1)
         ("rust-lazycell" ,rust-lazycell-1)
         ("rust-log" ,rust-log-0.4)
         ("rust-peeking-take-while"
          ,rust-peeking-take-while-0.1)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-regex" ,rust-regex-1)
         ("rust-rustc-hash" ,rust-rustc-hash-1)
         ("rust-shlex" ,rust-shlex-0.1)
         ("rust-which" ,rust-which-3))))
    (home-page
      "https://rust-lang.github.io/rust-bindgen/")
    (synopsis
      "Automatically generates Rust FFI bindings to C and C++ libraries.")
    (description
      "Automatically generates Rust FFI bindings to C and C++ libraries.")
    (license license:bsd-3)))

(define-public rust-libnice-sys-0.4
  (package
    (name "rust-libnice-sys")
    (version "0.4.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "libnice-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0yb5d05vbx86bbhqy5zdwbasqk1b8khk2d4sgfglnzms42195yh7"))))
    (build-system cargo-build-system)
    (arguments
      `(#:cargo-inputs
        (("rust-bindgen" ,rust-bindgen-0.56)
         ("rust-gio-sys" ,rust-gio-sys-0.10)
         ("rust-glib-sys" ,rust-glib-sys-0.10)
         ("rust-gobject-sys" ,rust-gobject-sys-0.10)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-pkg-config" ,rust-pkg-config-0.3))))
    (home-page
      "https://github.com/johni0702/rust-libnice-sys")
    (synopsis
      "Rust FFI bindings to libnice, automatically generated with bindgen.")
    (description
      "Rust FFI bindings to libnice, automatically generated with bindgen.")
    (license (list license:lgpl2.1 license:mpl1.1))))

(define-public rust-libnice-0.3
  (package
    (name "rust-libnice")
    (version "0.3.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "libnice" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0mb9yyihnz801py0rvcvnyz2qik2ji7cq0kf913ikq488zpzj76i"))))
    (build-system cargo-build-system)
    (arguments
      `(#:cargo-inputs
        (("rust-futures" ,rust-futures-0.3)
         ("rust-glib" ,rust-glib-0.10)
         ("rust-glib-sys" ,rust-glib-sys-0.10)
         ("rust-gobject-sys" ,rust-gobject-sys-0.10)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-libnice-sys" ,rust-libnice-sys-0.4)
         ("rust-webrtc-sdp" ,rust-webrtc-sdp-0.3))
        #:cargo-development-inputs
        (("rust-tokio" ,rust-tokio-1))))
    (home-page
      "https://github.com/johni0702/rust-libnice")
    (synopsis
      "Safe, high-level Rust bindings to libnice.")
    (description
      "Safe, high-level Rust bindings to libnice.")
    (license (list license:lgpl2.1 license:mpl1.1))))

(define-public mumble-web-proxy
  (package
    (name "mumble-web-proxy")
    (version "0.1.1")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "file:///home/diane/src/mumble/mumble-web-proxy-" version ".tar.gz"))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "05p9q355m9wz3srj26dhavjw3di2ksahmw55vjhnch4ag8yj16r7"))))
;;         (method git-fetch)
;;         (uri (git-reference
;;               (url "https://github.com/Johni0702/mumble-web-proxy")
;;               (commit version)))
;;         (file-name (git-file-name name version))
;;         (sha256
;;          (base32
;;           "0l194xida852088l8gv7v2ygjxif46fhzp18dvv19i7wssgq8jkf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:rust ,rust-1.52
       #:cargo-inputs
       (("rust-argparse" ,rust-argparse-0.2)
        ("rust-bytes" ,rust-bytes-1)
        ("rust-byteorder" ,rust-byteorder-1)
        ("rust-futures" ,rust-futures-0.3)
        ("rust-toml" ,rust-toml-0.5)
        ("rust-serde" ,rust-serde-1)
        ("rust-tokio" ,rust-tokio-1)
        ("rust-tokio-util" ,rust-tokio-util-0.6)
        ("rust-tokio-native-tls" ,rust-tokio-native-tls-0.3)
        ("rust-native-tls" ,rust-native-tls-0.2)
        ("rust-mumble-protocol" ,rust-mumble-protocol-0.4)
        ("rust-tokio-tungstenite" ,rust-tokio-tungstenite-0.13) ;; should be 0.13
        ("rust-tungstenite" ,rust-tungstenite-0.12)
        ("rust-http", rust-http-0.2)
        ("rust-rtp" ,rust-rtp-0.1)
        ("rust-libnice" ,rust-libnice-0.3)
        ("rust-webrtc-sdp" ,rust-webrtc-sdp-0.3)
        ("rust-openssl" ,rust-openssl-0.10)
        ;; Inputs for rtp
        ("rust-trackable"  ,rust-trackable-1)
        ("rust-handy-async" ,rust-handy-async-0.2)
        ("rust-rust-crypto" ,rust-rust-crypto-0.2)
        ("rust-num" ,rust-num-0.1)
        ("rust-splay-tree" ,rust-splay-tree-0.2))
       #:cargo-development-inputs
       (("rust-clap" ,rust-clap-2)
        ("rust-fibers" ,rust-fibers-0.1)
        ("rust-futures" ,rust-futures-0.1))))
;;        #:phases
;;        (modify-phases %standard-phases
;;          (add-after 'unpack 'fix-version-requirements
;;            (lambda _
;;              (let ((rtp-path (package-derivation rust-rtp-0.1)))
;;                (display "rtp-path:" rust-rtp-path)
;;                (substitute* "Cargo.toml"
;;                  (("git.*features" )
;;                   (string-append "path = \"" rust-rtp-path "\", features"))))
;;              ;;(string-append "version = \"0.1.0\", features"))) ;;(package-version rust-rtp-0.1)
;;              #t)))))
    (home-page "https://github.com/Johni0702/mumble-web-proxy")
    (synopsis "a Mumble to WebSocket+WebRTC proxy.")
    (description
     "mumble-web-proxy is a Mumble to WebSocket+WebRTC proxy.

The Mumble protocol uses TCP for control and UDP for voice. This proxy
bridges those to WebSocket for control and WebRTC for voice.

While not limited to, its primary use-case is allowing mumble-web to
connect to vanilla Mumble 1.2/1.3 servers.

Note that it requires an extension to the Mumble protocol which has
not yet been stabilized and as such may change at any time, so make
sure to keep mumble-web and mumble-web-proxy in sync.")
    (license license:agpl3+)))
