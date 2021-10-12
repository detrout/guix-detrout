(define-module (detrout packages mail)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages dbm)
  #:use-module (gnu packages mail)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages xml)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match))



(define-public dc-exim
  (package
    (inherit exim)
    (name "dc-exim")
    (arguments
     '(#:phases
       (modify-phases %standard-phases
         (replace 'configure
           ;; We'd use #:make-flags but the top-level Makefile calls others
           ;; recursively, so just set all variables this way.
           (lambda* (#:key outputs inputs #:allow-other-keys)
             (substitute* '("Makefile" "OS/Makefile-Default")
               (("(RM_COMMAND=).*" all var)
                (string-append var "rm\n")))
             (copy-file "src/EDITME" "Local/Makefile")
             (copy-file "exim_monitor/EDITME" "Local/eximon.conf")
             (let ((out (assoc-ref outputs "out"))
                   (gzip (assoc-ref inputs "gzip"))
                   (bzip2 (assoc-ref inputs "bzip2"))
                   (xz (assoc-ref inputs "xz")))
               (substitute* '("Local/Makefile")
                 (("(BIN_DIRECTORY=).*" all var)
                  (string-append var out "/bin\n"))
                 (("(CONFIGURE_FILE=).*" all var)
                  (string-append var out "/etc/exim.conf\n"))
                 (("(EXIM_USER=).*" all var)
                  (string-append var "nobody\n"))
                 (("(FIXED_NEVER_USERS=).*" all var)
                  (string-append var "\n")) ; XXX no root in build environment
                 (("(COMPRESS_COMMAND=).*" all var)
                  (string-append var gzip "/bin/gzip\n"))
                 (("(ZCAT_COMMAND=).*" all var)
                  (string-append var gzip "/bin/zcat\n"))
                 (("# (USE_GNUTLS(|_PC)=.*)" all line)
                  (string-append line "\n"))
                 (("# (AUTH_CRAM_MD5=yes)" all line) line)
                 (("# (AUTH_DOVECOT=yes)" all line) line)
                 (("# (AUTH_EXTERNAL=yes)" all line) line)
                 (("# (AUTH_PLAINTEXT=yes)" all line) line)
                 (("# (AUTH_SPA=yes)" all line) line)
                 (("# (AUTH_TLS=yes)" all line) line)
                 (("# (LOG_FILE_PATH=/var/log/)exim_%slog" all var) (string-append var "exim/%slog")))
               ;; This file has hard-coded relative file names for tools despite
               ;; the zcat configuration above.
               (substitute* '("src/exigrep.src")
                 (("'zcat'") (string-append "'" gzip "/bin/zcat'"))
                 (("'bzcat'") (string-append "'" bzip2 "/bin/bzcat'"))
                 (("'xzcat'") (string-append "'" xz "/bin/xzcat'"))
                 (("'lzma'") (string-append "'" xz "/bin/lzma'"))))
             #t))
         (add-before 'build 'fix-sh-paths
           (lambda* (#:key inputs #:allow-other-keys)
             (substitute* '("scripts/lookups-Makefile" "scripts/reversion")
               (("SHELL=/bin/sh") "SHELL=sh"))
             (substitute* '("scripts/Configure-config.h")
               (("\\| /bin/sh") "| sh"))
             (let ((bash (assoc-ref inputs "bash")))
               (substitute* '("scripts/Configure-eximon")
                 (("#!/bin/sh") (string-append "#!" bash "/bin/sh"))))
             #t))
         (add-before 'build 'build-reproducibly
           (lambda _
             ;; The ‘compilation number’ is incremented for every build from the
             ;; same source tree.  It appears to vary over different (parallel?)
             ;; builds.  Make it a ‘constant number’ instead.
             (substitute* "src/version.c"
               (("#include \"cnumber.h\"") "1")))))
       #:make-flags
       (list "CC=gcc"
             "INSTALL_ARG=-no_chown")
       ;; No 'check' target.  There is a test suite in test/, which assumes that
       ;; certain build options were (not) used and that it can freely ‘sudo’.
       #:tests? #f))))
