;;;; $Id: cl-syslog.asd,v 1.2 2003/11/22 23:32:54 eenge Exp $
;;;; $Source: /project/cl-syslog/cvsroot/cl-syslog/cl-syslog.asd,v $

;;;; See the LICENSE file for licensing information.

(in-package #:cl-user)

(defpackage #:cl-syslog-system
    (:use #:cl #:asdf)
  (:documentation "Package to create the ASDF system for the cl-syslog
package"))

(in-package #:cl-syslog-system)

(defsystem cl-syslog
    :name "cl-syslog"
    :author "Erik Enge"
    :version "0.1.0"
    :licence "MIT"
    :description "Common Lisp syslog interface"
    :depends-on (:uffi)
    :properties ((#:author-email . "erik@nittin.net")
                 (#:date . "$Date: 2003/11/22 23:32:54 $")
                 ((#:albert #:output-dir) . "doc/api-doc/")
                 ((#:albert #:formats) . ("docbook"))
                 ((#:albert #:docbook #:template) . "book")
                 ((#:albert #:docbook #:bgcolor) . "white")
                 ((#:albert #:docbook #:textcolor) . "black"))
    :components ((:file "package")
                 (:file "variable"
                        :depends-on ("package"))
                 (:file "cl-syslog"
                        :depends-on ("variable"))))
                 
