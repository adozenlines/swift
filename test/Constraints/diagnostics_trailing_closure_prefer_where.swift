//
//  diagnostics_trailing_closure_prefer_where.swift
//  
//
//  Created by Sean Batson on 2025-09-26.
//


// RUN: %target-typecheck-verify-swift

func f(_ xs: [Int]) {
  _ = xs.first { x in
    _ = x.nonexistent  // expected-error {{value of type 'Int' has no member 'nonexistent'}}
  } // expected-note {{did you mean 'first(where:)'?}}
}

// Control: still diagnose property-called-as-function when that is really the case.
func g(_ opt: Int?) {
  opt(42) // expected-error {{cannot call value of non-function type 'Int?'}}
}