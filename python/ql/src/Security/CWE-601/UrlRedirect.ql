/**
 * @name URL redirection from remote source
 * @description URL redirection based on unvalidated user input
 *              may cause redirection to malicious web sites.
 * @kind problem
 * @problem.severity error
 * @sub-severity low
 * @id py/url-redirection
 * @tags security
 *       external/cwe/cwe-601
 * @precision high
 */

import python


import semmle.python.web.HttpRedirect
import semmle.python.web.HttpRequest
import semmle.python.security.strings.Untrusted

/** Url redirection is a problem only if the user controls the prefix of the URL */
class UntrustedPrefixStringKind extends UntrustedStringKind {

    override TaintKind getTaintForFlowStep(ControlFlowNode fromnode, ControlFlowNode tonode) {
        result = UntrustedStringKind.super.getTaintForFlowStep(fromnode, tonode) and
        not tonode.(BinaryExprNode).getRight() = fromnode
    }

}

from TaintSource src, TaintSink sink
where src.flowsToSink(sink)

select sink, "Untrusted URL redirection due to $@.", src, "a user-provided value"

