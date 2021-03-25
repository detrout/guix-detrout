;;; Copyright © 2021 Diane Trout <diane@ghic.org>
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

(define-module (detrout packages emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix build-system emacs)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (gnu packages emacs-xyz))

(define-public emacs-magit-popup
  (package
   (name "emacs-magit-popup")
   (version "2.13.3")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/magit/magit-popup")
           (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32 "0znp6gx6vpcsybg774ab06mdgxb7sfk3gki1yp2qhkanav13i6q1"))))
   (build-system emacs-build-system)
   (propagated-inputs
    `(("emacs-dash" ,emacs-dash)))
   (home-page "https://github.com/magit/magit-popup")
   (synopsis "Provides a generic interface for toggling switches and setting options")
   (description
    "This package implements a generic interface for toggling switches
and setting options and then invoking an Emacs command that does
something with these arguments.  Usually the command calls an external
process with the specified arguments.

This package has been superseded by Transient.  No new features will be
added but bugs will be fixed.")
   (license license:gpl3+)))

(define-public emacs-snakemake-mode
  (package
   (name "emacs-snakemake-mode")
   (version "1.8.0")
   (source
    (origin
     (method url-fetch)
     (uri (string-append
           "https://git.kyleam.com/snakemake-mode/snapshot/snakemake-mode-"
           version
           ".tar.gz"))
     (sha256
      (base32 "0syzj0pgaia7w4maxdk62mvjw8k4ifr2aaxr7yyza869vp7zn0mp"))))
   (build-system emacs-build-system)
   (inputs
    `(("emacs-magit-popup" ,emacs-magit-popup)))
   (home-page "https://git.kyleam.com/snakemake-mode/about/")
   (synopsis "Emacs support for Snakemake")
   (description
    "This package contains two Emacs libraries for Snakemake [^1].
  * snakemake-mode.el provides a major mode for editing Snakemake
    files.
  * snakemake.el defines a popup interface for calling Snakemake.")
   (license license:gpl3+)))
