//
//  diagnostics_first_where_fixit.swift
//  
//
//  Created by Sean Batson on 2025-09-26.
//


// RUN: %target-typecheck-verify-swift

func h(_ xs: [String]) {
  _ = xs.first { s in
    s.count > 0 && s.bogus == "x" // expected-error {{value of type 'String' has no member 'bogus'}}
  } // expected-note {{did you mean 'first(where:)'?}}
}