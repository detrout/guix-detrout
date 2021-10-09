(define-module (detrout services exim)
  #:use-module (gnu packages mail)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services mail)
  #:use-module (gnu services shepherd)
  #:use-module (gnu system shadow)
  #:use-module (guix gexp)
  #:use-module (guix records)
  #:use-module (ice-9 format)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-9))

(define dc-package-version "4.94.2-7")

(define-record-type* <dc-exim-config> dc-exim-config
  make-dc-exim-config
  dc-exim-config?
  (configtype       dc-exim-configtype       (default 'local))
  (hostname         dc-exim-hostname         (default "localhost"))
  (other-hostnames  dc-exim-other-hostnames  (default '()))
  (local-interfaces dc-exim-local-interfaces (default '(">;" "127.0.0.1" "::1")))
  (readhost         dc-exim-readhost         (default #f))
  (relay-domains    dc-exim-relay-domains    (default '()))
  (minimaldns       dc-exim-minimaldns       (default #f))
  (relay-nets       dc-exim-relay-nets       (default '()))
  (smarthost        dc-exim-smarthost        (default #f))
  (hide-mailname    dc-exim-hide-mailname    (default #f))
  (localdelivery    dc-exim-localdelivery    (default 'mail_spool))
  (package          dc-exim-package          (default exim))
  )

(define (dc-exim-config-format-list elements)
  (format #f "<; ~{~a~^;: ~}" elements))

(define (dc-exim-config-format-bool value)
  (cond (value 1)
        (else 0)))

(define (main-local-paths port config)
  (format port "######################################################################
#                    MAIN CONFIGURATION SETTINGS                     #
######################################################################

# Just for reference and scripts.
exim_path = ~a

# Macro defining the main configuration directory.
# We do not use absolute paths.
.ifndef CONFDIR
CONFDIR = $~
.endif

" (file-append package "bin/exim")
  (file-append package "etc")))


(define (main-local-macros port config)
  "Locally defined macros (at least on Debian)"
  (format port "######################################################################
#  localmacros
#
######################################################################

MAIN_TLS_ENABLE = true
MAIN_TLS_CERTIFICATE=/etc/letsencrypt/live/~a/fullchain.pem
MAIN_TLS_PRIVATEKEY=/etc/letsencrypt/live/~a/privkey.pem
CHECK_DATA_VERIFY_HEADER_SYNTAX=true
CHECK_DATA_VERIFY_HEADER_SENDER=true
CHECK_RCPT_DOMAIN_DNSBLS = dbl.spamhaus.org/$sender_address_domain
CHECK_RCPT_IP_DNSBLS = zen.spamhaus.org
CHECK_RCPT_REVERSE_DNS=true
CHECK_RCPT_SPF=true
CHECK_RCPT_VERIFY_SENDER=true
#CHECK_RCPT_LOCAL_ACL_FILE=$CONFIDIR/acl.local
IGNORE_SMTP_LINE_LENGTH_LIMIT=true
" (dc-exim-hostname config)))


(define (main-exim-config-listmacrosdef port config)
  (format port "######################################################################
#      Runtime configuration file for Exim 4 (Debian Packaging)      #
######################################################################

# debconf-driven macro definitions get inserted after this line
.ifndef MAIN_LOCAL_INTERFACES
MAIN_LOCAL_INTERFACES=~a
.endif
.ifndef DC_minimaldns
DC_minimaldns=~d
.endif
.ifndef MAIN_HARDCODE_PRIMARY_HOSTNAME
MAIN_HARDCODE_PRIMARY_HOSTNAME=~a
.endif
.ifndef HIDE_MAILNAME
HIDE_MAILNAME=~d
.endif
.ifndef MAIN_PACKAGE_VERSION
MAIN_PACKAGE_VERSION=~a
.endif
.ifndef MAIN_LOCAL_DOMAINS
MAIN_LOCAL_DOMAINS=@:localhost:~a
.endif
.ifndef MAIN_RELAY_TO_DOMAINS
MAIN_RELAY_TO_DOMAINS=~a
.endif
.ifndef ETC_MAILNAME
ETC_MAILNAME=~a
.endif
.ifndef LOCAL_DELIVERY
LOCAL_DELIVERY=~a
.endif
.ifndef MAIN_RELAY_NETS
MAIN_RELAY_NETS=: 127.0.0.1 : ::::1
.endif
.ifndef DCreadhost
DCreadhost=~a
.endif
.ifndef DCsmarthost
DCsmarthost=~a
.endif
.ifndef DC_eximconfig_configtype
DC_eximconfig_configtype=~a
.endif
.ifndef DCconfig_satellite
DCconfig_satellite=1
.endif

# Create domain and host lists for relay control
# '@' refers to 'the name of the local host'

# List of domains considered local for exim. Domains not listed here
# need to be deliverable remotely.
domainlist local_domains = MAIN_LOCAL_DOMAINS

# List of recipient domains to relay _to_. Use this list if you're -
# for example - fallback MX or mail gateway for domains.
domainlist relay_to_domains = MAIN_RELAY_TO_DOMAINS

# List of sender networks (IP addresses) to _unconditionally_ relay
# _for_. If you intend to be SMTP AUTH server, you do not need to enter
# anything here.
hostlist relay_from_hosts = MAIN_RELAY_NETS


# Decide which domain to use to add to all unqualified addresses.
# If MAIN_PRIMARY_HOSTNAME_AS_QUALIFY_DOMAIN is defined, the primary
# hostname is used. If not, but MAIN_QUALIFY_DOMAIN is set, the value
# of MAIN_QUALIFY_DOMAIN is used. If both macros are not defined,
# the first line of /etc/mailname is used.
.ifndef MAIN_PRIMARY_HOSTNAME_AS_QUALIFY_DOMAIN
.ifndef MAIN_QUALIFY_DOMAIN
qualify_domain = ETC_MAILNAME
.else
qualify_domain = MAIN_QUALIFY_DOMAIN
.endif
.endif

# listen on all all interfaces?
.ifdef MAIN_LOCAL_INTERFACES
local_interfaces = MAIN_LOCAL_INTERFACES
.endif

.ifndef LOCAL_DELIVERY
# The default transport, set in /etc/exim4/update-exim4.conf.conf,
# defaulting to mail_spool. See CONFDIR/conf.d/transport/ for possibilities
LOCAL_DELIVERY=mail_spool
.endif

# The gecos field in /etc/passwd holds not only the name. see passwd(5).
gecos_pattern = ^([^,:]*)
gecos_name = $1

# always log tls_peerdn as we use TLS for outgoing connects by default
.ifndef MAIN_LOG_SELECTOR
MAIN_LOG_SELECTOR = +smtp_protocol_error +smtp_syntax_error +tls_certificate_verified +tls_peerdn
.endif

"
          (dc-exim-config-format-list (dc-exim-local-interfaces config))  ;; MAIN_LOCAL_INTERFACES
          (dc-exim-config-format-bool (dc-exim-minimaldns config))
          (dc-exim-hostname config)       ;; MAIN_HARDCODE_PRIMARY_HOSTNAME
          (dc-exim-config-format-bool (dc-exim-hide-mailname config)) ;; HIDE_MAILNAME
          dc-package-version              ;; MAIN_PACKAGE_VERSION
          (dc-exim-hostname config)       ;; MAIN_LOCAL_DOMAINS
          (dc-exim-relay-domains config)  ;; MAIN_RELAY_TO_DOMAINS
          (dc-exim-hostname config)       ;; ETC_MAILNAME
          (dc-exim-localdelivery config)  ;; LOCAL_DELIVERY
          ;(dc-exim-relay-nets config)     ;; MAIN_RELAY_NETS
          (dc-exim-readhost config)       ;; DCreadhost
          (dc-exim-smarthost config)      ;; DCsmarthost)
          (dc-exim-configtype config)     ;; DC_eximconfig_configtype
          ))


(define (main-exim-config-options port config)
  (format port "### main/02_exim4-config_options
#################################


# Defines the access control list that is run when an
# SMTP MAIL command is received.
#
.ifndef MAIN_ACL_CHECK_MAIL
MAIN_ACL_CHECK_MAIL = acl_check_mail
.endif
acl_smtp_mail = MAIN_ACL_CHECK_MAIL


# Defines the access control list that is run when an
# SMTP RCPT command is received.
#
.ifndef MAIN_ACL_CHECK_RCPT
MAIN_ACL_CHECK_RCPT = acl_check_rcpt
.endif
acl_smtp_rcpt = MAIN_ACL_CHECK_RCPT


# Defines the access control list that is run when an
# SMTP DATA command is received.
#
.ifndef MAIN_ACL_CHECK_DATA
MAIN_ACL_CHECK_DATA = acl_check_data
.endif
acl_smtp_data = MAIN_ACL_CHECK_DATA


# Message size limit. The default (used when MESSAGE_SIZE_LIMIT
# is unset) is 50 MB
.ifdef MESSAGE_SIZE_LIMIT
message_size_limit = MESSAGE_SIZE_LIMIT
.endif


# If you are running exim4-daemon-heavy or a custom version of Exim that
# was compiled with the content-scanning extension, you can cause incoming
# messages to be automatically scanned for viruses. You have to modify the
# configuration in two places to set this up. The first of them is here,
# where you define the interface to your scanner. This example is typical
# for ClamAV; see the manual for details of what to set for other virus
# scanners. The second modification is in the acl_check_data access
# control list.

# av_scanner = clamd:/run/clamav/clamd.ctl


# For spam scanning, there is a similar option that defines the interface to
# SpamAssassin. You do not need to set this if you are using the default, which
# is shown in this commented example. As for virus scanning, you must also
# modify the acl_check_data access control list to enable spam scanning.

spamd_address = 127.0.0.1 11333 variant=rspamd

# Domain used to qualify unqualified recipient addresses
# If this option is not set, the qualify_domain value is used.
# qualify_recipient = <value of qualify_domain>


# Allow Exim to recognize addresses of the form \"user@[10.11.12.13]\",
# where the domain part is a \"domain literal\" (an IP address) instead
# of a named domain. The RFCs require this facility, but it is disabled
# in the default config since it is rarely used and frequently abused.
# Domain literal support also needs a special router, which is automatically
# enabled if you use the enable macro MAIN_ALLOW_DOMAIN_LITERALS.
# Additionally, you might want to make your local IP addresses (or @[])
# local domains.
.ifdef MAIN_ALLOW_DOMAIN_LITERALS
allow_domain_literals
.endif


# Do a reverse DNS lookup on all incoming IP calls, in order to get the
# true host name. If you feel this is too expensive, the networks for
# which a lookup is done can be listed here.
.ifndef DC_minimaldns
.ifndef MAIN_HOST_LOOKUP
MAIN_HOST_LOOKUP = *
.endif
host_lookup = MAIN_HOST_LOOKUP
.endif

# The setting below causes Exim to try to initialize the system resolver
# library with DNSSEC support.  It has no effect if your library lacks
# DNSSEC support.
dns_dnssec_ok = 1

# In a minimaldns setup, update-exim4.conf guesses the hostname and
# dumps it here to avoid DNS lookups being done at Exim run time.
.ifdef MAIN_HARDCODE_PRIMARY_HOSTNAME
primary_hostname = MAIN_HARDCODE_PRIMARY_HOSTNAME
.endif

# The settings below cause Exim to make RFC 1413 (ident) callbacks
# for all incoming SMTP calls. You can limit the hosts to which these
# calls are made, and/or change the timeout that is used. If you set
# the timeout to zero, all RFC 1413 calls are disabled. RFC 1413 calls
# are cheap and can provide useful information for tracing problem
# messages, but some hosts and firewalls have problems with them.
# This can result in a timeout instead of an immediate refused
# connection, leading to delays on starting up SMTP sessions.
# (The default was reduced from 30s to 5s for release 4.61. and to
# disabled for release 4.86)
#
#rfc1413_hosts = *
#rfc1413_query_timeout = 5s


# Enable an efficiency feature.  We advertise the feature; clients
# may request to use it.  For multi-recipient mails we then can
# reject or accept per-user after the message is received.
# This supports recipient-dependent content filtering; without it
# you have to temp-reject any recipients after the first that have
# incompatible filtering, and do the filtering in the data ACL.
# Even with this enabled, you must support the old style for peers
# not flagging support for PRDR (visible via $prdr_requested).
prdr_enable = true

# When using an external relay tester (such as rt.njabl.org and/or the
# currently defunct relay-test.mail-abuse.org, the test may be aborted
# since exim complains about \"too many nonmail commands\". If you want
# the test to complete, add the host from where \"your\" relay tester
# connects from to the MAIN_SMTP_ACCEPT_MAX_NOMAIL_HOSTS macro.
# Please note that a non-empty setting may cause extra DNS lookups to
# happen, which is the reason why this option is commented out in the
# default settings.
# MAIN_SMTP_ACCEPT_MAX_NOMAIL_HOSTS = !rt.njabl.org
.ifdef MAIN_SMTP_ACCEPT_MAX_NOMAIL_HOSTS
smtp_accept_max_nonmail_hosts = MAIN_SMTP_ACCEPT_MAX_NOMAIL_HOSTS
.endif

# By default, exim forces a Sender: header containing the local
# account name at the local host name in all locally submitted messages
# that don't have the local account name at the local host name in the
# From: header, deletes any Sender: header present in the submitted
# message and forces the envelope sender of all locally submitted
# messages to the local account name at the local host name.
# The following settings allow local users to specify their own envelope sender
# in a locally submitted message. Sender: headers existing in a locally
# submitted message are not removed, and no automatic Sender: headers
# are added. These settings are fine for most hosts.
# If you run exim on a classical multi-user systems where all users
# have local mailboxes that can be reached via SMTP from the Internet
# with the local FQDN as the domain part of the address, you might want
# to disable the following three lines for traceability reasons.
.ifndef MAIN_FORCE_SENDER
local_from_check = false
local_sender_retain = true
untrusted_set_sender = *
.endif


# By default, Exim expects all envelope addresses to be fully qualified, that
# is, they must contain both a local part and a domain. Configure exim
# to accept unqualified addresses from certain hosts. When this is done,
# unqualified addresses are qualified using the settings of qualify_domain
# and/or qualify_recipient (see above).
# sender_unqualified_hosts = <unset>
# recipient_unqualified_hosts = <unset>


# Configure Exim to support the \"percent hack\" for certain domains.
# The \"percent hack\" is the feature by which mail addressed to x%y@z
# (where z is one of the domains listed) is locally rerouted to x@y
# and sent on. If z is not one of the \"percent hack\" domains, x%y is
# treated as an ordinary local part. The percent hack is rarely needed
# nowadays but frequently abused. You should not enable it unless you
# are sure that you really need it.
# percent_hack_domains = <unset>


# Bounce handling
.ifndef MAIN_IGNORE_BOUNCE_ERRORS_AFTER
MAIN_IGNORE_BOUNCE_ERRORS_AFTER = 2d
.endif
ignore_bounce_errors_after = MAIN_IGNORE_BOUNCE_ERRORS_AFTER

.ifndef MAIN_TIMEOUT_FROZEN_AFTER
MAIN_TIMEOUT_FROZEN_AFTER = 7d
.endif
timeout_frozen_after = MAIN_TIMEOUT_FROZEN_AFTER

.ifndef MAIN_FREEZE_TELL
MAIN_FREEZE_TELL = postmaster
.endif
freeze_tell = MAIN_FREEZE_TELL


# Define spool directory
.ifndef SPOOLDIR
SPOOLDIR = /var/spool/exim4
.endif
spool_directory = SPOOLDIR


# trusted users can set envelope-from to arbitrary values
.ifndef MAIN_TRUSTED_USERS
MAIN_TRUSTED_USERS = uucp
.endif
trusted_users = MAIN_TRUSTED_USERS
.ifdef MAIN_TRUSTED_GROUPS
trusted_groups = MAIN_TRUSTED_GROUPS
.endif


# users in admin group can do many other things
# admin_groups = <unset>


# SMTP Banner. The example includes the Debian version in the SMTP dialog
# MAIN_SMTP_BANNER = \"${primary_hostname} ESMTP Exim ${version_number} (Debian package MAIN_PACKAGE_VERSION) ${tod_full}\"
# smtp_banner = $smtp_active_hostname ESMTP Exim $version_number $tod_full

.ifdef MAIN_KEEP_ENVIRONMENT
keep_environment = MAIN_KEEP_ENVIRONMENT
.else
# set option to empty value to avoid warning.
keep_environment =
.endif
.ifdef MAIN_ADD_ENVIRONMENT
add_environment = MAIN_ADD_ENVIRONMENT
.endif

.ifdef _OPT_MAIN_SMTPUTF8_ADVERTISE_HOSTS
.ifndef MAIN_SMTPUTF8_ADVERTISE_HOSTS
MAIN_SMTPUTF8_ADVERTISE_HOSTS =
.endif
smtputf8_advertise_hosts = MAIN_SMTPUTF8_ADVERTISE_HOSTS
.endif

"))



(define (main-exim-config-tlsoptions port config)
  (format port "### main/03_exim4-config_tlsoptions
#################################

# TLS/SSL configuration for exim as an SMTP server.
# See /usr/share/doc/exim4-base/README.Debian.gz for explanations.

.ifdef MAIN_TLS_ENABLE
# Defines what hosts to 'advertise' STARTTLS functionality to. The
# default, *, will advertise to all hosts that connect with EHLO.
.ifndef MAIN_TLS_ADVERTISE_HOSTS
MAIN_TLS_ADVERTISE_HOSTS = *
.endif
tls_advertise_hosts = MAIN_TLS_ADVERTISE_HOSTS


# Full paths to Certificate and Private Key. The Private Key file
# must be kept 'secret' and should be owned by root.Debian-exim mode
# 640 (-rw-r-----). exim-gencert takes care of these prerequisites.
# Normally, exim4 looks for certificate and key in different files:
#   MAIN_TLS_CERTIFICATE - path to certificate file,
#                          CONFDIR/exim.crt if unset
#   MAIN_TLS_PRIVATEKEY  - path to private key file
#                          CONFDIR/exim.key if unset
# You can also configure exim to look for certificate and key in the
# same file, set MAIN_TLS_CERTKEY to that file to enable. This takes
# precedence over all other settings regarding certificate and key file.
.ifdef MAIN_TLS_CERTKEY
tls_certificate = MAIN_TLS_CERTKEY
.else
.ifndef MAIN_TLS_CERTIFICATE
MAIN_TLS_CERTIFICATE = CONFDIR/exim.crt
.endif
tls_certificate = MAIN_TLS_CERTIFICATE

.ifndef MAIN_TLS_PRIVATEKEY
MAIN_TLS_PRIVATEKEY = CONFDIR/exim.key
.endif
tls_privatekey = MAIN_TLS_PRIVATEKEY
.endif

# Pointer to the CA Certificates against which client certificates are
# checked. This is controlled by the `tls_verify_hosts' and
# `tls_try_verify_hosts' lists below.
# If you want to check server certificates, you need to add an
# tls_verify_certificates statement to the smtp transport.
# /etc/ssl/certs/ca-certificates.crt is generated by
# the \"ca-certificates\" package's update-ca-certificates(8) command.
.ifndef MAIN_TLS_VERIFY_CERTIFICATES
MAIN_TLS_VERIFY_CERTIFICATES = ${if exists{/etc/ssl/certs/ca-certificates.crt}\\
                                    {/etc/ssl/certs/ca-certificates.crt}\\
				    {/dev/null}}
.endif
tls_verify_certificates = MAIN_TLS_VERIFY_CERTIFICATES


# A list of hosts which are constrained by `tls_verify_certificates'. A host
# that matches `tls_verify_host' must present a certificate that is
# verifyable through `tls_verify_certificates' in order to be accepted as an
# SMTP client. If it does not, the connection is aborted.
.ifdef MAIN_TLS_VERIFY_HOSTS
tls_verify_hosts = MAIN_TLS_VERIFY_HOSTS
.endif

# A weaker form of checking: if a client matches `tls_try_verify_hosts' (but
# not `tls_verify_hosts'), request a certificate and check it against
# `tls_verify_certificates' but do not abort the connection if there is no
# certificate or if the certificate presented does not match. (This
# condition can be tested for in ACLs through `verify = certificate')
# By default, this check is done for all hosts. It is known that some
# clients (including incredimail's version downloadable in February
# 2008) choke on this. To disable, set MAIN_TLS_TRY_VERIFY_HOSTS to an
# empty value.
.ifdef MAIN_TLS_TRY_VERIFY_HOSTS
tls_try_verify_hosts = MAIN_TLS_TRY_VERIFY_HOSTS
.endif

.else
# Use upstream defaults
.endif

"))



(define (main-exim-config-ciphers port config)
  (format port "# openssl style ciphers
#tls_require_ciphers=\"ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:!RC4:HIGH:!MD5:!aNULL:!EDH\"

# gnutls style ciphers
#tls_require_ciphers=\"NONE:+VERS-TLS1.2:+VERS-TLS1.1:+VERS-TLS1.0:-VERS-SSL3.0:+ECDHE-RSA:+DHE-RSA:+RSA:+AES-128-GCM:+AES-128-CBC:+AES-256-CBC:+SIGN-RSA-SHA256:+SIGN-RSA-SHA384:+SIGN-RSA-SHA512:+SIGN-RSA-SHA224:+SIGN-RSA-SHA1:+SIGN-DSA-SHA256:+SIGN-DSA-SHA224:+SIGN-DSA-SHA1:+CURVE-ALL:+AEAD:+SHA256:+SHA384:+SHA1:+COMP-NULL\"
"))



(define (main-exim-config-log-selector port config)
  (format port "### main/90_exim4-config_log_selector
#################################

# uncomment this for debugging
# MAIN_LOG_SELECTOR == MAIN_LOG_SELECTOR +all -subject -arguments

.ifdef MAIN_LOG_SELECTOR
log_selector = MAIN_LOG_SELECTOR
.endif

"))


(define (acl-exim-config-header port config)
  (format port "######################################################################
#                       ACL CONFIGURATION                            #
#         Specifies access control lists for incoming SMTP mail      #
######################################################################
begin acl
"))


(define (acl-exim-config-local-deny-exceptions port config)
  (format port "#################################
### acl/20_exim4-config_local_deny_exceptions
#################################

# This is used to determine whitelisted senders and hosts.
# It checks for CONFDIR/host_local_deny_exceptions and
# CONFDIR/sender_local_deny_exceptions.
#
# It is meant to be used from some other acl entry.
#
# See exim4-config_files(5) for details.
#
# If the files do not exist, the white list never matches, which is
# the desired behaviour.
#
# The old file names CONFDIR/local_host_whitelist and
# CONFDIR/local_sender_whitelist will continue to be honored for a
# transition period. Their use is deprecated.

acl_local_deny_exceptions:
  accept
    hosts = ${if exists{CONFDIR/host_local_deny_exceptions}\\
                 {CONFDIR/host_local_deny_exceptions}\\
                 {}}
  accept
    senders = ${if exists{CONFDIR/sender_local_deny_exceptions}\\
                   {CONFDIR/sender_local_deny_exceptions}\\
                   {}}
  accept
    hosts = ${if exists{CONFDIR/local_host_allowlist}\\
                 {CONFDIR/local_host_allowlist}\\
                 {}}
  accept
    senders = ${if exists{CONFDIR/local_sender_allowlist}\\
                   {CONFDIR/local_sender_allowlist}\\
                   {}}

  # This hook allows you to hook in your own ACLs without having to
  # modify this file. If you do it like we suggest, you'll end up with
  # a small performance penalty since there is an additional file being
  # accessed. This doesn't happen if you leave the macro unset.
  .ifdef LOCAL_DENY_EXCEPTIONS_LOCAL_ACL_FILE
  .include LOCAL_DENY_EXCEPTIONS_LOCAL_ACL_FILE
  .endif

  # this is still supported for a transition period and is deprecated.
  .ifdef WHITELIST_LOCAL_DENY_LOCAL_ACL_FILE
  .include WHITELIST_LOCAL_DENY_LOCAL_ACL_FILE
  .endif

"))


(define (acl-exim-config-check-mail port config)
  (format port "#################################
### acl/30_exim4-config_check_mail
#################################

# This access control list is used for every MAIL command in an incoming
# SMTP message. The tests are run in order until the address is either
# accepted or denied.
#
acl_check_mail:

  accept


"))


(define (acl-exim-config-check-rcpt port config)
  (format port "#################################
### acl/30_exim4-config_check_rcpt
#################################

# define macros to be used below in this file to check recipient
# local parts for strange characters. Documentation below.
# This blocks local parts that begin with a dot or contain a quite
# broad range of non-alphanumeric characters.

.ifndef CHECK_RCPT_LOCAL_LOCALPARTS
CHECK_RCPT_LOCAL_LOCALPARTS = ^[.] : ^.*[@%!/|`#&?]
.endif

.ifndef CHECK_RCPT_REMOTE_LOCALPARTS
CHECK_RCPT_REMOTE_LOCALPARTS = ^[./|] : ^.*[@%!`#&?] : ^.*/\\\\.\\\\./
.endif

# This access control list is used for every RCPT command in an incoming
# SMTP message. The tests are run in order until the address is either
# accepted or denied.
#
acl_check_rcpt:

  # Accept if the source is local SMTP (i.e. not over TCP/IP). We do this by
  # testing for an empty sending host field.
  accept
    hosts = :
    control = dkim_disable_verify

  # Do not try to verify DKIM signatures of incoming mail if DC_minimaldns
  # or DISABLE_DKIM_VERIFY are set.
.ifdef DC_minimaldns
  warn
    control = dkim_disable_verify
.else
.ifdef DISABLE_DKIM_VERIFY
  warn
    control = dkim_disable_verify
.endif
.endif

  # The following section of the ACL is concerned with local parts that contain
  # certain non-alphanumeric characters. Dots in unusual places are
  # handled by this ACL as well.
  #
  # Non-alphanumeric characters other than dots are rarely found in genuine
  # local parts, but are often tried by people looking to circumvent
  # relaying restrictions. Therefore, although they are valid in local
  # parts, these rules disallow certain non-alphanumeric characters, as
  # a precaution.
  #
  # Empty components (two dots in a row) are not valid in RFC 2822, but Exim
  # allows them because they have been encountered. (Consider local parts
  # constructed as \"firstinitial.secondinitial.familyname\" when applied to
  # a name without a second initial.) However, a local part starting
  # with a dot or containing /../ can cause trouble if it is used as part of a
  # file name (e.g. for a mailing list). This is also true for local parts that
  # contain slashes. A pipe symbol can also be troublesome if the local part is
  # incorporated unthinkingly into a shell command line.
  #
  # These ACL components will block recipient addresses that are valid
  # from an RFC5322 point of view. We chose to have them blocked by
  # default for security reasons.
  #
  # If you feel that your site should have less strict recipient
  # checking, please feel free to change the default values of the macros
  # defined in main/01_exim4-config_listmacrosdefs or override them from a
  # local configuration file.
  #
  # Two different rules are used. The first one has a quite strict
  # default, and is applied to messages that are addressed to one of the
  # local domains handled by this host.

  # The default value of CHECK_RCPT_LOCAL_LOCALPARTS is defined
  # at the top of this file.
  .ifdef CHECK_RCPT_LOCAL_LOCALPARTS
  deny
    domains = +local_domains
    local_parts = CHECK_RCPT_LOCAL_LOCALPARTS
    message = restricted characters in address
  .endif


  # The second rule applies to all other domains, and its default is
  # considerably less strict.

  # The default value of CHECK_RCPT_REMOTE_LOCALPARTS is defined in
  # main/01_exim4-config_listmacrosdefs:
  # CHECK_RCPT_REMOTE_LOCALPARTS = ^[./|] : ^.*[@%!`#&?] : ^.*/\\\\.\\\\./

  # It allows local users to send outgoing messages to sites
  # that use slashes and vertical bars in their local parts. It blocks
  # local parts that begin with a dot, slash, or vertical bar, but allows
  # these characters within the local part. However, the sequence /../ is
  # barred. The use of some other non-alphanumeric characters is blocked.
  # Single quotes might probably be dangerous as well, but they're
  # allowed by the default regexps to avoid rejecting mails to Ireland.
  # The motivation here is to prevent local users (or local users' malware)
  # from mounting certain kinds of attack on remote sites.
  .ifdef CHECK_RCPT_REMOTE_LOCALPARTS
  deny
    domains = !+local_domains
    local_parts = CHECK_RCPT_REMOTE_LOCALPARTS
    message = restricted characters in address
  .endif


  # Accept mail to postmaster in any local domain, regardless of the source,
  # and without verifying the sender.
  #
  accept
    .ifndef CHECK_RCPT_POSTMASTER
    local_parts = postmaster
    .else
    local_parts = CHECK_RCPT_POSTMASTER
    .endif
    domains = +local_domains : +relay_to_domains


  # Deny unless the sender address can be verified.
  #
  # This is disabled by default so that DNSless systems don't break. If
  # your system can do DNS lookups without delay or cost, you might want
  # to enable this feature.
  #
  # This feature does not work in smarthost and satellite setups as
  # with these setups all domains pass verification. See spec.txt section
  # \"Access control lists\" subsection \"Address verification\" with the added
  # information that a smarthost/satellite setup routes all non-local e-mail
  # to the smarthost.
  .ifdef CHECK_RCPT_VERIFY_SENDER
  deny
    !acl = acl_local_deny_exceptions
    !verify = sender
    message = Sender verification failed
  .endif

  # Verify senders listed in local_sender_callout with a callout.
  #
  # In smarthost and satellite setups, this causes the callout to be
  # done to the smarthost. Verification will thus only be reliable if the
  # smarthost does reject illegal addresses in the SMTP dialog.
  deny
    !acl = acl_local_deny_exceptions
    senders = ${if exists{CONFDIR/local_sender_callout}\\
                         {CONFDIR/local_sender_callout}\\
                   {}}
    !verify = sender/callout

  .ifndef CHECK_RCPT_NO_FAIL_TOO_MANY_BAD_RCPT
  # Reject all RCPT commands after too many bad recipients
  # This is partly a defense against spam abuse and partly attacker abuse.
  # Real senders should manage, by the time they get to 10 RCPT directives,
  # to have had at least half of them be real addresses.
  #
  # This is a lightweight check and can protect you against repeated
  # invocations of more heavy-weight checks which would come after it.

  deny    condition     = ${if and {\\
                        {>{$rcpt_count}{10}}\\
                        {<{$recipients_count}{${eval:$rcpt_count/2}}} }}
          message       = Rejected for too many bad recipients
          logwrite      = REJECT [$sender_host_address]: bad recipient count high [${eval:$rcpt_count-$recipients_count}]
  .endif

  # Accept if the message comes from one of the hosts for which we are an
  # outgoing relay. It is assumed that such hosts are most likely to be MUAs,
  # so we set control=submission to make Exim treat the message as a
  # submission. It will fix up various errors in the message, for example, the
  # lack of a Date: header line. If you are actually relaying out out from
  # MTAs, you may want to disable this. If you are handling both relaying from
  # MTAs and submissions from MUAs you should probably split them into two
  # lists, and handle them differently.

  # Recipient verification is omitted here, because in many cases the clients
  # are dumb MUAs that don't cope well with SMTP error responses. If you are
  # actually relaying out from MTAs, you should probably add recipient
  # verification here.

  # Note that, by putting this test before any DNS black list checks, you will
  # always accept from these hosts, even if they end up on a black list. The
  # assumption is that they are your friends, and if they get onto black
  # list, it is a mistake.
  accept
    hosts = +relay_from_hosts
    control = submission/sender_retain
    control = dkim_disable_verify


  # Accept if the message arrived over an authenticated connection, from
  # any host. Again, these messages are usually from MUAs, so recipient
  # verification is omitted, and submission mode is set. And again, we do this
  # check before any black list tests.
  accept
    authenticated = *
    control = submission/sender_retain
    control = dkim_disable_verify

  # Insist that a HELO/EHLO was accepted.

  require
    condition	= ${if def:sender_helo_name}
    message	= nice hosts say HELO first

  # Insist that any other recipient address that we accept is either in one of
  # our local domains, or is in a domain for which we explicitly allow
  # relaying. Any other domain is rejected as being unacceptable for relaying.
  require
    message = relay not permitted
    domains = +local_domains : +relay_to_domains


  # We also require all accepted addresses to be verifiable. This check will
  # do local part verification for local domains, but only check the domain
  # for remote domains.
  require
    verify = recipient


  # Verify recipients listed in local_rcpt_callout with a callout.
  # This is especially handy for forwarding MX hosts (secondary MX or
  # mail hubs) of domains that receive a lot of spam to non-existent
  # addresses.  The only way to check local parts for remote relay
  # domains is to use a callout (add /callout), but please read the
  # documentation about callouts before doing this.
  deny
    !acl = acl_local_deny_exceptions
    recipients = ${if exists{CONFDIR/local_rcpt_callout}\\
                            {CONFDIR/local_rcpt_callout}\\
                      {}}
    !verify = recipient/callout


  # CONFDIR/local_sender_blacklist holds a list of envelope senders that
  # should have their access denied to the local host. Incoming messages
  # with one of these senders are rejected at RCPT time.
  #
  # The explicit white lists are honored as well as negative items in
  # the black list. See exim4-config_files(5) for details.
  deny
    !acl = acl_local_deny_exceptions
    senders = ${if exists{CONFDIR/local_sender_denylist}\\
                   {CONFDIR/local_sender_denylist}\\
                   {}}
    message = sender envelope address $sender_address is locally blocked here. If you think this is wrong, get in touch with postmaster
    log_message = sender envelope address is locally blocked.


  # deny bad sites (IP address)
  # CONFDIR/local_host_blacklist holds a list of host names, IP addresses
  # and networks (CIDR notation)  that should have their access denied to
  # The local host. Messages coming in from a listed host will have all
  # RCPT statements rejected.
  #
  # The explicit white lists are honored as well as negative items in
  # the black list. See exim4-config_files(5) for details.
  deny
    !acl = acl_local_deny_exceptions
    hosts = ${if exists{CONFDIR/local_host_denylist}\\
                 {CONFDIR/local_host_denylist}\\
                 {}}
    message = sender IP address $sender_host_address is locally denied here. If you think this is wrong, get in touch with postmaster
    log_message = sender IP address is locally denied.


  # Warn if the sender host does not have valid reverse DNS.
  #
  # If your system can do DNS lookups without delay or cost, you might want
  # to enable this.
  # If sender_host_address is defined, it's a remote call.  If
  # sender_host_name is not defined, then reverse lookup failed.  Use
  # this instead of !verify = reverse_host_lookup to catch deferrals
  # as well as outright failures.
  .ifdef CHECK_RCPT_REVERSE_DNS
  warn
    condition = ${if and{{def:sender_host_address}{!def:sender_host_name}}\\
                      {yes}{no}}
    add_header = X-Host-Lookup-Failed: Reverse DNS lookup failed for $sender_host_address (${if eq{$host_lookup_failed}{1}{failed}{deferred}})
  .endif


  # Use spfquery to perform a pair of SPF checks.
  #
  # This is quite costly in terms of DNS lookups (~~6 lookups per mail).  Do not
  # enable if that's an issue.  Also note that if you enable this, you must
  # install \"spf-tools-perl\" which provides the spfquery command.
  # Missing spf-tools-perl will trigger the \"Unexpected error in
  # SPF check\" warning.
  .ifdef CHECK_RCPT_SPF
  deny
    !acl = acl_local_deny_exceptions
    condition = ${run{/usr/bin/spfquery.mail-spf-perl --ip \\
                   ${quote:$sender_host_address} --identity \\
                   ${if def:sender_address_domain \\
                       {--scope mfrom  --identity ${quote:$sender_address}}\\
                       {--scope helo --identity ${quote:$sender_helo_name}}}}\\
                   {no}{${if eq {$runrc}{1}{yes}{no}}}}
    message = [SPF] $sender_host_address is not allowed to send mail from \\
              ${if def:sender_address_domain {$sender_address_domain}{$sender_helo_name}}.
    log_message = SPF check failed.

  defer
    !acl = acl_local_deny_exceptions
    condition = ${if eq {$runrc}{5}{yes}{no}}
    message = Temporary DNS error while checking SPF record.  Try again later.

  warn
    condition = ${if <={$runrc}{6}{yes}{no}}
    add_header = Received-SPF: ${if eq {$runrc}{0}{pass}\\
                                {${if eq {$runrc}{2}{softfail}\\
                                 {${if eq {$runrc}{3}{neutral}\\
				  {${if eq {$runrc}{4}{permerror}\\
				   {${if eq {$runrc}{6}{none}{error}}}}}}}}}\\
				} client-ip=$sender_host_address; \\
				${if def:sender_address_domain \\
				   {envelope-from=${sender_address}; }{}}\\
				helo=$sender_helo_name

  warn
    condition = ${if >{$runrc}{6}{yes}{no}}
    log_message = Unexpected error in SPF check.
  .endif


  # Check against classic DNS \"block\" lists (DNSBLs) which list
  # sender IP addresses
  .ifdef CHECK_RCPT_IP_DNSBLS
  warn
    dnslists = CHECK_RCPT_IP_DNSBLS
    add_header = X-Warning: $sender_host_address is listed at $dnslist_domain ($dnslist_value: $dnslist_text)
    log_message = $sender_host_address is listed at $dnslist_domain ($dnslist_value: $dnslist_text)
  .endif


  # Check against DNSBLs which list sender domains, with an option to locally
  # whitelist certain domains that might be blocked.
  #
  # Note: If you define CHECK_RCPT_DOMAIN_DNSBLS, you must append
  # \"/$sender_address_domain\" after each domain.  For example:
  # CHECK_RCPT_DOMAIN_DNSBLS = rhsbl.foo.org/$sender_address_domain \\
  #                            : rhsbl.bar.org/$sender_address_domain
  .ifdef CHECK_RCPT_DOMAIN_DNSBLS
  warn
    !senders = ${if exists{CONFDIR/local_domain_dnsbl_allowlist}\\
                    {CONFDIR/local_domain_dnsbl_allowlist}\
                    {}}
    dnslists = CHECK_RCPT_DOMAIN_DNSBLS
    add_header = X-Warning: $sender_address_domain is listed at $dnslist_domain ($dnslist_value: $dnslist_text)
    log_message = $sender_address_domain is listed at $dnslist_domain ($dnslist_value: $dnslist_text)
  .endif


  # This hook allows you to hook in your own ACLs without having to
  # modify this file. If you do it like we suggest, you'll end up with
  # a small performance penalty since there is an additional file being
  # accessed. This doesn't happen if you leave the macro unset.
  .ifdef CHECK_RCPT_LOCAL_ACL_FILE
  .include CHECK_RCPT_LOCAL_ACL_FILE
  .endif


  #############################################################################
  # This check is commented out because it is recognized that not every
  # sysadmin will want to do it. If you enable it, the check performs
  # Client SMTP Authorization (csa) checks on the sending host. These checks
  # do DNS lookups for SRV records. The CSA proposal is currently (May 2005)
  # an Internet draft. You can, of course, add additional conditions to this
  # ACL statement to restrict the CSA checks to certain hosts only.
  #
  # require verify = csa
  #############################################################################


  # Accept if the address is in a domain for which we are an incoming relay,
  # but again, only if the recipient can be verified.

  accept
    domains = +relay_to_domains
    endpass
    verify = recipient


  # At this point, the address has passed all the checks that have been
  # configured, so we accept it unconditionally.

  accept

"))


(define (acl-exim-config-check-data port config)
  (format port "#################################
### acl/40_exim4-config_check_data
#################################

# This ACL is used after the contents of a message have been received. This
# is the ACL in which you can test a message's headers or body, and in
# particular, this is where you can invoke external virus or spam scanners.

acl_check_data:

  # Deny if the message contains an overlong line.  Per the standards
  # we should never receive one such via SMTP.
  #
  .ifndef IGNORE_SMTP_LINE_LENGTH_LIMIT
  deny
    condition  = ${if > {$max_received_linelength}{998}}
    message    = maximum allowed line length is 998 octets, \\
                       got $max_received_linelength
  .endif

  # Deny if the headers contain badly-formed addresses.
  #
  .ifndef NO_CHECK_DATA_VERIFY_HEADER_SYNTAX
  deny
    !acl = acl_local_deny_exceptions
    !verify = header_syntax
    message = header syntax
    log_message = header syntax ($acl_verify_message)
  .endif


  # require that there is a verifiable sender address in at least
  # one of the \"Sender:\", \"Reply-To:\", or \"From:\" header lines.
  .ifdef CHECK_DATA_VERIFY_HEADER_SENDER
  deny
    !acl = acl_local_deny_exceptions
    !verify = header_sender
    message = No verifiable sender address in message headers
  .endif


  # Deny if the message contains malware. Before enabling this check, you
  # must install a virus scanner and set the av_scanner option in the
  # main configuration.
  #
  # exim4-daemon-heavy must be used for this section to work.
  #
  # deny
  #   malware = *
  #   message = This message was detected as possible malware ($malware_name).


  # Add headers to a message if it is judged to be spam. Before enabling this,
  # you must install SpamAssassin. You may also need to set the spamd_address
  # option in the main configuration.
  #
  # exim4-daemon-heavy must be used for this section to work.
  #
  # Please note that this is only suiteable as an example. See
  # /usr/share/doc/exim4-base/README.Debian.gz
  #
  # See the exim docs and the exim wiki for more suitable examples.
  #
  # # Remove internal headers
  # warn
  #   remove_header = X-Spam_score: X-Spam_score_int : X-Spam_bar : \
  #                   X-Spam_report
  #
  # warn
  #   condition = ${if <{$message_size}{120k}{1}{0}}
  #   # \":true\" to add headers/acl variables even if not spam
  #   spam = nobody:true
  #   add_header = X-Spam_score: $spam_score
  #   add_header = X-Spam_bar: $spam_bar
  #   # Do not enable this unless you have shorted SpamAssassin's report
  #   #add_header = X-Spam_report: $spam_report
  #
  # Reject spam messages (score >15.0).
  # This breaks mailing list and forward messages.
  # deny
  #   condition = ${if <{$message_size}{120k}{1}{0}}
  #   condition = ${if >{$spam_score_int}{150}{true}{false}}
  #   message = Classified as spam (score $spam_score)

  # do not scan messages submitted from our own hosts
  # +relay_from_hosts is assumed to be a list of hosts in configuration
  accept hosts = +relay_from_hosts

  # do not scan messages from submission port (or maybe you want to?)
  accept condition = ${if eq{$interface_port}{587}}

  # skip scanning for authenticated users (if desired?)
  accept authenticated = *

  # scan the message with rspamd
  warn spam = nobody:true
  # This will set variables as follows:
  # $spam_action is the action recommended by rspamd
  # $spam_score is the message score (we unlikely need it)
  # $spam_score_int is spam score multiplied by 10
  # $spam_report lists symbols matched & protocol messages
  # $spam_bar is a visual indicator of spam/ham level

  # use greylisting available in rspamd v1.3+
  defer message    = Please try again later
        condition  = ${if eq{$spam_action}{soft reject}}

  deny  message    = Message discarded as high-probability spam
        condition  = ${if eq{$spam_action}{reject}}

  # Remove foreign headers
  warn remove_header = x-spam-bar : x-spam-score : x-spam-report : x-spam-status

  # add spam-score and spam-report header when \"add header\" action is recommended by rspamd
  warn
    condition  = ${if eq{$spam_action}{add header}}
    add_header = X-Spam-Score: $spam_score ($spam_bar)
    add_header = X-Spam-Report: $spam_report

  # add x-spam-status header if message is not ham
  # do not match when $spam_action is empty (e.g. when rspamd is not running)
  warn
    ! condition  = ${if match{$spam_action}{^no action\\$|^greylist\\$|^\\$}}
    add_header = X-Spam-Status: Yes

  # add x-spam-bar header if score is positive
  warn
    condition = ${if >{$spam_score_int}{0}}
    add_header = X-Spam-Bar: $spam_bar

  # This hook allows you to hook in your own ACLs without having to
  # modify this file. If you do it like we suggest, you'll end up with
  # a small performance penalty since there is an additional file being
  # accessed. This doesn't happen if you leave the macro unset.
  .ifdef CHECK_DATA_LOCAL_ACL_FILE
  .include CHECK_DATA_LOCAL_ACL_FILE
  .endif


  # accept otherwise
  accept

"))


(define (router-exim-config-header port config)
  (format port "######################################################################
#                      ROUTERS CONFIGURATION                         #
#               Specifies how addresses are handled                  #
######################################################################
#     THE ORDER IN WHICH THE ROUTERS ARE DEFINED IS IMPORTANT!       #
# An address is passed to each router in turn until it is accepted.  #
######################################################################

begin routers

"))


(define (router-exim-config-domain-literal port config)
  (format port "#################################
### router/100_exim4-config_domain_literal
#################################

# This router handles e-mail addresses in \"domain literal\" form like
# <user@[10.11.12.13]>. The RFCs require this facility, but it is disabled
# in the default config since it is rarely used and frequently abused.
# Domain literal support also needs to be enabled in the main config,
# which is automatically done if you use the enable macro
# MAIN_ALLOW_DOMAIN_LITERALS.

.ifdef MAIN_ALLOW_DOMAIN_LITERALS
domain_literal:
  debug_print = \"R: domain_literal for $local_part@$domain\"
  driver = ipliteral
  domains = ! +local_domains
  transport = remote_smtp
.endif

"))


(define (router-exim-config-hubbed-hosts port config)
  (format port "#################################
# router/150_exim4-config_hubbed_hosts
#################################

# route specific domains manually.
#
# see exim4-config_files(5) and spec.txt chapter 20.3 through 20.7 for
# more detailed documentation.

hubbed_hosts:
  debug_print = \"R: hubbed_hosts for $domain\"
  driver = manualroute
  domains = \"${if exists{CONFDIR/hubbed_hosts}\\
                   {partial-lsearch;CONFDIR/hubbed_hosts}\\
              fail}\"
  same_domain_copy_routing = yes
  route_data = ${lookup{$domain}partial-lsearch{CONFDIR/hubbed_hosts}}
  transport = remote_smtp

"))


(define (router-exim-config-primary port config)
  (format port "#################################
### router/200_exim4-config_primary
#################################
# This file holds the primary router, responsible for nonlocal mails

.ifdef DCconfig_internet
# configtype=internet
#
# deliver mail to the recipient if recipient domain is a domain we
# relay for. We do not ignore any target hosts here since delivering to
# a site local or even a link local address might be wanted here, and if
# such an address has found its way into the MX record of such a domain,
# the local admin is probably in a place where that broken MX record
# could be fixed.

dnslookup_relay_to_domains:
  debug_print = \"R: dnslookup_relay_to_domains for $local_part@$domain\"
  driver = dnslookup
  domains = ! +local_domains : +relay_to_domains
  transport = remote_smtp
  same_domain_copy_routing = yes
  no_more

# ignore private rfc1918, loopback, APIPA/link-local, local broadcast, unspecified, unique local, linked-scoped unicast and discard-Only
.ifndef ROUTER_DNSLOOKUP_IGNORE_TARGET_HOSTS
ROUTER_DNSLOOKUP_IGNORE_TARGET_HOSTS = <; 0.0.0.0 ; 127.0.0.0/8 ; 192.168.0.0/16 ; 172.16.0.0/12 ; 10.0.0.0/8 ; 169.254.0.0/16 ; 255.255.255.255 ; ::/128 ; ::1/128 ; fc00::/7 ; fe80::/10 ; 100::/64
.endif

# deliver mail directly to the recipient. This router is only reached
# for domains that we do not relay for. Since we most probably can't
# have broken MX records pointing to site local or link local IP
# addresses fixed, we ignore target hosts pointing to these addresses.

dnslookup:
  debug_print = \"R: dnslookup for $local_part@$domain\"
  driver = dnslookup
  domains = ! +local_domains
  transport = remote_smtp
  same_domain_copy_routing = yes
  ignore_target_hosts = ROUTER_DNSLOOKUP_IGNORE_TARGET_HOSTS
  no_more

.endif


.ifdef DCconfig_local
# configtype=local
#
# Stand-alone system, so generate an error for mail to a non-local domain
nonlocal:
  debug_print = \"R: nonlocal for $local_part@$domain\"
  driver = redirect
  domains = ! +local_domains
  allow_fail
  data = :fail: Mailing to remote domains not supported
  no_more

.endif


.ifdef DCconfig_smarthost DCconfig_satellite
# configtype=smarthost or configtype=satellite
#
# Send all non-local mail to a single other machine (smarthost).
#
# This means _ALL_ non-local mail goes to the smarthost. This will most
# probably not do what you want for domains that are listed in
# relay_domains. The most typical use for relay_domains is to control
# relaying for incoming e-mail on secondary MX hosts. In that case,
# it doesn't make sense to send the mail to the smarthost since the
# smarthost will probably send the message right back here, causing a
# loop.
#
# If you want to use a smarthost while being secondary MX for some
# domains, you'll need to copy the dnslookup_relay_to_domains router
# here so that mail to relay_domains is handled separately.

smarthost:
  debug_print = \"R: smarthost for $local_part@$domain\"
  driver = manualroute
  domains = ! +local_domains
  transport = remote_smtp_smarthost
  route_list = * DCsmarthost byname
  host_find_failed = ignore
  same_domain_copy_routing = yes
  no_more

.endif


# The \"no_more\" above means that all later routers are for
# domains in the local_domains list, i.e. just like Exim 3 directors.

"))


(define (router-exim-config-real-local port config)
  (format port "#################################
### router/300_exim4-config_real_local
#################################

# This router allows reaching a local user while avoiding local
# processing. This can be used to inform a user of a broken .forward
# file, for example. The userforward router does this.

COND_LOCAL_SUBMITTER = \"\\
               ${if match_ip{$sender_host_address}{:@[]}\\
                    {1}{0}\\
		}\"

real_local:
  debug_print = \"R: real_local for $local_part@$domain\"
  driver = accept
  domains = +local_domains
  condition = COND_LOCAL_SUBMITTER
  local_part_prefix = real-
  check_local_user
  transport = LOCAL_DELIVERY


"))


(define (router-exim-config-system-aliases port config)
  (format port "#################################
### router/400_exim4-config_system_aliases
#################################

# This router handles aliasing using a traditional /etc/aliases file.
#
##### NB  You must ensure that /etc/aliases exists. It used to be the case
##### NB  that every Unix had that file, because it was the Sendmail default.
##### NB  These days, there are systems that don't have it. Your aliases
##### NB  file should at least contain an alias for \"postmaster\".
#
# This router handles the local part in a case-insensitive way which
# satisfies the RFCs requirement that postmaster be reachable regardless
# of case. If you decide to handle /etc/aliases in a caseful way, you
# need to make arrangements for a caseless postmaster.
#
# Delivery to arbitrary directories, files, and piping to programs in
# /etc/aliases is disabled per default.
# If that is a problem for you, see
#   /usr/share/doc/exim4-base/README.Debian.gz
# for explanation and some workarounds.

system_aliases:
  debug_print = \"R: system_aliases for $local_part@$domain\"
  driver = redirect
  domains = +local_domains
  allow_fail
  allow_defer
  data = ${lookup{$local_part}lsearch{/etc/aliases}}
  .ifdef SYSTEM_ALIASES_USER
  user = SYSTEM_ALIASES_USER
  .endif
  .ifdef SYSTEM_ALIASES_GROUP
  group = SYSTEM_ALIASES_GROUP
  .endif
  .ifdef SYSTEM_ALIASES_FILE_TRANSPORT
  file_transport = SYSTEM_ALIASES_FILE_TRANSPORT
  .endif
  .ifdef SYSTEM_ALIASES_PIPE_TRANSPORT
  pipe_transport = SYSTEM_ALIASES_PIPE_TRANSPORT
  .endif
  .ifdef SYSTEM_ALIASES_DIRECTORY_TRANSPORT
  directory_transport = SYSTEM_ALIASES_DIRECTORY_TRANSPORT
  .endif

"))


(define (router-exim-config-hubuser port config)
  (format port "#################################
### router/500_exim4-config_hubuser
#################################

.ifdef DCconfig_satellite
# This router is only used for configtype=satellite.
# It takes care to route all mail targeted to <somelocaluser@this.machine>
# to the host where we read our mail
#
hub_user:
  debug_print = \"R: hub_user for $local_part@$domain\"
  driver = redirect
  domains = +local_domains
  data = ${local_part}@DCreadhost
  check_local_user

# Grab the redirected mail and deliver it.
# This is a duplicate of the smarthost router, needed because
# DCreadhost might end up as part of +local_domains
hub_user_smarthost:
  debug_print = \"R: hub_user_smarthost for $local_part@$domain\"
  driver = manualroute
  domains = DCreadhost
  transport = remote_smtp_smarthost
  route_list = * DCsmarthost byname
  host_find_failed = ignore
  same_domain_copy_routing = yes
  check_local_user
.endif

"))


(define (router-exim-config-userforward port config)
  (format port "#################################
### router/600_exim4-config_userforward
#################################

# This router handles forwarding using traditional .forward files in users'
# home directories. It also allows mail filtering with a forward file
# starting with the string \"# Exim filter\" or \"# Sieve filter\".
#
# The no_verify setting means that this router is skipped when Exim is
# verifying addresses. Similarly, no_expn means that this router is skipped if
# Exim is processing an EXPN command.
#
# The check_ancestor option means that if the forward file generates an
# address that is an ancestor of the current one, the current one gets
# passed on instead. This covers the case where A is aliased to B and B
# has a .forward file pointing to A.
#
# The four transports specified at the end are those that are used when
# forwarding generates a direct delivery to a directory, or a file, or to a
# pipe, or sets up an auto-reply, respectively.
#
userforward:
  debug_print = \"R: userforward for $local_part@$domain\"
  driver = redirect
  domains = +local_domains
  local_part_suffix=-*
  local_part_suffix_optional
  check_local_user
  file = $home/.forward
  require_files = $local_part_data:$home/.forward
  no_verify
  no_expn
  check_ancestor
  allow_filter
  forbid_smtp_code = true
  directory_transport = address_directory
  file_transport = address_file
  pipe_transport = address_pipe
  reply_transport = address_reply
  skip_syntax_errors
  syntax_errors_to = real-$local_part@$domain
  syntax_errors_text = \\
    This is an automatically generated message. An error has\\n\\
    been found in your .forward file. Details of the error are\\n\\
    reported below. While this error persists, you will receive\\n\\
    a copy of this message for every message that is addressed\\n\\
    to you. If your .forward file is a filter file, or if it is\\n\\
    a non-filter file containing no valid forwarding addresses,\\n\\
    a copy of each incoming message will be put in your normal\\n\\
    mailbox. If a non-filter file contains at least one valid\\n\\
    forwarding address, forwarding to the valid addresses will\\n\\
    happen, and those will be the only deliveries that occur.


"))


(define (router-exim-config-procmail port config)
  (format port "#################################
procmail:
  debug_print = \"R: procmail for $local_part@$domain\"
  driver = accept
  domains = +local_domains
  check_local_user
  transport = procmail_pipe
  # emulate OR with \"if exists\"-expansion
  require_files = ${local_part_data}:\\
                  ${if exists{/etc/procmailrc}\\
                    {/etc/procmailrc}{${home}/.procmailrc}}:\\
                  +/usr/bin/procmail
  no_verify
  no_expn


"))


(define (router-exim-config-maildrop port config)
  (format port "#################################
### router/800_exim4-config_maildrop
#################################

maildrop:
  debug_print = \"R: maildrop for $local_part@$domain\"
  driver = accept
  domains = +local_domains
  local_part_suffix=-*
  local_part_suffix_optional
  check_local_user
  transport = maildrop_pipe
  require_files = ${local_part_data}:${home}/.mailfilter:+/usr/bin/maildrop
  no_verify
  no_expn


"))


(define (router-exim-config-lowuid port config)
  (format port "#################################
### router/850_exim4-config_lowuid
#################################

.ifndef FIRST_USER_ACCOUNT_UID
FIRST_USER_ACCOUNT_UID = 0
.endif

.ifndef DEFAULT_SYSTEM_ACCOUNT_ALIAS
DEFAULT_SYSTEM_ACCOUNT_ALIAS = :fail: no mail to system accounts
.endif

COND_SYSTEM_USER_AND_REMOTE_SUBMITTER = \"\\
               ${if and{{! match_ip{$sender_host_address}{:@[]}}\\
                        {<{$local_user_uid}{FIRST_USER_ACCOUNT_UID}}}\\
                    {1}{0}\\
		}\"

lowuid_aliases:
  debug_print = \"R: lowuid_aliases for $local_part@$domain (UID $local_user_uid)\"
  check_local_user
  driver = redirect
  allow_fail
  domains = +local_domains
  condition = COND_SYSTEM_USER_AND_REMOTE_SUBMITTER
  data = ${if exists{CONFDIR/lowuid-aliases}\\
              {${lookup{$local_part}lsearch{CONFDIR/lowuid-aliases}\\
              {$value}{DEFAULT_SYSTEM_ACCOUNT_ALIAS}}}\\
              {DEFAULT_SYSTEM_ACCOUNT_ALIAS}}

"))


(define (router-exim-config-local-user port config)
  (format port "#################################
### router/900_exim4-config_local_user
#################################

# This router matches local user mailboxes. If the router fails, the error
# message is \"Unknown user\".

local_user:
  debug_print = \"R: local_user for $local_part@$domain\"
  driver = accept
  domains = +local_domains
  local_part_suffix=-*
  local_part_suffix_optional
  check_local_user
  local_parts = ! root
  transport = LOCAL_DELIVERY
  cannot_route_message = Unknown user

"))


(define (router-exim-config-mail4root port config)
  (format port "#################################
### router/mmm_mail4root
#################################
# deliver mail addressed to root to /var/mail/mail as user mail:mail
# if it was not redirected in /etc/aliases or by other means
# Exim cannot deliver as root since 4.24 (FIXED_NEVER_USERS)

mail4root:
  debug_print = \"R: mail4root for $local_part@$domain\"
  driver = redirect
  domains = +local_domains
  data = /var/mail/mail
  file_transport = address_file
  local_parts = root
  user = mail
  group = mail


"))


(define (transport-exim-config-header port config)
  (format port "######################################################################
#                      TRANSPORTS CONFIGURATION                      #
######################################################################
#                       ORDER DOES NOT MATTER                        #
#     Only one appropriate transport is called for each delivery.    #
######################################################################

# A transport is used only when referenced from a router that successfully
# handles an address.

begin transports


"))


(define (transport-exim-config-transport-macros port config)
  (format port "#################################
### transport/10_exim4-config_transport-macros
#################################

.ifdef HIDE_MAILNAME
REMOTE_SMTP_HEADERS_REWRITE=*@+local_domains $1@DCreadhost frs : *@ETC_MAILNAME $1@DCreadhost frs
REMOTE_SMTP_RETURN_PATH=${if match_domain{$sender_address_domain}{+local_domains}{${sender_address_local_part}@DCreadhost}{${if match_domain{$sender_address_domain}{ETC_MAILNAME}{${sender_address_local_part}@DCreadhost}fail}}}
.endif

.ifdef REMOTE_SMTP_HELO_FROM_DNS
.ifdef REMOTE_SMTP_HELO_DATA
REMOTE_SMTP_HELO_DATA==${lookup dnsdb {ptr=$sending_ip_address}{$value}{$primary_hostname}}
.else
REMOTE_SMTP_HELO_DATA=${lookup dnsdb {ptr=$sending_ip_address}{$value}{$primary_hostname}}
.endif
.endif

.ifndef REMOTE_SMTP_SMARTHOST_TLS_VERIFY_HOSTS
  REMOTE_SMTP_SMARTHOST_TLS_VERIFY_HOSTS = *
.endif

"))


(define (transport-exim-config-address-file port config)
  (format port "#################################
# This transport is used for handling deliveries directly to files that are
# generated by aliasing or forwarding.
#
address_file:
  debug_print = \"T: address_file for $local_part@$domain\"
  driver = appendfile
  delivery_date_add
  envelope_to_add
  return_path_add

  maildir_format 
  directory = ${if eq{$address_file}{inbox} \\
                   {$home/Maildir/} \\
                   {$home/Maildir/${sg{$address_file}{^inbox[.]}{}}}}


"))


(define (transport-exim-config-address-pipe port config)
  (format port "#################################
# This transport is used for handling pipe deliveries generated by
# .forward files. If the commands fails and produces any output on standard
# output or standard error streams, the output is returned to the sender
# of the message as a delivery error.
address_pipe:
  debug_print = \"T: address_pipe for $local_part@$domain\"
  driver = pipe
  return_fail_output


"))


(define (transport-exim-config-address-reply port config)
  (format port "#################################
# This transport is used for handling autoreplies generated by the filtering
# option of the userforward router.
#
address_reply:
  debug_print = \"T: autoreply for $local_part@$domain\"
  driver = autoreply


"))


(define (transport-exim-config-maildir-home port config)
  (format port "#################################
### transport/30_exim4-config_maildir_home
#################################

# Use this instead of mail_spool if you want to to deliver to Maildir in
# home-directory - change the definition of LOCAL_DELIVERY
#
maildir_home:
  debug_print = \"T: maildir_home for $local_part@$domain\"
  driver = appendfile
  .ifdef MAILDIR_HOME_MAILDIR_LOCATION
  directory = MAILDIR_HOME_MAILDIR_LOCATION
  .else
  directory = $home/Maildir
  .endif
  .ifdef MAILDIR_HOME_CREATE_DIRECTORY
  create_directory
  .endif
  .ifdef MAILDIR_HOME_CREATE_FILE
  create_file = MAILDIR_HOME_CREATE_FILE
  .endif
  delivery_date_add
  envelope_to_add
  return_path_add
  maildir_format
  .ifdef MAILDIR_HOME_DIRECTORY_MODE
  directory_mode = MAILDIR_HOME_DIRECTORY_MODE
  .else
  directory_mode = 0700
  .endif
  .ifdef MAILDIR_HOME_MODE
  mode = MAILDIR_HOME_MODE
  .else
  mode = 0600
  .endif
  mode_fail_narrower = false
  # This transport always chdirs to $home before trying to deliver. If
  # $home is not accessible, this chdir fails and prevents delivery.
  # If you are in a setup where home directories might not be
  # accessible, uncomment the current_directory line below.
  # current_directory = /

"))


;; this wont work on guix
(define (transport-exim-config-maildrop-pipe port config)
  (format port "#################################
maildrop_pipe:
  debug_print = \"T: maildrop_pipe for $local_part@$domain\"
  driver = pipe
  path = \"/bin:/usr/bin:/usr/local/bin\"
  command = \"/usr/bin/maildrop\"
  message_prefix =
  message_suffix =
  return_path_add
  delivery_date_add
  envelope_to_add


"))


(define (transport-exim-config-mail-spool port config)
  (format port "#################################
### transport/30_exim4-config_mail_spool

# This transport is used for local delivery to user mailboxes in traditional
# BSD mailbox format.
#
mail_spool:
  debug_print = \"T: appendfile for $local_part@$domain\"
  driver = appendfile
  file = /var/mail/$local_part_data
  delivery_date_add
  envelope_to_add
  return_path_add
  group = mail
  mode = 0660
  mode_fail_narrower = false


"))

;; wont work
(define (transport-exim-config-procmail-pipe port config)
  (format port "#################################
procmail_pipe:
  debug_print = \"T: procmail_pipe for $local_part@$domain\"
  driver = pipe
  path = \"/bin:/usr/bin:/usr/local/bin\"
  command = \"/usr/bin/procmail\"
  return_path_add
  delivery_date_add
  envelope_to_add


"))


(define (transport-exim-config-remote-smtp port config)
  (format port "#################################
### transport/30_exim4-config_remote_smtp
#################################
# This transport is used for delivering messages over SMTP connections.
# Refuse to send any message with over-long lines, which could have
# been received other than via SMTP. The use of message_size_limit to
# enforce this is a red herring.

remote_smtp:
  debug_print = \"T: remote_smtp for $local_part@$domain\"
  driver = smtp
.ifndef IGNORE_SMTP_LINE_LENGTH_LIMIT
  message_size_limit = ${if > {$max_received_linelength}{998} {1}{0}}
.endif
.ifdef REMOTE_SMTP_HOSTS_AVOID_TLS
  hosts_avoid_tls = REMOTE_SMTP_HOSTS_AVOID_TLS
.endif
.ifdef REMOTE_SMTP_HEADERS_REWRITE
  headers_rewrite = REMOTE_SMTP_HEADERS_REWRITE
.endif
.ifdef REMOTE_SMTP_RETURN_PATH
  return_path = REMOTE_SMTP_RETURN_PATH
.endif
.ifdef REMOTE_SMTP_HELO_DATA
  helo_data=REMOTE_SMTP_HELO_DATA
.endif
.ifdef REMOTE_SMTP_INTERFACE
  interface = REMOTE_SMTP_INTERFACE
.endif
.ifdef DKIM_DOMAIN
dkim_domain = DKIM_DOMAIN
.endif
.ifdef DKIM_SELECTOR
dkim_selector = DKIM_SELECTOR
.endif
.ifdef DKIM_PRIVATE_KEY
dkim_private_key = DKIM_PRIVATE_KEY
.endif
.ifdef DKIM_CANON
dkim_canon = DKIM_CANON
.endif
.ifdef DKIM_STRICT
dkim_strict = DKIM_STRICT
.endif
.ifdef DKIM_SIGN_HEADERS
dkim_sign_headers = DKIM_SIGN_HEADERS
.endif
.ifdef DKIM_TIMESTAMPS
dkim_timestamps = DKIM_TIMESTAMPS
.endif
.ifdef TLS_DH_MIN_BITS
tls_dh_min_bits = TLS_DH_MIN_BITS
.endif
.ifdef REMOTE_SMTP_TLS_CERTIFICATE
tls_certificate = REMOTE_SMTP_TLS_CERTIFICATE
.endif
.ifdef REMOTE_SMTP_PRIVATEKEY
tls_privatekey = REMOTE_SMTP_PRIVATEKEY
.endif
.ifdef REMOTE_SMTP_HOSTS_REQUIRE_TLS
  hosts_require_tls = REMOTE_SMTP_HOSTS_REQUIRE_TLS
.endif
.ifdef REMOTE_SMTP_TRANSPORTS_HEADERS_REMOVE
  headers_remove = REMOTE_SMTP_TRANSPORTS_HEADERS_REMOVE
.endif

"))


(define (transport-exim-config-remote-smtp-smarthost port config)
  (format port "#################################
### transport/30_exim4-config_remote_smtp_smarthost
#################################

# This transport is used for delivering messages over SMTP connections
# to a smarthost. The local host tries to authenticate.
# This transport is used for smarthost and satellite configurations.
# Refuse to send any messsage with over-long lines, which could have
# been received other than via SMTP. The use of message_size_limit to
# enforce this is a red herring.

remote_smtp_smarthost:
  debug_print = \"T: remote_smtp_smarthost for $local_part@$domain\"
  driver = smtp
  multi_domain
.ifndef IGNORE_SMTP_LINE_LENGTH_LIMIT
  message_size_limit = ${if > {$max_received_linelength}{998} {1}{0}}
.endif
  hosts_try_auth = <; ${if exists{CONFDIR/passwd.client} \\
        {\\
        ${lookup{$host}nwildlsearch{CONFDIR/passwd.client}{$host_address}}\\
        }\\
        {} \\
      }
.ifdef REMOTE_SMTP_SMARTHOST_HOSTS_AVOID_TLS
  hosts_avoid_tls = REMOTE_SMTP_SMARTHOST_HOSTS_AVOID_TLS
.endif
.ifdef REMOTE_SMTP_SMARTHOST_HOSTS_REQUIRE_TLS
  hosts_require_tls = REMOTE_SMTP_SMARTHOST_HOSTS_REQUIRE_TLS
.endif
.ifdef REMOTE_SMTP_SMARTHOST_TLS_VERIFY_CERTIFICATES
  tls_verify_certificates = REMOTE_SMTP_SMARTHOST_TLS_VERIFY_CERTIFICATES
.endif
.ifdef REMOTE_SMTP_SMARTHOST_TLS_VERIFY_HOSTS
  tls_verify_hosts = REMOTE_SMTP_SMARTHOST_TLS_VERIFY_HOSTS
.endif
.ifdef REMOTE_SMTP_HEADERS_REWRITE
  headers_rewrite = REMOTE_SMTP_HEADERS_REWRITE
.endif
.ifdef REMOTE_SMTP_RETURN_PATH
  return_path = REMOTE_SMTP_RETURN_PATH
.endif
.ifdef REMOTE_SMTP_HELO_DATA
  helo_data=REMOTE_SMTP_HELO_DATA
.endif
.ifdef TLS_DH_MIN_BITS
tls_dh_min_bits = TLS_DH_MIN_BITS
.endif
.ifdef REMOTE_SMTP_SMARTHOST_TLS_CERTIFICATE
tls_certificate = REMOTE_SMTP_SMARTHOST_TLS_CERTIFICATE
.endif
.ifdef REMOTE_SMTP_SMARTHOST_PRIVATEKEY
tls_privatekey = REMOTE_SMTP_SMARTHOST_PRIVATEKEY
.endif
.ifdef REMOTE_SMTP_TRANSPORTS_HEADERS_REMOVE
  headers_remove = REMOTE_SMTP_TRANSPORTS_HEADERS_REMOVE
.endif

"))


(define (transport-exim-config-address-directory port config)
  (format port "#################################
# This transport is used for handling file addresses generated by alias
# or .forward files if the path ends in \"/\", which causes it to be treated
# as a directory name rather than a file name.

address_directory:
  debug_print = \"T: address_directory for $local_part@$domain\"
  driver = appendfile
  delivery_date_add
  envelope_to_add
  return_path_add
  check_string = \"\"
  escape_string = \"\"
  maildir_format


"))


(define (retry-exim-config-header port config)
  (format port "######################################################################
#                      RETRY CONFIGURATION                           #
######################################################################

begin retry


"))


(define (retry-exim-config port config)
  (format port "#################################
### retry/30_exim4-config
#################################

# This single retry rule applies to all domains and all errors. It specifies
# retries every 15 minutes for 2 hours, then increasing retry intervals,
# starting at 1 hour and increasing each time by a factor of 1.5, up to 16
# hours, then retries every 6 hours until 4 days have passed since the first
# failed delivery.

# Please note that these rules only limit the frequency of retries, the
# effective retry-time depends on the frequency of queue-running, too.
# See QUEUEINTERVAL in /etc/default/exim4.

# Address or Domain    Error       Retries
# -----------------    -----       -------

*                      *           F,2h,15m; G,16h,1h,1.5; F,4d,6h


"))


(define (rewrite-exim-config-header port config)
  (format port "######################################################################
#                      REWRITE CONFIGURATION                         #
######################################################################

begin rewrite


"))


(define (rewrite-exim-config-rewriting port config)
  (format port "#################################
### rewrite/31_exim4-config_rewriting
#################################

# This rewriting rule is particularly useful for dialup users who
# don't have their own domain, but could be useful for anyone.
# It looks up the real address of all local users in a file
.ifndef NO_EAA_REWRITE_REWRITE
*@+local_domains \"${lookup{${local_part}}lsearch{/etc/email-addresses}\\
                   {$value}fail}\" Ffrs
# identical rewriting rule for /etc/mailname
*@ETC_MAILNAME \"${lookup{${local_part}}lsearch{/etc/email-addresses}\\
                   {$value}fail}\" Ffrs
.endif



"))


(define (auth-exim-config-header port config)
  (format port "######################################################################
#                   AUTHENTICATION CONFIGURATION                     #
######################################################################

begin authenticators



"))


(define (auth-exim-config-cram-md5 port config)
  (format port "
cram_md5_server:
  driver = cram_md5
  public_name = CRAM-MD5
  server_secret = ${extract{2}{:}{${lookup{$1}lsearch{CONFDIR/passwd}{$value}fail}}}
  server_set_id = $1


"))


(define (auth-exim-config-examples port config)
  (format port "#################################
### auth/30_exim4-config_examples
#################################

# The examples below are for server side authentication, when the
# local exim is SMTP server and clients authenticate to the local exim.

# They allow two styles of plain-text authentication against an
# CONFDIR/passwd file whose syntax is described in exim4_passwd(5).

# Hosts that are allowed to use AUTH are defined by the
# auth_advertise_hosts option in the main configuration. The default is
# \"*\", which allows authentication to all hosts over all kinds of
# connections if there is at least one authenticator defined here.
# Authenticators which rely on unencrypted clear text passwords don't
# advertise on unencrypted connections by default. Thus, it might be
# wise to set up TLS to allow encrypted connections. If TLS cannot be
# used for some reason, you can set AUTH_SERVER_ALLOW_NOTLS_PASSWORDS to
# advertise unencrypted clear text password based authenticators on all
# connections. As this is severely reducing security, using TLS is
# preferred over allowing clear text password based authenticators on
# unencrypted connections.

# PLAIN authentication has no server prompts. The client sends its
# credentials in one lump, containing an authorization ID (which we do not
# use), an authentication ID, and a password. The latter two appear as
# $auth2 and $auth3 in the configuration and should be checked against a
# valid username and password. In a real configuration you would typically
# use $auth2 as a lookup key, and compare $auth3 against the result of the
# lookup, perhaps using the crypteq{}{} condition.

# plain_server:
#   driver = plaintext
#   public_name = PLAIN
#   server_condition = \"${if crypteq{$auth3}{${extract{1}{:}{${lookup{$auth2}lsearch{CONFDIR/passwd}{$value}{*:*}}}}}{1}{0}}\"
#   server_set_id = $auth2
#   server_prompts = :
#   .ifndef AUTH_SERVER_ALLOW_NOTLS_PASSWORDS
#   server_advertise_condition = ${if eq{$tls_in_cipher}{}{}{*}}
#   .endif

# LOGIN authentication has traditional prompts and responses. There is no
# authorization ID in this mechanism, so unlike PLAIN the username and
# password are $auth1 and $auth2. Apart from that you can use the same
# server_condition setting for both authenticators.

# login_server:
#   driver = plaintext
#   public_name = LOGIN
#   server_prompts = \"Username:: : Password::\"
#   server_condition = \"${if crypteq{$auth2}{${extract{1}{:}{${lookup{$auth1}lsearch{CONFDIR/passwd}{$value}{*:*}}}}}{1}{0}}\"
#   server_set_id = $auth1
#   .ifndef AUTH_SERVER_ALLOW_NOTLS_PASSWORDS
#   server_advertise_condition = ${if eq{$tls_in_cipher}{}{}{*}}
#   .endif
#
# cram_md5_server:
#   driver = cram_md5
#   public_name = CRAM-MD5
#   server_secret = ${extract{2}{:}{${lookup{$auth1}lsearch{CONFDIR/passwd}{$value}fail}}}
#   server_set_id = $auth1

# Here is an example of CRAM-MD5 authentication against PostgreSQL:
#
# psqldb_auth_server:
#   driver = cram_md5
#   public_name = CRAM-MD5
#   server_secret = ${lookup pgsql{SELECT pw FROM users WHERE username = '${quote_pgsql:$auth1}'}{$value}fail}
#   server_set_id = $auth1

# Authenticate against local passwords using sasl2-bin
# Requires exim_uid to be a member of sasl group, see README.Debian.gz
# plain_saslauthd_server:
#   driver = plaintext
#   public_name = PLAIN
#   server_condition = ${if saslauthd{{$auth2}{$auth3}}{1}{0}}
#   server_set_id = $auth2
#   server_prompts = :
#   .ifndef AUTH_SERVER_ALLOW_NOTLS_PASSWORDS
#   server_advertise_condition = ${if eq{$tls_in_cipher}{}{}{*}}
#   .endif
#
# login_saslauthd_server:
#   driver = plaintext
#   public_name = LOGIN
#   server_prompts = \"Username:: : Password::\"
#   # don't send system passwords over unencrypted connections
#   server_condition = ${if saslauthd{{$auth1}{$auth2}}{1}{0}}
#   server_set_id = $auth1
#   .ifndef AUTH_SERVER_ALLOW_NOTLS_PASSWORDS
#   server_advertise_condition = ${if eq{$tls_in_cipher}{}{}{*}}
#   .endif
#
# ntlm_sasl_server:
#   driver = cyrus_sasl
#   public_name = NTLM
#   server_realm = <short main hostname>
#   server_set_id = $auth1
#   .ifndef AUTH_SERVER_ALLOW_NOTLS_PASSWORDS
#   server_advertise_condition = ${if eq{$tls_in_cipher}{}{}{*}}
#   .endif
#
# digest_md5_sasl_server:
#   driver = cyrus_sasl
#   public_name = DIGEST-MD5
#   server_realm = <short main hostname>
#   server_set_id = $auth1
#   .ifndef AUTH_SERVER_ALLOW_NOTLS_PASSWORDS
#   server_advertise_condition = ${if eq{$tls_in_cipher}{}{}{*}}
#   .endif

# Authentcate against cyrus-sasl
# This is mainly untested, please report any problems to
# pkg-exim4-users@lists.alioth.debian.org.
# cram_md5_sasl_server:
#   driver = cyrus_sasl
#   public_name = CRAM-MD5
#   server_realm = <short main hostname>
#   server_set_id = $auth1
#
# plain_sasl_server:
#   driver = cyrus_sasl
#   public_name = PLAIN
#   server_realm = <short main hostname>
#   server_set_id = $auth1
#   .ifndef AUTH_SERVER_ALLOW_NOTLS_PASSWORDS
#   server_advertise_condition = ${if eq{$tls_in_cipher}{}{}{*}}
#   .endif
#
# login_sasl_server:
#   driver = cyrus_sasl
#   public_name = LOGIN
#   server_realm = <short main hostname>
#   server_set_id = $auth1
#   .ifndef AUTH_SERVER_ALLOW_NOTLS_PASSWORDS
#   server_advertise_condition = ${if eq{$tls_in_cipher}{}{}{*}}
#   .endif

# Authenticate against courier authdaemon

# This is now the (working!) example from
# http://www.exim.org/eximwiki/FAQ/Policy_controls/Q0730
# Possible pitfall: access rights on /run/courier/authdaemon/socket.
# plain_courier_authdaemon:
#   driver = plaintext
#   public_name = PLAIN
#   server_condition = \\
#     ${extract {ADDRESS} \\
#               {${readsocket{/run/courier/authdaemon/socket} \\
#               {AUTH ${strlen:exim\\nlogin\\n$auth2\\n$auth3\\n}\\nexim\\nlogin\\n$auth2\\n$auth3\n} }} \\
#               {yes} \\
#               fail}
#   server_set_id = $auth2
#   .ifndef AUTH_SERVER_ALLOW_NOTLS_PASSWORDS
#   server_advertise_condition = ${if eq{$tls_in_cipher}{}{}{*}}
#   .endif

# login_courier_authdaemon:
#   driver = plaintext
#   public_name = LOGIN
#   server_prompts = Username:: : Password::
#   server_condition = \\
#     ${extract {ADDRESS} \\
#               {${readsocket{/run/courier/authdaemon/socket} \\
#               {AUTH ${strlen:exim\\nlogin\\n$auth1\\n$auth2\\n}\\nexim\\nlogin\\n$auth1\\n$auth2\\n} }} \\
#               {yes} \\
#               fail}
#   server_set_id = $auth1
#   .ifndef AUTH_SERVER_ALLOW_NOTLS_PASSWORDS
#   server_advertise_condition = ${if eq{$tls_in_cipher}{}{}{*}}
#   .endif

# This one is a bad hack to support the broken version 4.xx of
# Microsoft Outlook Express which violates the RFCs by demanding
# \"250-AUTH=\" instead of \"250-AUTH \".
# If your list of offered authenticators is other than PLAIN and LOGIN,
# you need to adapt the public_name line manually.
# It has to be the last authenticator to work and has not been tested
# well. Use at your own risk.
# See the thread entry point from
# http://www.exim.org/mail-archives/exim-users/Week-of-Mon-20050214/msg00213.html
# for the related discussion on the exim-users mailing list.
# Thanks to Fred Viles for this great work.

# support_broken_outlook_express_4_server:
#   driver = plaintext
#   public_name = \"\\r\\n250-AUTH=PLAIN LOGIN\"
#   server_prompts = User Name : Password
#   server_condition = no
#   .ifndef AUTH_SERVER_ALLOW_NOTLS_PASSWORDS
#   server_advertise_condition = ${if eq{$tls_in_cipher}{}{}{*}}
#   .endif

##############
# See /usr/share/doc/exim4-base/README.Debian.gz
##############

# These examples below are the equivalent for client side authentication.
# They get the passwords from CONFDIR/passwd.client, whose format is
# defined in exim4_passwd_client(5)

# Because AUTH PLAIN and AUTH LOGIN send the password in clear, we
# only allow these mechanisms over encrypted connections by default.
# You can set AUTH_CLIENT_ALLOW_NOTLS_PASSWORDS to allow unencrypted
# clear text password authentication on all connections.

cram_md5:
  driver = cram_md5
  public_name = CRAM-MD5
  client_name = ${extract{1}{:}{${lookup{$host}nwildlsearch{CONFDIR/passwd.client}{$value}fail}}}
  client_secret = ${extract{2}{:}{${lookup{$host}nwildlsearch{CONFDIR/passwd.client}{$value}fail}}}


# this returns the matching line from passwd.client and doubles all ^
PASSWDLINE=${sg{\\
                ${lookup{$host}nwildlsearch{CONFDIR/passwd.client}{$value}fail}\\
	        }\\
	        {\\N[\\^]\\N}\\
	        {^^}\\
	    }

# plain:
#   driver = plaintext
#   public_name = PLAIN
# .ifndef AUTH_CLIENT_ALLOW_NOTLS_PASSWORDS
#   client_send = \"<; ${if !eq{$tls_out_cipher}{}\\
#                     {^${extract{1}{:}{PASSWDLINE}}\\
# 		     ^${sg{PASSWDLINE}{\\N([^:]+:)(.*)\\N}{\\$2}}\\
# 		   }fail}\"
# .else
#   client_send = \"<; ^${extract{1}{:}{PASSWDLINE}}\\
# 		    ^${sg{PASSWDLINE}{\\N([^:]+:)(.*)\\N}{\\$2}}\"
# .endif
#
# login:
#   driver = plaintext
#   public_name = LOGIN
# .ifndef AUTH_CLIENT_ALLOW_NOTLS_PASSWORDS
#   # Return empty string if not non-TLS AND looking up $host in passwd-file
#   # yields a non-empty string; fail otherwise.
#   client_send = \"<; ${if and{\\
#                           {!eq{$tls_out_cipher}{}}\\
#                           {!eq{PASSWDLINE}{}}\\
#                          }\
#                       {}fail}\\
#                  ; ${extract{1}{::}{PASSWDLINE}}\\
# 		 ; ${sg{PASSWDLINE}{\\N([^:]+:)(.*)\\N}{\\$2}}\"
# .else
#   # Return empty string if looking up $host in passwd-file yields a
#   # non-empty string; fail otherwise.
#   client_send = \"<; ${if !eq{PASSWDLINE}{}\\
#                       {}fail}\\
#                  ; ${extract{1}{::}{PASSWDLINE}}\\
# 		 ; ${sg{PASSWDLINE}{\\N([^:]+:)(.*)\\N}{\\$2}}\"
# .endif
#
"))


(define main
  (cons* main-local-paths
         main-local-macros
         main-exim-config-listmacrosdef
         main-exim-config-options
         main-exim-config-tlsoptions
         ;; main-exim-config-ciphers
         main-exim-config-log-selector
         acl-exim-config-header
         acl-exim-config-local-deny-exceptions
         acl-exim-config-check-mail
         acl-exim-config-check-rcpt
         acl-exim-config-check-data
         router-exim-config-header
         router-exim-config-domain-literal
         router-exim-config-hubbed-hosts
         router-exim-config-primary
         router-exim-config-real-local
         router-exim-config-system-aliases
         router-exim-config-hubuser
         router-exim-config-userforward
         router-exim-config-procmail
         router-exim-config-maildrop
         router-exim-config-lowuid
         router-exim-config-local-user
         router-exim-config-mail4root
         transport-exim-config-header
         transport-exim-config-transport-macros
         transport-exim-config-address-file
         transport-exim-config-address-pipe
         transport-exim-config-address-reply
         transport-exim-config-maildir-home
         ;transport-exim-config-maildrop-pipe
         transport-exim-config-mail-spool
         ;transport-exim-config-procmail-pipe
         transport-exim-config-remote-smtp
         transport-exim-config-remote-smtp-smarthost
         transport-exim-config-address-directory
         retry-exim-config-header
         retry-exim-config
         rewrite-exim-config-header
         rewrite-exim-config-rewriting
         auth-exim-config-header
         auth-exim-config-cram-md5
         auth-exim-config-examples
         '()))

(define (generate-config port config sections)
  (cond ((null? sections) #f)
        (else (begin
                (display ((car sections) port config))
                (generate-config port test-config (cdr sections))))))


;(define test-config
;  (dc-exim-config
;   (configtype 'satellite)
;   (hostname ".ghic.org")
;   (readhost "ghic.org")
;   (smarthost "chaos.caltech.edu:587")
;   (hide-mailname #t)
;   (localdelivery 'maildir-home)))

(define (generate-exim-config port config)
  (generate-config #f config main))


(define (dc-exim-computed-config-file package config)
  (computed-file "exim.conf"
                 #~(call-with-output-file #$output
                     (lambda (port)
                       (generate-eximconfig prot config)))))


(define dc-exim-shepherd-service
  (match-lambda
   (($ <dc-exim-configuration> configtype
                               hostname
                               other-hostnames
                               local-interface
                               readhost
                               relay-domains
                               minimaldns
                               relay-nets
                               smarthost
                               hide-mailname
                               package)
     (list (shepherd-service
            (provision '(exim mta))
            (documentation "Run the exim daemon with Debian like configuration file.")
            (requirement '(networking))
            (start #~(make-forkexec-constructor
                      '(#$(file-append package "/bin/exim")
                        "-bd" "-v" "-C"
                        #$(dc-exim-computed-config-file package config-file))))
            (stop #~(make-kill-destructor)))))))


(define dc-exim-service-type
  (service-type
   (name 'dc-exim)
   (extensions
    (list (service-extension shepherd-root-service-type dc-exim-shepherd-service)
          (service-extension account-service-type (const %exim-accounts))
          (service-extension activation-service-type exim-activation)
          (service-extension profile-service-type exim-profile)
          (service-extension mail-aliases-service-type (const '()))))))

