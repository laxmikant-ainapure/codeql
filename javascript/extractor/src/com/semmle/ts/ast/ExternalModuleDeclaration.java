package com.semmle.ts.ast;

import java.util.List;

import com.semmle.js.ast.Literal;
import com.semmle.js.ast.SourceLocation;
import com.semmle.js.ast.Statement;
import com.semmle.js.ast.Visitor;

/**
 * A statement of form <tt>declare module "X" {...}</tt>.
 */
public class ExternalModuleDeclaration extends Statement {
	private final Literal name;
	private final List<Statement> body;

	public ExternalModuleDeclaration(SourceLocation loc, Literal name, List<Statement> body) {
		super("ExternalModuleDeclaration", loc);
		this.name = name;
		this.body = body;
	}

	@Override
	public <C, R> R accept(Visitor<C, R> v, C c) {
		return v.visit(this, c);
	}

	public Literal getName() {
		return name;
	}

	public List<Statement> getBody() {
		return body;
	}
}
