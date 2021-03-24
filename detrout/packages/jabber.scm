(define-module (detrout packages jabber)
  #:use-module (guix download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (gnu packages)
  #:use-module (gnu packages apr)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages check)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages libidn)
  #:use-module (gnu packages logging)
  #:use-module (gnu packages messaging)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages popt)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages python)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages xml))

  (define-public libcommuni@3.4
    (package
      (name "libcommuni")
      (version "3.4.0")
      (source (origin
                (method url-fetch)
                (uri (string-append
                      "https://github.com/communi/" name "/archive/v"
                      version
                      ".tar.gz"))
                (sha256
                 (base32 "0y9fpx7zsfjjzsh2ajv9x61jx9j6kk7wxjsk82sm132fhamy1bri"))))
      (build-system gnu-build-system)
      (inputs
       `(("pkg-config" ,pkg-config)
         ("autoconf" ,autoconf)
         ("automake" ,automake)
         ("openssl" ,openssl)
         ("qt-4" ,qt-4)))
      (arguments
       `(#:phases
         (modify-phases %standard-phases
           (add-before
               'check 'set-ld-library-path
             (lambda* (#:key inputs #:allow-other-keys)
               (let ((path (string-append (assoc-ref inputs "openssl") "/lib")))
                 (setenv "LD_LIBRARY_PATH" path)
                 #t)))
           (replace
               'configure
             (lambda* (#:key outputs #:allow-other-keys)
               (let* ((root (assoc-ref outputs "out"))
                      (prefix (string-append "PREFIX=" root))
                      (install_libs (string-append "IRC_INSTALL_LIBS=" root "/lib"))
                      (install_headers (string-append "IRC_INSTALL_HEADERS="
                                                      root "/include/Communi"))
                      (install_features (string-append "IRC_INSTALL_FEATURES="
                                                       root "/mkspecs/features"))
                      (install_qml1 (string-append "IRC_INSTALL_IMPORTS="
                                                   root "/imports"))
                      (install_qml2 (string-append "IRC_INSTALL_QML="
                                                   root "/qml"))
                      (lflags (string-append "QMAKE_LFLAGS+=-Wl,-rpath=" root "/lib")))
                 (zero? (system* "qmake" lflags prefix install_libs install_headers
                                 install_features install_qml1 install_qml2 ))))))))

      (synopsis "IRC Library")
      (description "Communi provides convenient classes for
establishing connections to IRC servers, handling incoming messages,
and sending commands.")
      (home-page "https://github.com/communi/libcommuni")
      (license license:bsd-3)))

  (define-public swift-im
    (package
      (name "swift-im")
      (version "2.0+dev6")
      ;; I have no idea where debian grabbed this from
      (source (origin
                (method url-fetch)
                (uri (string-append
                      "http://http.us.debian.org/debian/pool/main/s/swift-im/"
                      name "_" version ".orig.tar.gz"))
                (sha256
                 (base32 "1xwxd5rsdm2na20b3l6qikwx6pc35b2rcshl342whfh9cbpssqh6"))))
      (build-system gnu-build-system)
      (native-inputs
       `(("scons" ,scons)
         ("python" ,python-2)))
      (inputs
       `(("boost" ,boost)
         ("expat" ,expat)
         ("libidn" ,libidn)
         ("openssl" ,openssl)
         ("qt-4" ,qt-4)
         ("libxml2" ,libxml2)))
      (arguments
       `(#:phases
         (modify-phases %standard-phases
           (delete 'configure)
           (add-after 'unpack 'scons-propgate-environment
             (lambda _
               (substitute* "BuildTools/SCons/SConscript.boot"
                 (("^  env = Environment\\(ENV = env_ENV, ") "  env = Environment(ENV=os.environ, "))))
           (replace 'build
             (lambda* (#:key inputs outputs #:allow-other-keys)
               (let ((out (assoc-ref outputs "out"))
                     (boost (assoc-ref inputs "boost"))
                     (expat (assoc-ref inputs "expat"))
                     (libc (assoc-ref inputs "libc"))
                     (libidn (assoc-ref inputs "libidn"))
                     (openssl (assoc-ref inputs "openssl"))
                     (qt (assoc-ref inputs "qt-4"))
                     (libxml2 (assoc-ref inputs "libxml2")))
                 (zero? (system* "scons" "--debug=presub"
                                 "swiften_dll=1"
                                 "Swiften"
                                 (string-append "SWIFTEN_INSTALLDIR=" out)
                                 out)))))
           (delete 'check)
           (delete 'install))))
      (home-page "")
      (synopsis "synopsis")
      (description "description")
      (license license:gpl3+)))


  (define-public log4cxx
    (package
      (name "log4cxx")
      (version "0.10.0")
      (source (origin
                (method url-fetch)
                (uri (string-append "mirror://apache/logging/log4cxx/"
                                    version "/apache-" name "-" version ".tar.gz"))
                (sha256
                 (base32 "130cjafck1jlqv92mxbn47yhxd2ccwwnprk605c6lmm941i3kq0d"))
                (patches (search-patches "log4cxx-gcc-4.3.patch"
                                         "log4cxx-gcc-4.4.patch"
                                         "log4cxx-bugfix-LOGCXX-298.patch"
                                         "log4cxx-bugfix-LOGCXX-280.patch"
                                         "log4cxx-bugfix-LOGCXX-284.patch"
                                         "log4cxx-bugfix-LOGCXX-249.patch"
                                         ;;"log4cxx-bugfix-LOGCXX-385.patch"
                                         "log4cxx-bugfix-LOGCXX-322.patch"
                                         "log4cxx-bugfix-LOGCXX-365.patch"
                                         ))))
      (build-system gnu-build-system)
      (inputs
       `(("apr" ,apr)
         ("apr-util" ,apr-util)
         ("zip" ,zip)))
      (arguments `(#:tests? #f))
      (home-page "https://logging.apache.org/log4cxx/index.html")
      (synopsis "Logging library for C++")
      (description "Log4cxx is the C++ port of log4j, a logging
framework for JAVA.  Log4cxx attempts to mimic log4j usage as much as
the language will allow and to be compatible with log4j configuration
and output formats.")
      (license license:asl2.0)))

  (define-public spectrum2
    (package
      (name "spectrum2")
      (version "2.0.3")
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://github.com/hanzz/spectrum2.git")
                      (commit "2.0.3")))
                (file-name (string-append name "-" version "-checkout"))
                (sha256 (base32 "0nn8506k6qa7g13wjn7bqla4zhdyb56hlz19yn1aryfk52nh6b31"))
                (patches (search-patches "disable-utf8-test.patch"
                                         "etc-install.patch"))))
      (build-system cmake-build-system)
      (arguments
       `(#:configure-flags `("-DENABLE_TESTS=ON")))
      (native-inputs
       `(("pkg-config" ,pkg-config)))
      (inputs
       `(("boost" ,boost)
         ("libcommuni" ,libcommuni@3.4)
         ("cppunit" ,cppunit)
         ("curl" ,curl)
         ("expat" ,expat)
         ("glib" ,glib)
         ("libev" ,libev)
         ("libidn" ,libidn)
         ("log4cxx" ,log4cxx)
         ("openssl" ,openssl)
         ("pidgin" ,pidgin)
         ("popt" ,popt)
         ("protobuf" ,protobuf)
         ("qt-4" ,qt-4)
         ("sqlite" ,sqlite)
         ("swift-im" ,swift-im)
         ("libxml2" ,libxml2)))
      (home-page "http://spectrum.im/")
      (synopsis "Gateway between XMPP and other text services")
      (description "Spectrum is an XMPP server component that connects
to other services such as: libpidgin supported IM networks; Twitter;
or even the Interactive fiction interpreter Frotz")
      (license license:bsd-3)))