;;;; $Id: cl-syslog.lisp,v 1.1 2003/11/13 18:32:45 eenge Exp $
;;;; $Source: /project/cl-syslog/cvsroot/cl-syslog/cl-syslog.lisp,v $

;;;; See the LICENSE file for licensing information.

(in-package :syslog)

;;
;; Condition
;;

(define-condition invalid-facility (error)
  ((facility
    :reader facility
    :initarg :facility))
  (:report (lambda (condition stream)
             (format stream "Invalid facility ~A." (facility condition)))))

(define-condition invalid-priority (error)
  ((priority
    :reader priority
    :initarg :priority))
  (:report (lambda (condition stream)
             (format stream "Invalid priority ~A." (priority condition)))))

;;
;; Foreign function
;;

(uffi:def-function "openlog"
    ((ident :cstring)
     (option :int)
     (facility :int))
  :returning :void)

(uffi:def-function "closelog"
    ()
  :returning :void)

(uffi:def-function "syslog"
    ((priority :int)
     (format :cstring))
  :returning :void)

;;
;; Utility
;;

(defun get-facility (facility-name)
  (ash (or (cdr (assoc facility-name *facilities*))
           (error (make-condition 'invalid-facility :facility facility-name)))
       3))

(defun get-priority (priority-name)
  (or (cdr (assoc priority-name *priorities*))
      (error (make-condition 'invalid-priority :priority priority-name))))

;;
;; Log function
;;

(defun log (name facility priority text &optional (option 0))
  "Print message to syslog.

'option' can be any of the +log...+ constants"
  (openlog name option (get-facility facility))
  (syslog (get-priority priority) text)
  (closelog)
  text)
